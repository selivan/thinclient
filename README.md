## DESCRIPTION
Tools to create Ubuntu GNU/Linux image, that boots via network and works from memory. Doesn't need to mount fileystem via network from server, like [DisklessUbuntu](https://help.ubuntu.com/community/DisklessUbuntuHowto). Works much better in slow or unreliable networks: clients do not slow down or hang up because of problems with server or network equipment.

Most common use case is creating custom thin clilent for RDP terminals.

This project was originaly created by [efim-a-efim](https://github.com/efim-a-efim).

## FEATURES
 * Easily add any software from rich Ubuntu repositories: browser, photo/video recorder for camera, skype, media player, etc. This is not so easy for other thin clients, using their own package base, like [ThinStation](http://www.thinstation.org/).
 * Overlays(file archives) can be mounted over root filesystem, allowing different thin stations to have different configs/software, without building many different images.
 * Home folder may be mounted via NFS, so user files can be preserved. TODO: documentation.

## DOCUMENTATION

* [USAGE](docs/USAGE.md)
* [INTERNALS](docs/INTERNALS.md)

## LICENSE: [GPL v3](LICENSE)

**P.S.** If this code is useful for you - don't forget to put a star on it's [github repo](https://github.com/selivan/thinclient).
