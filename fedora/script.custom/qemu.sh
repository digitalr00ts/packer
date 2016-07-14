#!/bin/bash -eux

if [[ $PACKER_BUILDER_TYPE =~ qemu]]; then
    echo "==> Installing QEMU guest additions"
    # Assume that we've installed all the prerequisites:
    # kernel-headers-$(uname -r) kernel-devel-$(uname -r) gcc make perl
    # from the install media via ks.cfg
    # Except on Fedora 22 (which uses dnf)
    if [ "${PKG_MGR}" == "dnf" ]; then
        #${PKG_MGR} -y install kernel-headers-$(uname -r) kernel-devel-$(uname -r) gcc make perl
        ${PKG_MGR} -y install qemu-guest-agent spice-vdagent
    fi

    #echo "==> Removing packages needed for building guest tools"
    #${PKG_MGR} -y remove gcc cpp kernel-devel kernel-headers perl
fi
