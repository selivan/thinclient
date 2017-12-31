#!/bin/bash
# Create shortcuts for RDP connections

desktop_dir="${XDG_DESKTOP_DIR:-$HOME/Desktop}"
default_options="/workarea /f"

# DEBUG
# echo "boot=ram rdpservers=MAIN:dc1.example.net:3389;BACKUP:dc2.example.net:3389:/sec:rdp%/bpp:24" \
cat /proc/cmdline \
| tr ' ' '\n' | while read param; do
    if echo $param | grep -q '^rdpservers='; then
        servers=$(echo $param | cut -d= -f2)
        echo $servers | tr ';' '\n' | while read srv; do
            srv_with_spaces=$(echo $srv | tr '%' ' ')
            name=$(echo $srv_with_spaces | cut -d':' -f1)
            addr=$(echo $srv_with_spaces | cut -d':' -f2)
            port=$(echo $srv_with_spaces | cut -d':' -f3)
            options=$(echo $srv_with_spaces | cut -d':' -f4-)

            exec="xfreerdp $default_options $options /v:$addr:$port"
            desktop_file="$desktop_dir/$name.desktop"

            echo -e "\nCreating $desktop_file:\n"
            echo "[Desktop Entry]" > "$desktop_file"
            echo "Name=$name" >> "$desktop_file"
            echo "Terminal=false" >> "$desktop_file"
            echo "Type=Application" >> "$desktop_file"
            echo "Icon=system" >> "$desktop_file"
            echo "Exec=$exec" >> "$desktop_file"
            # Desktop environment may display warning if desktop file is not executable
            chmod a+x "$desktop_file"
            cat "$desktop_file"
        done
    fi
done
