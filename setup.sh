#!/system/bin/sh

libadd() {
    local path=$(pm path com.miui.securityadd | cut -d ":" -f 2 | cut -d "/" -f 2)
    local version=$(dumpsys package com.miui.securityadd | grep versionCode | cut -d "=" -f 2 | cut -d " " -f 1)
    if [ $path != system ]; then
        pm clear com.miui.securityadd &>/dev/null
        pm uninstall com.miui.securityadd &>/dev/null
    elif [ $version != 91106 ]; then
        pm clear com.miui.securityadd &>/dev/null
    fi
    
    local dir=$(pm path com.miui.securityadd | cut -d ":" -f 2 | sed "s:/[^/]*$::")
    mkdir -p $MODPATH$dir
    
    local dest=$(pm path com.miui.securityadd | cut -d ":" -f 2)
    mv $MODPATH/lib/libadd.so $MODPATH$dest
    
    local caches=$(pm path com.miui.securityadd | cut -d "." -f 1 | sed "s:.*/::")
    find /data/dalvik-cache/*/*$caches* -delete &>/dev/null
    find /data/system/package_cache/*/*$caches* -delete &>/dev/null
    
    local trash=$(pm path com.miui.securityadd | cut -d "." -f 1 | sed "s:.*/::" | tr "[:upper:]" "[:lower:]")
    find /data/system/package_cache/*/*$trash* -delete &>/dev/null
}

libmain() {
    local path=$(pm path com.miui.securitycenter | cut -d ":" -f 2 | cut -d "/" -f 2)
    local version=$(dumpsys package com.miui.securitycenter | grep versionCode | cut -d "=" -f 2 | cut -d " " -f 1)
    if [ $path != system ]; then
        pm clear com.miui.securitycenter &>/dev/null
        pm uninstall com.miui.securitycenter &>/dev/null
    elif [ $version != 40000623 ]; then
        pm clear com.miui.securitycenter &>/dev/null
    fi
    
    local dir=$(pm path com.miui.securitycenter | cut -d ":" -f 2 | sed "s:/[^/]*$::")
    mkdir -p $MODPATH$dir
    
    local dest=$(pm path com.miui.securitycenter | cut -d ":" -f 2)
    mv $MODPATH/lib/libmain.so $MODPATH$dest
    
    local caches=$(pm path com.miui.securitycenter | cut -d "." -f 1 | sed "s:.*/::")
    find /data/dalvik-cache/*/*$caches* -delete &>/dev/null
    find /data/system/package_cache/*/*$caches* -delete &>/dev/null
    
    local trash=$(pm path com.miui.securitycenter | cut -d "." -f 1 | sed "s:.*/::" | tr "[:upper:]" "[:lower:]")
    find /data/system/package_cache/*/*$trash* -delete &>/dev/null
}

install_libs() { libadd; libmain; }
