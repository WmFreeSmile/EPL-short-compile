


all:target_krnln ./def_process.exe ./del_drectve.exe ./obj_process.exe ./void.exe target_sample target_sample_dll

target_krnln:
	$(MAKE) -C krnln

./def_process.exe ./del_drectve.exe ./obj_process.exe ./void.exe:./def_process.e ./del_drectve.e ./obj_process.e ./void.e
	build_etools
	

target_sample:
	$(MAKE) -C sample
	
target_sample_dll:
	$(MAKE) -C sample_dll

clean:
	$(MAKE) -C krnln clean
	$(MAKE) -C sample clean
	$(MAKE) -C sample_dll clean
	
	del .\def_process.exe
	del .\del_drectve.exe
	del .\obj_process.exe
	del .\void.exe
