#! /bin/fish

if [ -z "$argv[1]" ];
	echo usage: "./~/scripts/change_volume.sh [up/down]";
	exit
else
	set volume $(pulsemixer --get-volume | awk {'print $1'});
	if [ "$argv[1]" = "up" ]
		set volume (math $volume + 5)
		echo $volume
		if [ $volume -ge 150 ]
			set volume 150
		end
		echo $volume
		pulsemixer --set-volume $volume
		notify-send "up"
	else if [ "$argv[1]" = "down" ]
        set volume (math $volume - 5)
        echo $volume
        if [ $volume -le 0 ]
            set volume 0
        end
        echo $volume
        pulsemixer --set-volume $volume
        notify-send "down"
	end
end
