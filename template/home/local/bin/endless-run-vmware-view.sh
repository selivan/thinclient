#!/bin/bash

cat /proc/cmdline | tr ' ' '\n' | while read param; do
    if echo $param | grep -q '^vmwareviewoptions='; then
        vmwareviewoptions_raw=$(echo $param | cut -d= -f2-)
        vmwareviewoptions=$(echo $vmwareviewoptions_raw | tr '%' ' ')
        while true; do
            vmware-view $vmwareviewoptions
            sleep 0.5
        done
    fi
done
