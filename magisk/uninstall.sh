#!/system/bin/sh

boot_completed() {
    while [ $(getprop sys.boot_completed) != 1 ]; do sleep 1; done
    
    local permission=/sdcard/.miui_gameturbo
    touch $permission
    while [ ! -f $permission ]; do
        touch $permission
        sleep 1
    done
    rm $permission
}

libadd() {
    local target=com.miui.securityadd
    
    local cache1=$(pm path $target | cut -d "." -f 1 | sed "s:.*/::")
    find /data/dalvik-cache/*/*$cache1* -delete &>/dev/null
    find /data/system/package_cache/*/$cache1* -delete &>/dev/null
    
    local cache2=$(echo $cache1 | tr "[:upper:]" "[:lower:]")
    find /data/system/package_cache/*/*$cache2* -delete &>/dev/null
}

libmain() {
    local target=com.miui.securitycenter
    
    local cache1=$(pm path $target | cut -d "." -f 1 | sed "s:.*/::")
    find /data/dalvik-cache/*/*$cache1* -delete &>/dev/null
    find /data/system/package_cache/*/$cache1* -delete &>/dev/null
    
    local cache2=$(echo $cache1 | tr "[:upper:]" "[:lower:]")
    find /data/system/package_cache/*/*$cache2* -delete &>/dev/null
}

uninstall_lib() {
    libadd
    libmain
    
    rm -rf /cache/miui_gameturbo
    
    boot_completed
    
    settings delete global GPUTUNER_SWITCH &>/dev/null
    
    pm clear com.miui.securityadd &>/dev/null
    pm clear com.miui.securitycenter &>/dev/null
    pm clear com.miui.powerkeeper &>/dev/null
}

uninstall_lib &
