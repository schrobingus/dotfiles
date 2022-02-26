#!/bin/sh -e
cd ~/.wallpapers
while true; do
	feh --bg-scale "$(ls | shuf -n 1)"
	sleep 300
done
