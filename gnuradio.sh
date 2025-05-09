#!/bin/bash
export DISPLAY=$DISPLAY
export QT_QPA_PLATFORM=xcb
gnuradio-companion && disown

