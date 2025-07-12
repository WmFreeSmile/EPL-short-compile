
#include Once "windows.bi"

extern "c"

declare function EStartup() as integer

declare sub krnl_MExitProcess cdecl(nExitCode as long)

type ELIBINFO
	dwLibFormatVer as ulong
	szGuid as zstring ptr
	nMajorVersion as long
	nMinorVersion as long
	nBuildNumber as long
	nRqSysMajorVer as long
	nRqSysMinorVer as long
	nRqSysKrnlLibMajorVer as long
	nRqSysKrnlLibMinorVer as long
	szName as zstring ptr
end type


type LPELIBINFO as ELIBINFO ptr

type EAPPINFO
	nEAppMajorVersion as long
	nEAppMinorVersion as long
	nEAppBuildNumber as long
	lpfnEcode as any ptr
	lpEConst as any ptr
	lpVoid0 as any ptr
	lpEForm as any ptr
	uVoid0 as ulong
	uELibInfoCount as ulong
	lpELibInfos as LPELIBINFO ptr
	uEDllImportCount as ulong
	lpEDllNames as zstring ptr ptr
	lpEDllSymbols as zstring ptr ptr
end type

type EContext
	ExitCallBack as any ptr
	
	InstanceHandle as HANDLE
	PESizeOfImage as ulong
	PEAddrrStart as ulong
	PEAddrrEnd as ulong
	
	Heap as HANDLE
end type


type DATE_TYPE as double

type STATMENT_CALL_DATA
	m_dwStatmentSubCodeAdr as long
	m_dwSubEBP as long
end type

type PSTATMENT_CALL_DATA as STATMENT_CALL_DATA ptr

type MUNIT
	m_dwFormID as long
	m_dwUnitID as long
end type

type PMUNIT as MUNIT ptr


type DATA_TYPE as long

type MDATA_INF field=1
	union
		m_byte as ubyte
		m_short as short
		m_int as long
		m_int64 as longint
		m_float as single
		m_double as double
		m_date as DATE_TYPE
		m_bool as BOOL
		m_pText as zstring ptr
		
		m_pBin as ubyte ptr
		m_dwSubCodeAdr as any ptr
		m_statment as STATMENT_CALL_DATA
		m_unit as MUNIT
		m_pCompoundData as any ptr
		m_pAryData as any ptr
		
		m_pByte as ubyte ptr
		m_pShort as short ptr
		m_pInt as long ptr
		m_pInt64 as longint ptr
		m_pFloat as single ptr
		m_pDouble as double ptr
		m_pDate as DATE_TYPE ptr
		m_pBool as BOOL ptr
		m_ppText as zstring ptr ptr
		
		m_ppBin as ubyte ptr ptr
		
		m_pdwSubCodeAdr as any ptr ptr
		
		m_pStatment as PSTATMENT_CALL_DATA
		m_pUnit as PMUNIT
		
		m_ppCompoundData as any ptr ptr
		m_ppAryData as any ptr ptr
	end union
	m_dtDataType as DATA_TYPE
end type

type PMDATA_INF as MDATA_INF ptr



'extern __eapp_info As EAPPINFO

end extern




#define	DT_IS_ARY					&H20000000

#define	DT_IS_VAR					&H20000000

#define		_SDT_NULL		  0

#define		_SDT_ALL	   	MAKELONG (MAKEWORD (0, 0), &H8000)

#define		SDT_BYTE		  MAKELONG (MAKEWORD (1, 1), &H8000)
#define		SDT_SHORT		  MAKELONG (MAKEWORD (1, 2), &H8000)
#define		SDT_INT			  MAKELONG (MAKEWORD (1, 3), &H8000)
#define		SDT_INT64		  MAKELONG (MAKEWORD (1, 4), &H8000)
#define		SDT_FLOAT		  MAKELONG (MAKEWORD (1, 5), &H8000)
#define		SDT_DOUBLE	  MAKELONG (MAKEWORD (1, 6), &H8000)
#define		SDT_BOOL		  MAKELONG (MAKEWORD (2, 0),	&H8000)
#define		SDT_DATE_TIME	MAKELONG (MAKEWORD (3, 0),	&H8000)
#define		SDT_TEXT		  MAKELONG (MAKEWORD (4, 0),	&H8000)
#define		SDT_BIN			  MAKELONG (MAKEWORD (5, 0),	&H8000)
#define		SDT_SUB_PTR		MAKELONG (MAKEWORD (6, 0),	&H8000)
#define		SDT_STATMENT	MAKELONG (MAKEWORD (8, 0),	&H8000)

#define DTT_IS_NULL_DATA_TYPE   0
#define DTT_IS_SYS_DATA_TYPE    1
#define DTT_IS_USER_DATA_TYPE   2
#define DTT_IS_LIB_DATA_TYPE    3


'// 用作区分系统类型、用户自定义类型、库定义数据类型
#define	DTM_SYS_DATA_TYPE_MASK		&h80000000
#define	DTM_USER_DATA_TYPE_MASK		&h40000000
#define	DTM_LIB_DATA_TYPE_MASK		&h00000000




extern AppContext as EContext ptr



declare sub InitContext()
declare sub FreeContext()
declare sub GetPESizeOfImage()


declare function GetAryElementInf(pAryData as any ptr,pnElementCount as long ptr) as ubyte ptr
declare function GetDataTypeType(dtDataType as DATA_TYPE) as long
declare function Host_Malloc(size as ulong) as any ptr
declare sub Host_Free(addr as any ptr)
declare function Host_Realloc(addr as any ptr,size as ulong) as any ptr

declare sub ReportError(text as string)