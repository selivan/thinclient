**NEWS**: Check out new `20.04` branch with Ubuntu 20.04 Focal and an option to use VMWare Horizon. It still needs some polishing, though.

### Thinclient

Tools to create Ubuntu GNU/Linux image for [thin clients](http://en.wikipedia.org/wiki/Thin_client). It boots via network and works entirely from memory.

Doesn't need to mount root fileystem from network share, like [DisklessUbuntu](https://help.ubuntu.com/community/DisklessUbuntuHowto). Works much better in slow or unreliable networks: clients do not slow down or hang up because of network lags. Here is an [article](https://selivan.github.io/2018/03/08/ubuntu-based-thin-client.html) on how it works.

Most common use case is creating custom thin clilent for RDP terminals.

This project was originaly created by [efim-a-efim](https://github.com/efim-a-efim).

### Features

* Easily add any software from rich Ubuntu repositories: browser, photo/video recorder for camera, skype, media player, etc. This is not so easy for other thin clients, using their own package base, like [ThinStation](http://www.thinstation.org/).
* Overlays(file archives) can be mounted over root filesystem, allowing different thin stations to have different configs/software, without building many different images.
* Compressed RAM(zram) is used to make possible running on devices with low memory.

### Documentation

* [Build](docs/BUILD.md) - create and customize your own thinclient
* [Deploy](docs/DEPLOY.md) - bring it to production servers
* [Internals](docs/INTERNALS.md) - see how it ticks under the hood

### License

[GNU General Public License v3.0](LICENSE)

**P.S.** If this code is useful for you - don't forget to put a star on it's [github repo](https://github.com/selivan/thinclient).
