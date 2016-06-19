submodules:
	git submodule init
	git submodule update
submodules-reset:
	git submodule deinit .
	$(MAKE) submodules
