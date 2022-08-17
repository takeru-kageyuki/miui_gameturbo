#!/system/bin/sh

SKIPUNZIP=1

module_descriptions() {
    ui_print "MIUI GameTurbo (Magisk Module)"
    ui_print " • A module that allows your device to unlock"
    ui_print " • Unsupported features like Game Turbo, Sidebar,"
    ui_print " • Optimized Charging and many other similar features."
    ui_print ""
    sleep 2
    ui_print "Telegram Group:"
    ui_print " • https://t.me/TakaEmpire_Discussion"
    ui_print ""
    sleep 2
    ui_print "Notes:"
    ui_print " • It is recommended to use MIUI 12.5+, as this"
    ui_print " • Module doesn't work in severals MIUI 12."
    sleep 2
    ui_print " • If some features doesn't work or doesn't appear,"
    ui_print " • It means your device really doesn't support it."
    ui_print ""
    sleep 2
}

install_module() {
    module_descriptions
    ui_print "Installing..."
    sleep 2
    ui_print "- Extracting module files"
    unzip -o "$ZIPFILE" "lib/*" -d $MODPATH >&2
    unzip -o "$ZIPFILE" "module.prop" -d $MODPATH >&2
    unzip -o "$ZIPFILE" "service.sh" -d $MODPATH >&2
    unzip -o "$ZIPFILE" "setup.sh" -d $MODPATH >&2
    unzip -o "$ZIPFILE" "system.prop" -d $MODPATH >&2
    unzip -o "$ZIPFILE" "uninstall.sh" -d $MODPATH >&2
    sleep 2
    ui_print "- Settings module"
    . $MODPATH/setup.sh
    install_lib
    rmdir $MODPATH/lib
    rm $MODPATH/setup.sh
    sleep 2
    ui_print "- Settings permission"
    set_perm_recursive $MODPATH 0 0 0755 0644
    sleep 2
}

if [ $API -lt 28 ]; then
    ui_print "*********************************************************"
    ui_print " Requires API 28+ (Android 9.0+) to install this module! "
    abort "*********************************************************"
elif [ $MAGISK_VER_CODE -lt 24000 ]; then
    ui_print "*******************************"
    ui_print " Please install Magisk v24.0+! "
    abort "*******************************"
elif ! $BOOTMODE; then
    ui_print "********************************"
    ui_print " Install this module in Magisk! "
    abort "********************************"
elif [ -z $(grep_get_prop ro.miui.ui.version.name) ]; then
    ui_print "****************************************"
    ui_print " This module is only for MIUI firmware! "
    abort "****************************************"
elif [ $(grep_get_prop ro.miui.ui.version.code) -lt 10 ]; then
    ui_print "*******************************************"
    ui_print " Requires MIUI 12+ to install this module! "
    abort "*******************************************"
else
    set -x
    sleep 3
    install_module
fi
