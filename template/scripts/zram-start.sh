#!/bin/sh

# load dependency modules
NRDEVICES=$(grep -c ^processor /proc/cpuinfo | sed 's/^0$/1/')
if modinfo zram | grep -q ' zram_num_devices:' 2>/dev/null; then
    MODPROBE_ARGS="zram_num_devices=${NRDEVICES}"
elif modinfo zram | grep -q ' num_devices:' 2>/dev/null; then
    MODPROBE_ARGS="num_devices=${NRDEVICES}"
else
    exit 1
fi
modprobe zram $MODPROBE_ARGS

for x in $(cat /proc/cmdline); do
    case $x in
    zram_size_pct=*)
        zram_size_pct=${x#zram_size_pct=}
        ;;
    esac
done

if [ -z "$zram_size_pct" ]; then export zram_size_pct=50; fi

if [ "$zram_size_pct" = "0" ]; then
    echo "zram usage disabled: zram_size_pct=0"
    exit 0
fi

# Calculate memory to use for zram (P percent of ram)
totalmem=`LC_ALL=C free | grep -e "^Mem:" | sed -e 's/^Mem: *//' -e 's/  *.*//'`
mem=$(((totalmem / 100 * ${zram_size_pct} / ${NRDEVICES}) * 1024))

# initialize the devices
for i in $(seq ${NRDEVICES}); do
    DEVNUMBER=$((i - 1))
    echo $mem > /sys/block/zram${DEVNUMBER}/disksize
    # Use lz4 algorithm if available
    grep -q lz4 /sys/block/zram${DEVNUMBER}/comp_algorithm && echo lz4 > /sys/block/zram${DEVNUMBER}/comp_algorithm
    mkswap /dev/zram${DEVNUMBER}
    swapon --priority 5 /dev/zram${DEVNUMBER}
done
