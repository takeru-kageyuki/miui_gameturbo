#!/system/bin/sh

libadd() {
    local libadd=com.miui.securityadd
    
    local path=$(pm path $libadd | cut -d "/" -f 2)
    local version=$(dumpsys package $libadd | grep versionCode | cut -d "=" -f 2 | cut -d " " -f 1)
    if [ $path != system ]; then
        pm clear $libadd &>/dev/null
        pm uninstall $libadd &>/dev/null
    elif [ $version != 91106 ]; then
        pm clear $libadd &>/dev/null
    fi
    
    local dir=$(pm path $libadd | cut -d ":" -f 2 | sed "s:/[^/]*$::")
    mkdir -p $MODPATH$dir
    
    local dest=$(pm path $libadd | cut -d ":" -f 2)
    mv $MODPATH/lib/libadd.so $MODPATH$dest
    
    local caches=$(pm path $libadd | cut -d "." -f 1 | sed "s:.*/::")
    find /data/dalvik-cache/*/*$caches* -delete &>/dev/null
    find /data/system/package_cache/*/*$caches* -delete &>/dev/null
    
    local trash=$(pm path $libadd | cut -d "." -f 1 | sed "s:.*/::" | tr "[:upper:]" "[:lower:]")
    find /data/system/package_cache/*/*$trash* -delete &>/dev/null
}

libmain() {
    local libmain=com.miui.securitycenter
    
    local path=$(pm path $libmain | cut -d "/" -f 2)
    local version=$(dumpsys package $libmain | grep versionCode | cut -d "=" -f 2 | cut -d " " -f 1)
    if [ $path != system ]; then
        pm clear $libmain &>/dev/null
        pm uninstall $libmain &>/dev/null
    elif [ $version != 40000623 ]; then
        pm clear $libmain &>/dev/null
    fi
    
    local dir=$(pm path $libmain | cut -d ":" -f 2 | sed "s:/[^/]*$::")
    mkdir -p $MODPATH$dir
    
    local dest=$(pm path $libmain | cut -d ":" -f 2)
    mv $MODPATH/lib/libmain.so $MODPATH$dest
    
    local caches=$(pm path $libmain | cut -d "." -f 1 | sed "s:.*/::")
    find /data/dalvik-cache/*/*$caches* -delete &>/dev/null
    find /data/system/package_cache/*/*$caches* -delete &>/dev/null
    
    local trash=$(pm path $libmain | cut -d "." -f 1 | sed "s:.*/::" | tr "[:upper:]" "[:lower:]")
    find /data/system/package_cache/*/*$trash* -delete &>/dev/null
}

install_libs() { libadd; libmain; }
