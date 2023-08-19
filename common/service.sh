#!/bin/sh

read_file() {
  if [ -f "$1" ]; then
    if [ ! -r "$1" ]; then
      chmod +r "$1"
    fi
    cat "$1"
  fi
}

write_file() {
  if [ -f "$1" ]; then
    if [ ! -w "$1" ]; then
      chmod +w "$1"
    fi
    echo "$2" > "$1"
  fi
}

while [ -z "$(resetprop sys.boot_completed)" ]; do
    sleep 5
done

write_file "/proc/sys/kernel/panic" "0" 
write_file "/proc/sys/kernel/panic_on_oops" "0"
write_file "/proc/sys/kernel/panic_on_rcu_stall" "0"
write_file "/proc/sys/kernel/panic_on_warn" "0"
write_file "/sys/module/kernel/parameters/panic" "0"
write_file "/sys/module/kernel/parameters/panic_on_warn" "0"
write_file "/sys/module/kernel/parameters/panic_on_oops" "0"

write_file "/proc/sys/kernel/printk" "0 0 0 0"
write_file "/proc/sys/kernel/printk_devkmsg" "off"
write_file "/sys/module/printk/parameters/console_suspend" "Y"
write_file "/sys/module/printk/parameters/cpu" "N"
write_file "/sys/module/printk/parameters/ignore_loglevel" "Y"
write_file "/sys/module/printk/parameters/pid" "N"
write_file "/sys/module/printk/parameters/time" "N"
write_file "/sys/kernel/printk_mode/printk_mode" "0"

find /sys/ -name "*log*" -o -name "*debug*" | while IFS= read -r logdebug; do
wr
write_file "$logdebug" "0"
done

write_file "/sys/kernel/debug/sched_features" "NO_GENTLE_FAIR_SLEEPERS"
write_file "/sys/kernel/debug/sched_features" "NO_HRTICK"
write_file "/sys/kernel/debug/sched_features" "NO_DOUBLE_TICK"
write_file "/sys/kernel/debug/sched_features" "NO_RT_RUNTIME_SHARE"
write_file "/sys/kernel/debug/sched_features" "NEXT_BUDDY"
write_file "/sys/kernel/debug/sched_features" "NO_TTWU_QUEUE"
write_file "/sys/kernel/debug/sched_features" "UTIL_EST"
write_file "/sys/kernel/debug/sched_features" "ARCH_CAPACITY"
write_file "/sys/kernel/debug/sched_features" "ARCH_POWER"
write_file "/sys/kernel/debug/sched_features" "ENERGY_AWARE"

write_file "/proc/sys/kernel/sched_tunable_scaling" "0"

write_file "/proc/sys/vm/drop_caches" "3"
write_file "/proc/sys/vm/dirty_background_ratio" "10"
write_file "/proc/sys/vm/dirty_expire_centisecs" "3000"
write_file "/proc/sys/vm/page-cluster" "0"
write_file "/proc/sys/vm/dirty_ratio" "30"
write_file "/proc/sys/vm/laptop_mode" "5"
write_file "/proc/sys/vm/block_dump" "0"
write_file "/proc/sys/vm/compact_memory" "1"
write_file "/proc/sys/vm/dirty_writeback_centisecs" "3000"
write_file "/proc/sys/vm/oom_dump_tasks" "0"
write_file "/proc/sys/vm/oom_kill_allocating_task" "1"
write_file "/proc/sys/vm/stat_interval" "10"
write_file "/proc/sys/vm/panic_on_oom" "1"
write_file "/proc/sys/vm/swappiness" "100"
write_file "/proc/sys/vm/vfs_cache_pressure" "100"
write_file "/proc/sys/vm/overcommit_ratio" "50"
write_file "/proc/sys/vm/extra_free_kbytes" "20480"
write_file "/proc/sys/kernel/random/read_wakeup_threshold" "64"
write_file "/proc/sys/kernel/random/write_wakeup_threshold" "128"

setprop "debug.sf.disable_backpressure" "1"
setprop "debug.sf.latch_unsignaled" "1"
setprop "debug.sf.enable_hwc_vds" "0"
setprop "debug.sf.early_phase_offset_ns" "500000"
setprop "debug.sf.early_app_phase_offset_ns" "500000"
setprop "debug.sf.early_gl_phase_offset_ns" "3000000"
setprop "debug.sf.early_gl_app_phase_offset_ns" "15000000"
setprop "debug.sf.high_fps_early_phase_offset_ns" "6100000"
setprop "debug.sf.high_fps_early_gl_phase_offset_ns" "650000"
setprop "debug.sf.high_fps_late_app_phase_offset_ns" "100000"
setprop "debug.sf.phase_offset_threshold_for_next_vsync_ns" "6100000"
setprop "debug.sf.showupdates" "0"
setprop "debug.sf.showcpu" "0"
setprop "debug.sf.showbackground" "0"
setprop "debug.sf.showfps" "0"
setprop "debug.sf.hw" "1"

nohup AI > /dev/null 2>&1 &