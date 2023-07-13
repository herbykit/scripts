#! /bin/fish

for dir in $PWD/*
	if test -d $dir
		rsync --delete -avz -e "ssh" $dir mentallyobscure:/var/
	end
end
