#!/usr/bin/env bash
# Terminate already running bar instances
killall -q polybar
# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --config="$XDG_CONFIG_HOME"/polybar/main/config.ini --reload laptop &
  done
else
  #polybar --config=~/.config/polybar.old/config --reload mybar &
  polybar --config="$XDG_CONFIG_HOME"/polybar/main/config.ini --reload laptop &
fi
echo "Bars launched..."
#pgrep polybar | xargs /bin/kill -9
#cd $XDG_CONFIG_HOME/polybar || { echo "Configuration file does not exist" ; exit 1; }
## I got bored with hack, trying something new.
##./hack/launch.sh
#polybar --reload -q laptop -c $XDG_CONFIG_HOME/polybar/main/config.ini &
#IS_HDMI=0
#for MONITOR in $(xrandr | grep -w connected | cut -d' ' -f1 | cut -d'-' -f1)
#do
#    if [ "$MONITOR" = HDMI ]; then
#       IS_HDMI=1
#    fi
#done
#if [ $IS_HDMI = 1 ]; then
#    polybar -q monitor -c $XDG_CONFIG_HOME/polybar/main/config.ini &
#    #./forest/launch.sh
#fi
