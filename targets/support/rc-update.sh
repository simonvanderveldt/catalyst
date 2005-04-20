#!/bin/bash
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

if [ "${clst_spec_prefix}" == "livecd" ]
then
    # default programs that we always want to start
    rc-update del iptables default
    rc-update del netmount default
    rc-update add autoconfig default
    rc-update del keymaps
    rc-update del serial
    rc-update del consolefont
    rc-update add modules default
    rc-update add pwgen default
    [ -e /etc/init.d/bootsplash ] && rc-update add bootsplash default
    [ -e /etc/init.d/splash ] && rc-update add splash default
    [ -e /etc/init.d/sysklogd ] && rc-update add sysklogd default
    [ -e /etc/init.d/metalog ] && rc-update add metalog default
    [ -e /etc/init.d/syslog-ng ] && rc-update add syslog-ng default
    [ -e /etc/init.d/alsasound ] && rc-update add alsasound default
    [ -e /etc/init.d/hdparm ] && rc-update add hdparm default

    # Do some livecd_type specific rc-update changes
    case ${clst_livecd_type} in
	    gentoo-gamecd )
		# we add spind to default here since we don't want the CD to spin down
		rc-update add spind default
		rc-update add x-setup default
	    ;;
	    *)
	    ;;
    esac
fi

# perform any rcadd then any rcdel
if [ -n "${clst_rcadd}" ] || [ -n "${clst_rcdel}" ]
then
    if [ -n "${clst_rcadd}" ]
    then
	for x in ${clst_rcadd}
	do
	    rc-update add "${x%%:*}" "${x##*:}"
	done
    fi

    if [ -n "${clst_rcdel}" ]
    then
	for x in ${clst_rcdel}
	do
	    rc-update del "${x%%:*}" "${x##*:}"
	done
    fi
fi
