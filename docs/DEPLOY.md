{:toc}

Step-by-setp setup instructions for remote boot server(dhcp+tftp) based on Ubuntu 16.04 Xenial. Two options dnsmasq and dhcpd+tftpd. Change IP addresses for your network. Place into ${TFTP_DIR} generated images: `vmlinuz`, `initrd.img`, `rootfs.squashfs`, `home.tar.gz`.

## DNSMASQ
[dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) as all-on-one solution: DHCP and TFTP server.

```bash
THIS_SERVER_IP=192.168.10.254
SUBNET=192.168.10.0
NETMASK=255.255.255.0
ROUTER=192.168.10.254
DNS1=192.168.10.254
DNS2=192.168.10.254
DHCP_START=192.168.10.129
DHCP_END=192.168.10.253
TFTP_DIR=/var/lib/tftpboot

apt install dnsmasq syslinux-common pxelinux

mkdir -p "$TFTP_DIR"
cd "$TFTP_DIR"
ln -sf /usr/lib/syslinux/modules/bios/ldlinux.c32 ldlinux.c32
ln -sf /usr/lib/PXELINUX/pxelinux.0 pxelinux.0
mkdir pxelinux.cfg
cat > pxelinux.cfg/default <<EOF
default thinclient
prompt 0

# DEBUG with serial console
# console=tty1 console=ttyS0,115200n8
# DEBUG shell inside initrd
# initrddebug=y
# Mount overlays over rootfs
# overlayproto=http overlays=overlay1.tar.gz,overlay2.tar.gz
label thinclient
    kernel vmlinuz
    append boot=ram initrd=initrd.img rootproto=http rooturl=/rootfs.squashfs homeproto=http homeurl=/home.tar.gz rdpservers=rdp%server1:dc1.example.net:3389;rdp%server2:dc2.example.net:5555:/sec:rdp%/bpp:24
EOF

cat > /etc/dnsmasq.conf <<EOF
# Do not run as DNS server
port=0

dhcp-range=${DHCP_START},${DHCP_END},${NETMASK}

# All available options: dnsmasq --help dhcp
dhcp-option=option:dns-server,${DNS1}
dhcp-option=option:dns-server,${DNS2}
dhcp-option=option:router,${ROUTER}
# If dnsmasq is providing a TFTP service (see --enable-tftp ) then only the filename is required here to enable network booting.
dhcp-boot=/pxelinux.0

# TFTP service
enable-tftp
tftp-root=${TFTP_DIR}
EOF

# Check config syntax
dnsmasq --test

systemctl restart dnsmasq.service
```

## DHCPD + TFTPD
[ISC DHCP Server](https://kb.isc.org/category/78/0/10/Software-Products/DHCP/) and [tftpd-hpa](http://git.kernel.org/cgit/network/tftp/tftp-hpa.git).

```bash
THIS_SERVER_IP=192.168.10.254
SUBNET=192.168.10.0
NETMASK=255.255.255.0
ROUTER=192.168.10.254
DNS1=192.168.10.254
DNS2=192.168.10.254
DHCP_START=192.168.10.129
DHCP_END=192.168.10.253
TFTP_DIR=/var/lib/tftpboot

apt install isc-dhcp-server tftpd-hpa syslinux-common pxelinux

mkdir -p "$TFTP_DIR"
cd "$TFTP_DIR"
# tftpd-hpa won't work with symlinks
cp -f /usr/lib/syslinux/modules/bios/ldlinux.c32 ldlinux.c32
cp -f /usr/lib/PXELINUX/pxelinux.0 pxelinux.0
mkdir pxelinux.cfg
cat > pxelinux.cfg/default <<EOF
default thinclient
prompt 0

# DEBUG with serial console
# console=tty1 console=ttyS0,115200n8
# DEBUG shell inside initrd
# initrddebug=y
# Mount overlays over rootfs
# overlayproto=http overlays=overlay1.tar.gz,overlay2.tar.gz
label thinclient
    kernel vmlinuz
    append boot=ram initrd=initrd.img rootproto=http rooturl=/rootfs.squashfs homeproto=http homeurl=/home.tar.gz rdpservers=rdp%server1:dc1.example.net:3389;rdp%server2:dc2.example.net:5555:/sec:rdp%/bpp:24
EOF

cat > /etc/default/tftpd-hpa <<EOF

TFTP_USERNAME="tftp"
TFTP_DIRECTORY="${TFTP_DIR}"
TFTP_ADDRESS=":69"
TFTP_OPTIONS="--secure"
EOF

cat > /etc/dhcp/dhcpd.conf <<EOF
default-lease-time 600;
max-lease-time 7200;

subnet ${SUBNET} netmask ${NETMASK} {
  range ${DHCP_START} ${DHCP_END};
  option domain-name-servers ${DNS1}, ${DNS2};
  option subnet-mask ${NETMASK};
  option routers ${ROUTER};

  allow booting;
  #option option-128 code 128 = string;
  #option option-129 code 129 = text;
  next-server ${THIS_SERVER_IP};
  filename "pxelinux.0";
}
EOF

systemctl restart tftpd-hpa.service
systemctl restart isc-dhcp-server.service
```
