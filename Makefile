TYPE ?= virtualbox
VER ?= 1404

.PHONY: fedora ubuntu submodules submodules-reset clean
.DEFAULT_GOAL = ubuntu

submodules:
	git submodule init
	git submodule update

submodules-reset:
	@git submodule deinit --force .
	$(MAKE) submodules

clean:
	@$(MAKE) clean --directory=fedora.boxcutter
	@$(MAKE) clean --directory=ubuntu.boxcutter

fedora:
	@cd fedora
	packer build -only=${TYPE}-iso -var-file=fedora${VER}.json fedora.json

ubuntu:
	@cd ubuntu
	packer build -only=${TYPE}-iso -var-file=ubuntu${VER}.json ubuntu.json
