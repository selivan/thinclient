# DESCRIPTION
This set of scripts is intended to create GNU/Linux image, that can be booted via network and run from memory, without mounting rootfs via NFS/iSCSI/CIFS/..., like [this](https://help.ubuntu.com/community/DisklessUbuntuHowto). Based on Debian/Ubuntu.

# FEATURES
 * Easyly add any software from reach Debian/Ubuntu repositories: browser, recorder for video cam, media player, etc. This is not so easy for thin clients, using their own package base, like [ThinStation](http://sourceforge.net/apps/mediawiki/thinstation/index.php?title=Main_Page).
 * Overlays(file archives) can be mounted over root filesystem, allowing different thin stations to have different configs/software, without building many different images
 * Home folder may be mounted via NFS, so changes are saved.

# GENERATED FILES
 * vmlinuz - linux kernel image
 * initrd.img - initial RAM disk. Contains kernel modules and scripts, required to download all other files and boot system
 * rootfs.squashrs - root filesystem. Contains all software. [SquashFS](http://en.wikipedia.org/wiki/SquashFS) is used to keep it small.
 * pxelinux.0 - bootloader, used to download and boot kernel and initrd. Not generated, can be obtained from it's [site](http://www.syslinux.org/) ro from package syslinux.
 * pxelinux.cfg/default - bootloader configuration

# WORKFLOW

It's late now, I realy want to sleep. I'll write this later.

# INSTALLATION
