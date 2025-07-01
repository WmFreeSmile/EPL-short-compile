#include once "windows.bi"
#include Once "win/imagehlp.bi"
#include once "fbc-int/array.bi"

declare sub main()

main()

enum CompileModeEnum
    normal
    exe
    dll
end enum


enum FileTypeEnum
    source=1
    module=3
end enum

enum CompileTypeEnum
    WindowsWindowProgram=0
    WindowsConsoleProgram=1
    WindowsDynamicLinkLibrary=2
    WindowsModule=1000
    LinuxConsoleProgram=10000
    LinuxModule=11000
end enum

'子系统
enum SubSystemEnum
    windows
    console
end enum

type EFunc
    func_name as string
    is_public as boolean
end type

'易源码格式体
type EStrct
    FileType as FileTypeEnum
    CompileType as CompileTypeEnum
    
    EFunc(any) as EFunc
    
    SupportLibrary(any) as string
end type

sub help()
    print "esc_compile tool 0.0"
    print "Usage: esc_compile [options] file..."
    print "Options:"
    print "  -?, -h, --help                                                Display this information"
    print "  -o, --out <file>                                              Set target file"
    print "  --normal                                                      Select compilation mode based on source files (default)"
    print "  --exe                                                         Compile into application mode"
    print "  --dll                                                         Compile to dynamic library mode"
    print "  --retain_intermediate_files+ | --retain_intermediate_files-   Enable or disable the retention of intermediate files (default: disable)"
    
    print "Examples:"
    print "  eg. Show help"
    print "      esc_compile -?"
    print "  eg. Compile test.e to test.exe"
    print "      esc_compile test.e -o test.exe"
    print "  eg. Compile test.e to test.exe and keep intermediate files"
    print "      esc_compile test.e -o test.exe --retain_intermediate_files"
    print "  eg. Compile test.e to test.dll"
    print "      esc_compile test.e -o test.dll"
end sub


'获取文件扩展名，就是小数点后面的
Function GetFileExtendName(szPath As String) As String
    Dim a As Integer 
    a = InStrRev(szPath, Any ".\/:")
    If a=0 Then
       Function=""
   Else
       If szPath[a -1] = 46 Then 
           Function = Mid(szPath, a + 1) 
       Else
           Function = ""    
       End If  
       
    End If 
End Function

'文件是否存在
function IsFileExist(file as string) as boolean
    dim hFind as HANDLE
    dim FindData as WIN32_FIND_DATAA
    hFind=FindFirstFileA(file,@FindData)
    if hFind=INVALID_HANDLE_VALUE then return false
    FindClose(hFind)
    function=(FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY)=0
end function

