#! /bin/fish

for dir in $PWD/*
    set folder (basename $dir)
    if string match -q "*.*" $folder
    else
    	if ssh mentallyobscure 'test -d /var/$folder';
    		rsync --delete -avz -e "ssh" mentallyobscure:/var/$folder $PWD;
    	else;
    	    rm -rf $PWD/$folder
            echo 'oof';
    	end
	end
end
