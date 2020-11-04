#!/bin/sh
# global xinitrc: /etc/X11/xinit/xinitrc

{% if install_gui_and_vmware_horizon_client %}
$HOME/.local/bin/autorun.sh &
$HOME/.local/bin/endless-run-vmware-view.sh &
{% endif %}
# invoke global X session script
. /etc/X11/Xsession
