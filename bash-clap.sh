#!/bin/bash
# Author    daweedm <m@daweed.be>
# URL       https://github.com/daweedm
# License   GPL-3.0 - https://github.com/daweedm/bash-clap/blob/master/LICENSE
# This script detect hand claps. For each hand clap, the `on_clap()` function is executed

# Configuration
kernel=$(uname -s)

detection_percentage_start="10%"
detection_percentage_end="10%"
clap_amplitude_threshold="0.7"
clap_energy_threshold="0.3"
clap_max_duration="1500"
max_history_length="10"
src="auto" # See README.md

if [ "$src" = "auto" ]; then
	if [ "$kernel" = "Darwin" ]; then
		src="coreaudio default" # macOS
	else
		src="alsa hw:0,0" # Linux
	fi
fi

on_clap () {
	# Execute some of yours custom scripts
	# like calling Phillips Hue API for example
	echo "Got clap !"
}

while true; do
	sound_data=$(sox -t $src input.wav silence 1 0.0001 $detection_percentage_start 1 0.1 $detection_percentage_end −−no−show−progress stat 2>&1)
	length=$(echo "$sound_data" | sed -n 's#^Length[ ]*(seconds):[^0-9]*\([0-9.]*\)$#\1#p')
	max_amplitude=$(echo "$sound_data" | sed -n 's#^Maximum[ ]*amplitude:[^0-9]*\([0-9.]*\)$#\1#p')
	rms_amplitude=$(echo "$sound_data" | sed -n 's#^RMS[ ]*amplitude:[^0-9]*\([0-9.]*\)$#\1#p')

	lenght_test=$(echo "$length < $clap_max_duration" | bc -l)
	amplitude_test=$(echo "$max_amplitude > $clap_amplitude_threshold" | bc -l)
	energy_test=$(echo "$rms_amplitude < $clap_energy_threshold" | bc -l)

	if [ "$lenght_test" = "1" ] && [ "$amplitude_test" = "1" ] && [ "$energy_test" = "1" ]; then
		on_clap
	fi
done