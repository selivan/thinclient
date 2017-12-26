## DESCRIPTION
Tools to create Ubuntu GNU/Linux image, that boots via network and works from memory. Doesn't need mounting rootfs via network from server, like official [DisklessUbuntu](https://help.ubuntu.com/community/DisklessUbuntuHowto). Works much better in weak networks: clients do not slow down or hang in case of problems with server or network equipment.

Most common use case is creating custom thin clilent for RDP terminals.

This project was originaly created by @efim-a-efim.

## FEATURES
 * Easily add any software from rich Ubuntu repositories: browser, recorder for video cam, media player, etc. This is not so easy for other thin clients, using their own package base, like [ThinStation](http://sourceforge.net/apps/mediawiki/thinstation/index.php?title=Main_Page).
 * Overlays(file archives) can be mounted over root filesystem, allowing different thin stations to have different configs/software, without building many different images. TODO: documentation.
 * Home folder may be mounted via NFS, so user files can be preserved. TODO: documentation.

## DOCUMENTATION

[USAGE](https://github.com/selivan/thinclient/blob/master/USAGE.md).

## LICENSE: [GPL v3](https://github.com/selivan/thinclient/blob/master/LICENSE)

**P.S.** If this code is useful for you - don't forget to put a star on it's [github repo](https://github.com/selivan/thinclient).
