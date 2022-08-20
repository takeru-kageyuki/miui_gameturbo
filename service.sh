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

last_setup() {
    boot_completed
    
    local update=/cache/miui_gameturbo
    if [ ! -d $update ]; then
        . /data/adb/magisk/util_functions.sh
        
        mktouch $update/.installed
        
        settings put global GPUTUNER_SWITCH true
        
        pm clear com.miui.securityadd &>/dev/null
        pm clear com.miui.securitycenter &>/dev/null
        pm clear com.miui.powerkeeper &>/dev/null
    fi
}

last_setup &
