Xephyr -ac -br -noreset -screen 600x400 :1 &
sleep 1
DISPLAY=:1.0 awesome -c ~/.config/awesome/rc.lua
