

#优先编译库

all:target_krnln target_spec target_esc_compile target_runtime

target_krnln:
	$(MAKE) -C ./src/krnln

target_spec:
	$(MAKE) -C ./src/spec
	
target_esc_compile:
	$(MAKE) -C ./src/esc_compile

target_runtime:
	$(MAKE) -C ./src/runtime

clean:
	$(MAKE) -C ./src/krnln clean
	
	$(MAKE) -C ./src/spec clean
	
	$(MAKE) -C ./src/esc_compile clean
	
	$(MAKE) -C ./src/runtime clean
