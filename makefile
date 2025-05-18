

all:target_krnln target_sample target_sample_dll

target_krnln:
	$(MAKE) -C krnln

target_sample:
	$(MAKE) -C sample
	
target_sample_dll:
	$(MAKE) -C sample_dll

clean:
	$(MAKE) -C krnln clean
	$(MAKE) -C sample clean
	$(MAKE) -C sample_dll clean
