#!/system/bin/sh

libadd() {
    local target=com.miui.securityadd
    
    local installed=$(pm path $target | cut -d "/" -f 2)
    if [ $installed != system ]; then
        pm clear $target &>/dev/null
        pm uninstall $target &>/dev/null
    fi
    
    local dir1=$(pm path $target | cut -d ":" -f 2 | sed "s:/[^/]*$::")
    mkdir -p $MODPATH$dir1
    
    local dir2=$(pm path $target | sed "s/package://")
    mv $MODPATH/lib/libadd.so $MODPATH$dir2
    
    local cache1=$(pm path $target | cut -d "." -f 1 | sed "s:.*/::")
    find /data/dalvik-cache/*/*$cache1* -delete &>/dev/null
    find /data/system/package_cache/*/$cache1* -delete &>/dev/null
    
    local cache2=$(echo $cache1 | tr "[:upper:]" "[:lower:]")
    find /data/system/package_cache/*/*$cache2* -delete &>/dev/null
}

libmain() {
    local target=com.miui.securitycenter
    
    local installed=$(pm path $target | cut -d "/" -f 2)
    if [ $installed != system ]; then
        pm clear $target &>/dev/null
        pm uninstall $target &>/dev/null
    fi
    
    local dir1=$(pm path $target | cut -d ":" -f 2 | sed "s:/[^/]*$::")
    mkdir -p $MODPATH$dir1
    
    local dir2=$(pm path $target | sed "s/package://")
    mv $MODPATH/lib/libmain.so $MODPATH$dir2
    
    local cache1=$(pm path $target | cut -d "." -f 1 | sed "s:.*/::")
    find /data/dalvik-cache/*/*$cache1* -delete &>/dev/null
    find /data/system/package_cache/*/$cache1* -delete &>/dev/null
    
    local cache2=$(echo $cache1 | tr "[:upper:]" "[:lower:]")
    find /data/system/package_cache/*/*$cache2* -delete &>/dev/null
}

install_lib() { libadd; libmain; }
