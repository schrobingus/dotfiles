while true; do
	xsetroot -name "墳 $(pactl list sinks | awk '$1=="Volume:" {print $5}')  拉 $(cat /sys/class/power_supply/BAT0/capacity)%   $(date +%I:%M)   $(date +%D) "
	sleep 2
done
