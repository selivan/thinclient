#!/bin/sh
# global xinitrc: /etc/X11/xinit/xinitrc

{% if gui_window_manager == 'jwm' %}

{% if install_vmware_horizon_client %}
$HOME/.local/bin/autorun.sh &
$HOME/.local/bin/endless-run-vmware-view.sh &
{% endif %}

{% endif %}
# invoke global X session script
. /etc/X11/Xsession
