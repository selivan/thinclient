TODO: write detailed documentation.

Server machine is used to provision both itself and template machine, because we don't want additional packages(ansible) in image.
Though we have to install python2-minimal to make ansible work.

Some directories are excluded from rootfs image to make it more compact: `/boot`, `/usr/share/doc`, `/var/lib/apt/lists` and others, see `build.sh`.

initrd has custom booot script `ram` and hook to incude necessary binaries and modules. Script name is passed to kernel in boot parameters.

Overlays(optional) are mounted using AUFS.
