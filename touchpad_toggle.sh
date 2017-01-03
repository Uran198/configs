#!/bin/bash

if synclient | grep "TouchpadOff\s*=\s*0"; then
    synclient TouchpadOff=1
    notify-send --expire-time=1 "Touchpad Disabled"
else
    synclient TouchpadOff=0
    notify-send --expire-time=1 "Touchpad Enabled"
fi
