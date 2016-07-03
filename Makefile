submodules:
	git submodule init
	git submodule update
submodules-reset:
	git submodule deinit --force .
	$(MAKE) submodules

clean:
	$(MAKE) clean --directory=fedora.boxcutter
	$(MAKE) clean --directory=ubuntu.boxcutter
