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
    local caches=$(pm path com.miui.securityadd | cut -d "." -f 1 | sed "s:.*/::")
    find /data/dalvik-cache/*/*$caches* -delete &>/dev/null
    find /data/system/package_cache/*/*$caches* -delete &>/dev/null
    
    local trash=$(pm path com.miui.securityadd | cut -d "." -f 1 | sed "s:.*/::" | tr "[:upper:]" "[:lower:]")
    find /data/system/package_cache/*/*$trash* -delete &>/dev/null
}

libmain() {
    local caches=$(pm path com.miui.securitycenter | cut -d "." -f 1 | sed "s:.*/::")
    find /data/dalvik-cache/*/*$caches* -delete &>/dev/null
    find /data/system/package_cache/*/*$caches* -delete &>/dev/null
    
    local trash=$(pm path com.miui.securitycenter | cut -d "." -f 1 | sed "s:.*/::" | tr "[:upper:]" "[:lower:]")
    find /data/system/package_cache/*/*$trash* -delete &>/dev/null
}

libs_cleanup() {
    libadd
    libmain
    
    boot_completed
    
    rm -rf /cache/miui_gameturbo
    
    settings delete global GPUTUNER_SWITCH &>/dev/null
    
    pm clear com.miui.securityadd &>/dev/null
    pm clear com.miui.securitycenter &>/dev/null
    pm clear com.miui.powerkeeper &>/dev/null
}

libs_cleanup &