'读入文件
Function LoadFile(ByRef filename As String,buffer() as ubyte) as boolean
    Dim h As Integer
    h = FreeFile
    If Open( filename For Binary Access Read As #h ) <> 0 Then Return false
    If LOF(h) > 0 Then
        redim buffer(LOF(h)-1)
        If Get( #h, ,buffer() ) <> 0 Then return false
    End If
    Close #h
    function=true
End Function

'写到文件
Sub SaveFile(filename As String, buffer() As ubyte)
    Dim h As Integer
    h = FreeFile
    If Open(filename For Binary As #h) <> 0 Then Return
    
    Put #h,, buffer()
    Close #h
End Sub

sub Decode_Str(data_ as ubyte ptr,data_len as integer,key as ubyte ptr,key_len as integer)
    dim key_i as long=1
    for i as integer=0 to data_len-1
        data_[i]=data_[i] xor key[key_i mod key_len]
        key_i+=1
    next
end sub

'易格式转储
function EFileDump(file as string) as EStrct
    dim Buffer(any) as ubyte
    dim pBuffer as ubyte ptr
    dim nLen as uinteger
    
    dim array_index as integer
    
    dim temp_len as long
    dim temp_count as short
    dim temp(any) as ubyte
    
    dim result as EStrct
    
    if LoadFile(file,Buffer())=false then return result
    
    pBuffer=@Buffer(lbound(Buffer))
    nLen=FB.ArrayLen(Buffer())
    
    dim index as uinteger
    
    dim section_key(any) as ubyte
    dim section_name(any) as ubyte
    
    index+=4'magic1
    index+=4'magic2
    
    while index<=nLen
        index+=4'magic
        
        index+=4'Info_CheckSum
        
        redim section_key(0 to 3)
        memcpy(@section_key(lbound(section_key)),pBuffer+index,4)
        index+=4'key
        
        redim section_name(0 to 29)
        memcpy(@section_name(lbound(section_name)),pBuffer+index,30)
        index+=30'name
        
        if section_key(0)<>25 orelse section_key(1)<>115 orelse section_key(2)<>0 orelse section_key(3)<>7 then
            Decode_Str(@section_name(lbound(section_name)),30,@section_key(lbound(section_key)),4)
        end if
        
        if *cast(zstring ptr,@section_name(lbound(section_name)))="" then
            exit while
        end if
        
        index+=2'reserve_fill_1
        index+=4'Index
        index+=4'Flag1
        index+=4'Data_CheckSum
        
        dim DataLength as long
        DataLength=*cast(long ptr,pBuffer+index)
        
        index+=4'DataLength
        
        index+=40'reserve_item
        
        dim pData2 as ubyte ptr=pBuffer+index
        dim index2 as uinteger=0
        
        '系统信息段
        if *cast(zstring ptr,@section_name(lbound(section_name)))=!"\207\181\205\179\208\197\207\162\182\206\0" then
            index2+=2'编译版本1
            index2+=2'编译版本2
            index2+=4'Unknow_1
            index2+=4'Unknow_2
            index2+=4'未知类型
            
            result.FileType=*cast(long ptr,pData2+index2)
            index2+=4'文件类型
            index2+=4'Unknow_3
            
            result.CompileType=*cast(long ptr,pData2+index2)
            index2+=4'编译类型
            
            index2+=32'Unknow_9
            
        '程序段
        elseif *cast(zstring ptr,@section_name(lbound(section_name)))=!"\179\204\208\242\182\206\0" then
            index2+=4'VerFlag1
            index2+=4'Unk1
            
            temp_len=*cast(long ptr,pData2+index2)
            index2+=4'Unk2_1'len
            index2+=temp_len'Unk2_1
            
            temp_len=*cast(long ptr,pData2+index2)
            index2+=4'Unk2_2'len
            index2+=temp_len'Unk2_2
            
            temp_len=*cast(long ptr,pData2+index2)
            index2+=4'Unk2_3'len
            index2+=temp_len'Unk2_3
            
            temp_count=*cast(short ptr,pData2+index2)
            index2+=2'支持库信息'count
            for i as integer=1 to temp_count
                temp_len=*cast(long ptr,pData2+index2)
                index2+=4
                
                redim temp(temp_len)
                memcpy(@temp(lbound(temp)),pData2+index2,temp_len)
                temp(temp_len)=0
                
                
                array_index=ubound(result.SupportLibrary)+1
                redim preserve result.SupportLibrary(array_index)
                
                result.SupportLibrary(array_index)=trim(*cast(zstring ptr,@temp(lbound(temp))))
                
                index2+=temp_len'支持库文本信息
            next
            
            dim Flag1 as long=*cast(long ptr,pData2+index2)
            index2+=4'Flag1
            index2+=4'Flag2
            
            if Flag1 and 1<>0 then
                index+=16'Unk3_Op
            end if
            
            temp_len=*cast(long ptr,pData2+index2)
            index2+=4'ICO图标'len
            index2+=temp_len'ICO图标
            
            temp_len=*cast(long ptr,pData2+index2)
            index2+=4'调试命令行'len
            index2+=temp_len'调试命令行
            
            temp_len=*cast(long ptr,pData2+index2)
            index2+=4'段头'len
            index2+=temp_len'段头
            
            '程序段_程序集
            for i as integer=1 to temp_len\8
                index2+=4'Unk1
                index2+=4'基类
                
                temp_len=*cast(long ptr,pData2+index2)
                index2+=4
                index2+=temp_len'名称
                
                temp_len=*cast(long ptr,pData2+index2)
                index2+=4
                index2+=temp_len'备注
                
                temp_len=*cast(long ptr,pData2+index2)
                index2+=4
                index2+=temp_len'函数组标志
                
                '程序段_变量_数据
                index2+=4'VarDataCount
                
                dim nData3Len as long=*cast(long ptr,pData2+index2)
                index2+=4
                
                index2+=nData3Len
            next
            
            temp_len=*cast(long ptr,pData2+index2)
            index2+=4'段头'len
            index2+=temp_len'段头
            '程序段_函数
            
            for i as integer=1 to temp_len\8
                array_index=ubound(result.EFunc)+1
                redim preserve result.EFunc(array_index)
                
                index2+=4'类型
                
                if *cast(long ptr,pData2+index2)=8 then
                    result.EFunc(array_index).is_public=true
                end if
                index2+=4'属性
                
                index2+=4'返回类型
                
                temp_len=*cast(long ptr,pData2+index2)
                index2+=4
                
                redim temp(temp_len)
                memcpy(@temp(lbound(temp)),pData2+index2,temp_len)
                temp(temp_len)=0
                
                result.EFunc(array_index).func_name=*cast(zstring ptr,@temp(lbound(temp)))
                
                index2+=temp_len'名称
                
                temp_len=*cast(long ptr,pData2+index2)
                index2+=4
                index2+=temp_len'备注
                
                index2+=4'程序段_变量_数据'count
                
                temp_len=*cast(long ptr,pData2+index2)
                index2+=4
                index2+=temp_len'程序段_变量_数据
                
                index2+=4'程序段_参数_数据'count
                
                temp_len=*cast(long ptr,pData2+index2)
                index2+=4
                index2+=temp_len'程序段_参数_数据
                
                temp_len=*cast(long ptr,pData2+index2)
                index2+=4
                index2+=temp_len'数据1
                
                temp_len=*cast(long ptr,pData2+index2)
                index2+=4
                index2+=temp_len'数据2
                
                temp_len=*cast(long ptr,pData2+index2)
                index2+=4
                index2+=temp_len'数据3
                
                temp_len=*cast(long ptr,pData2+index2)
                index2+=4
                index2+=temp_len'数据4
                
                temp_len=*cast(long ptr,pData2+index2)
                index2+=4
                index2+=temp_len'数据5
                
                temp_len=*cast(long ptr,pData2+index2)
                index2+=4
                index2+=temp_len'代码
                
            next
            
        end if
        
        index+=DataLength
    wend
    
    return result
end function



sub main()
    dim HINSTANCE_value as HINSTANCE
    dim Path as string
    dim EXEname as string
    
    #if __FB_OUT_EXE__
        HINSTANCE_value = GetModuleHandle(NULL)
    #else
        Dim mbi as MEMORY_BASIC_INFORMATION
        VirtualQuery(@main, @mbi, SizeOf(mbi))
        HINSTANCE_value = mbi.AllocationBase
    #endif
    
    Dim zTemp As ZString * MAX_PATH
    Dim x     As Long
    GetModuleFileNameA(HINSTANCE_value, zTemp, MAX_PATH)
    x = InStrRev(zTemp, Any ":/\")
    If x Then
        Path    = Left(zTemp, x)
        EXEname = Mid(zTemp, x + 1)
    Else
        Path    = ""
        EXEname = zTemp
    End If
    
    
    if len(command(-1))=0 Then
        help()
        end
    end if
    
    
    
    dim target as string
    dim full_target as string
    dim source as string
    dim full_source as string
    
    dim CompileMode as CompileModeEnum=CompileModeEnum.normal
    
    dim dllmain as boolean=false
    dim retain_intermediate_files as boolean=false
    
    Dim index As integer
    Dim arg As string
    dim now_arg as string
    
    index = 1
    Do
        arg = command( index )
        If len(arg)=0 orelse arg=chr(127) then
            Exit Do
        End If
        
        now_arg=arg
        If arg="-?" orelse arg="-h" orelse arg="--help" then
            help()
            end
        elseif arg="-o" orelse arg="--out" then
            index += 1
            arg = command(index)
            
            if arg="" then
                print "error: Missing necessary parameters"
                end(1)
            end if
            
            target=arg
            
        elseif arg="--normal" then
            CompileMode=CompileModeEnum.normal
            
        elseif arg="--exe" then
            CompileMode=CompileModeEnum.exe
            
        elseif arg="--dll" then
            CompileMode=CompileModeEnum.dll
            
        elseif arg="--retain_intermediate_files+" orelse arg="--retain_intermediate_files" then
            retain_intermediate_files=true
        elseif arg="--retain_intermediate_files-" then
            retain_intermediate_files=false
        else
            if len(source)<>0 then
                print "error: Do not specify multiple source files"
                end(1)
            end If
            
            source=arg
        End If
        index += 1
    Loop
    
    if len(source)=0 then
        print "error: Source file must be specified"
        end(1)
    end if
    
    if len(target)=0 then
        print "error: Target file must be specified"
        end(1)
    end if
    
    full_target=space(MAX_PATH)
    GetFullPathNameA(target,MAX_PATH,strptr(full_target),0)
    full_target=trim(full_target)
    
    kill(full_target)
    
    MakeSureDirectoryPathExists(full_target)
    
    
    full_source=space(MAX_PATH)
    GetFullPathNameA(source,MAX_PATH,strptr(full_source),0)
    full_source=trim(full_source)
    
    if IsFileExist(full_source)=false then
        print "error: The source file does not exist"
        end(1)
    end if
    
    dim obj_path as string
    dim compile_command as string
    
    obj_path=Left(full_target,Len(full_target)-Len(GetFileExtendName(full_target))-1)+".obj"
    
    compile_command=!"eplc \""+full_source+!"\" /o \""+obj_path+!"\" /obj /dll"
    print compile_command
    if system_(compile_command)<>0 then
        print "error: Compilation command failed to run"
        end(1)
    end if
    
    
    '将易源码格式识别出来
    dim File_EStrct as EStrct=EFileDump(full_source)
    
    dim lib_krnln as boolean
    dim lib_spec as boolean
    
    for i as integer=lbound(File_EStrct.SupportLibrary) to ubound(File_EStrct.SupportLibrary)
        'print File_EStrct.SupportLibrary(i)
        'print len(File_EStrct.SupportLibrary(i))
        
        /'
        for j as integer=0 to len(File_EStrct.SupportLibrary(i))-1
            print cast(ubyte ptr,strptr(File_EStrct.SupportLibrary(i)))[j];",";
        next
        '/
        
        select case File_EStrct.SupportLibrary(i)
            case !"krnln\rd09f2340818511d396f6aaf844c7e325\r5\r7\r\207\181\205\179\186\203\208\196\214\167\179\214\191\226"
                lib_krnln=true
            case !"spec\rA512548E76954B6E92C21055517615B0\r3\r1\r\204\216\202\226\185\166\196\220\214\167\179\214\191\226"
                lib_spec=true
        end select
    next
    
    dim subsystem as SubSystemEnum
    '决定窗口是否带有控制台
    
    if CompileMode=normal then
        select case File_EStrct.CompileType
            case WindowsWindowProgram,WindowsModule,LinuxModule'窗口程序
                CompileMode=exe
                subsystem=windows
            case WindowsConsoleProgram,LinuxConsoleProgram'控制台程序
                CompileMode=exe
                subsystem=console
            case WindowsDynamicLinkLibrary'动态链接库
                CompileMode=dll
        end select
    end if
    
    for i as integer=lbound(File_EStrct.EFunc) to ubound(File_EStrct.EFunc)
        if File_EStrct.EFunc(i).func_name="EDllMain" andalso File_EStrct.EFunc(i).is_public then
            dllmain=true
        end if
    next
    
    dim def_path as string
    
    compile_command=""
    
    select case CompileMode
        case exe
            compile_command=!"ld -m i386pe --stack 1048576,1048576 -s "
            
            select case subsystem
                case windows
                    compile_command=compile_command+"-subsystem windows "
                case console
                    compile_command=compile_command+"-subsystem console "
            end select
            
            compile_command=compile_command+!"-o \""+full_target+!"\" " + _
                !"\""+obj_path+!"\" "+ _
                !"\""+Path+"lib\dll_call.o"+!"\" "+ _
                iif(lib_krnln,!"\""+Path+"lib\krnln.lib"+!"\" ","")+ _ '感觉怪怪的，不管了
                iif(lib_spec,!"\""+Path+"lib\spec.lib"+!"\" ","")+ _
                !"-T \""+Path+"lib\fbextra.x"+!"\" "+ _
                !"\""+Path+"lib\crt2.o"+!"\" "+ _
                !"-L \""+Path+"lib"+!"\" "+ _
                !"\"-(\" "+ _
                "-lkernel32 -lgdi32 -lmsimg32 -luser32 -lversion -ladvapi32 -limm32 -lshell32 -lole32 -luuid -loleaut32 -lcomctl32 -luxtheme -lpsapi -lcomdlg32 -lshlwapi -lwinmm -lddraw -ldxguid -lgdiplus -lfb -lgcc -lmsvcrt -lmingw32 -lmingwex -lmoldname -lgcc_eh "+ _
                !"\"-)\""
        case dll
            '生成 def 文件
            dim def as string
            dim def_buffer(any) as ubyte
            def_path=Left(full_target,Len(full_target)-Len(GetFileExtendName(full_target))-1)+".def"
            
            def=!"EXPORTS\r\n"
            
            for i as integer=lbound(File_EStrct.EFunc) to ubound(File_EStrct.EFunc)
                if File_EStrct.EFunc(i).is_public andalso File_EStrct.EFunc(i).func_name<>"EDllMain" then
                    def=def+!"\t"+File_EStrct.EFunc(i).func_name+!"\r\n"
                end if
            next
            
            redim def_buffer(len(def)-1)
            for i as integer=lbound(def_buffer) to ubound(def_buffer)
                def_buffer(i)=cast(ubyte ptr,strptr(def))[i]
            next
            
            kill(def_path)
            SaveFile(def_path,def_buffer())
            
            compile_command=!"ld -m i386pe --dll --stack 1048576,1048576 -s "+ _
                !"-o \""+full_target+!"\" " + _
                !"\""+obj_path+!"\" "+ _
                !"\""+def_path+!"\" "+ _
                iif(dllmain,!"\""+Path+"lib\dll.o"+!"\" ",!"\""+Path+"lib\dll_nomain.o"+!"\" ")+ _
                !"\""+Path+"lib\dll_call.o"+!"\" "+ _
                iif(lib_krnln,!"\""+Path+"lib\krnln.lib"+!"\" ","")+ _ '感觉怪怪的，不管了
                iif(lib_spec,!"\""+Path+"lib\spec.lib"+!"\" ","")+ _
                !"-T \""+Path+"lib\fbextra.x"+!"\" "+ _
                !"\""+Path+"lib\dllcrt2.o"+!"\" "+ _
                !"-L \""+Path+"lib"+!"\" "+ _
                !"\"-(\" "+ _
                "-lkernel32 -lgdi32 -lmsimg32 -luser32 -lversion -ladvapi32 -limm32 -lshell32 -lole32 -luuid -loleaut32 -lcomctl32 -luxtheme -lpsapi -lcomdlg32 -lshlwapi -lwinmm -lddraw -ldxguid -lgdiplus -lfb -lgcc -lmsvcrt -lmingw32 -lmingwex -lmoldname -lgcc_eh "+ _
                !"\"-)\""
            
    end select
    
    print compile_command
    if system_(compile_command)<>0 then
        print "error: Link command failed to run"
        end(1)
    end if
    
    if retain_intermediate_files=false then
        if CompileMode=dll then
            kill(def_path)
        end if
        kill(obj_path)
    end if
    
end sub
