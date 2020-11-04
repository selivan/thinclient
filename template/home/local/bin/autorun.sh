#!/bin/bash
# Create shortcuts for RDP connections

ntp_timeout=5

{% if install_gui_and_vmware_horizon_client %}

cat /proc/cmdline | tr ' ' '\n' | while read param; do
    if echo $param | grep -q '^timezone='; then
        timezone=$(echo $param | cut -d= -f2-)
        sudo ln -sf /usr/share/zoneinfo/"$timezone" /run/localtime
    fi
done

cat /proc/cmdline | tr ' ' '\n' | while read param; do
    if echo $param | grep -q '^shutdowntime='; then
        shutdowntime=$(echo $param | cut -d= -f2- | tr '%' ' ')
        sudo systemd-run --on-calendar="$shutdowntime" halt -p
    fi
done

cat /proc/cmdline | tr ' ' '\n' | while read param; do
    if echo $param | grep -q '^ntpservers='; then
        servers=$(echo $param | cut -d= -f2)
        echo $servers | tr ',' '\n' | while read srv; do
            # -u     Direct ntpdate to use an unprivileged port for outgoing packets
            # -t timeout  Specify the maximum time waiting for a server response as the
            # value timeout, in seconds and fraction
            echo "ntp server: $srv" >> /tmp/ntpdate.log
            ntpdate -u -t "$ntp_timeout" "$srv" >> /tmp/ntpdate.log 2>&1
            result=$?
            if [ $result -eq 0 ]; then
                break
            fi
        done
    fi
done

{% endif %}
