#!/bin/bash
set -ex

if [ "$HOSTNAME" = planes-readsb-test-0 ]; then
    exec gdb -ex="set breakpoint pending on" -ex="break exit" -ex="break _exit" -ex=run --args $*
else
    exec $*
fi
