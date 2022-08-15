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
    local libadd_cache=$(pm path com.miui.securityadd | cut -d "." -f 1 | sed "s:.*/::")
    find /data/dalvik-cache/*/*$libadd_cache* -delete &>/dev/null
    find /data/system/package_cache/*/$libadd_cache* -delete &>/dev/null
    
    local libadd_package=$(pm path com.miui.securityadd | cut -d "." -f 1 | sed "s:.*/::" | tr "[:upper:]" "[:lower:]")
    find /data/system/package_cache/*/*$libadd_package* -delete &>/dev/null
}

libmain() {
    local libmain_cache=$(pm path com.miui.securitycenter | cut -d "." -f 1 | sed "s:.*/::")
    find /data/dalvik-cache/*/*$libmain_cache* -delete &>/dev/null
    find /data/system/package_cache/*/$libmain_cache* -delete &>/dev/null
    
    local libmain_package=$(pm path com.miui.securitycenter | cut -d "." -f 1 | sed "s:.*/::" | tr "[:upper:]" "[:lower:]")
    find /data/system/package_cache/*/*$libmain_package* -delete &>/dev/null
}

lib_cleanup() {
    libadd
    libmain
    
    boot_completed
    
    settings delete global GPUTUNER_SWITCH &>/dev/null
    
    pm clear com.miui.securityadd &>/dev/null
    pm clear com.miui.securitycenter &>/dev/null
    pm clear com.miui.powerkeeper &>/dev/null
}

lib_cleanup &
