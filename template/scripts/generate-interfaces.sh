#!/bin/bash
file=/tmp/interfaces

# Loopback
echo "auto lo" > "$file"
echo "iface lo inet loopback" >> "$file"
# All interfaces except loopback
ip link show | grep '^[0-9]' | cut -d' ' -f2 | grep -v 'lo:' | tr -d ':' | while read iface; do
    echo "auto $iface" >> "$file"
    echo "iface $iface inet dhcp" >> "$file"
done
