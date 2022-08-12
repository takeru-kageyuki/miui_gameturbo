#!/system/bin/sh

libadd() {
    local libadd_location=$(pm path com.miui.securityadd | cut -d ":" -f 2 | cut -d "/" -f 2)
    local libadd_version=$(dumpsys package com.miui.securityadd | grep versionCode | cut -d "=" -f 2 | cut -d " " -f 1)
    if [ $libadd_location != system ]; then
        pm clear com.miui.securityadd &>/dev/null
        pm uninstall com.miui.securityadd &>/dev/null
    elif [ $libadd_version != 91106 ]; then
        pm clear com.miui.securityadd &>/dev/null
    fi
    
    local libadd_dir=$(pm path com.miui.securityadd | cut -d ":" -f 2 | sed "s:/[^/]*$::")
    mkdir -p $MODPATH$libadd_dir
    
    local libadd_path=$(pm path com.miui.securityadd | cut -d ":" -f 2)
    mv $MODPATH/lib/libadd.so $MODPATH$libadd_path
    
    local libadd_dalvik=$(pm path com.miui.securityadd | sed "s:.*/::")
    find /data/dalvik-cache/*/*$libadd_dalvik* -delete &>/dev/null
    
    local libadd_package=$(pm path com.miui.securityadd | cut -d "." -f 1 | sed "s:.*/::")
    find /data/system/package_cache/*/$libadd_package* -delete &>/dev/null
}

libmain() {
    local libmain_location=$(pm path com.miui.securitycenter | cut -d ":" -f 2 | cut -d "/" -f 2)
    local libmain_version=$(dumpsys package com.miui.securitycenter | grep versionCode | cut -d "=" -f 2 | cut -d " " -f 1)
    if [ $libmain_location != system ]; then
        pm clear com.miui.securitycenter &>/dev/null
        pm uninstall com.miui.securitycenter &>/dev/null
    elif [ $libmain_version != 40000621 ]; then
        pm clear com.miui.securitycenter &>/dev/null
    fi
    
    local libmain_dir=$(pm path com.miui.securitycenter | cut -d ":" -f 2 | sed "s:/[^/]*$::")
    mkdir -p $MODPATH$libmain_dir
    
    local libmain_path=$(pm path com.miui.securitycenter | cut -d ":" -f 2)
    mv $MODPATH/lib/libmain.so $MODPATH$libmain_path
    
    local libmain_dalvik=$(pm path com.miui.securitycenter | sed "s:.*/::")
    find /data/dalvik-cache/*/*$libmain_dalvik* -delete &>/dev/null
    
    local libmain_package=$(pm path com.miui.securitycenter | cut -d "." -f 1 | sed "s:.*/::")
    find /data/system/package_cache/*/$libmain_package* -delete &>/dev/null
}

install_lib() { libadd; libmain; }
