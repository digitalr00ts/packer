TYPE ?= virtualbox-iso
VER ?= 1404
DIST ?= ubuntu
USER ?= DIGITALR00TS

.PHONY: fedora ubuntu submodules submodules-reset clean validate

.DEFAULT_GOAL = build

submodules:
	git submodule init
	git submodule update

submodules-reset:
	@git submodule deinit --force .
	$(MAKE) submodules

clean:
	@$(MAKE) clean --directory=fedora
	@$(MAKE) clean --directory=fedora.boxcutter
	@$(MAKE) clean --directory=ubuntu
	@$(MAKE) clean --directory=ubuntu.boxcutter

validate:
	@for dir in {'fedora','ubuntu'}; do \
	  cd $$dir 1>/dev/null; \
	  pwd; \
	  for tpl in $$(find . -name \*.json); do \
	    echo "[ $$tpl ]"; \
	    packer validate "$$tpl"; \
	    echo; \
	  done; \
	  cd - 1>/dev/null; \
	done

fedora:
	@cd fedora;\
	packer build -only=${TYPE}-iso -var-file=fedora${VER}.json fedora.json

ubuntu:
	@cd ubuntu;\
	packer build -only=${TYPE}-iso -var-file=ubuntu${VER}.json ubuntu.json

build:
	#@ATLAS_TOKEN="$(cat api.token)" ;
	@cd ${DIST};\
	packer build -only=${TYPE} -var-file=${DIST}${VER}.json ${DIST}.json

push:
	#DOES NOT WORK
	@cd ${DIST};\
	packer push -token=$(cat ../api.token) -name=${USER}/${DIST}${VER} -var-file=${DIST}${VER}.json ${DIST}.json
