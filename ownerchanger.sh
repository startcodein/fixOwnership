#!/bin/bash

## a program to set all files with permissions in system ##

#to get the bareinput (this to be done in a fresh installed healthy system)
#cd /
# find <directories under / but excluding /proc, /home and /sys> -printf '%p %u %g\n >> /tmp/.datadump
#grep -v 'root root' /tmp/.datadump >> bareinput


#mount -o remount / #<-- this is needed only if you are running it 
                    # from recovery mode     

#run the following in a chroot env

sed -i -e 's/GRUB_HIDDEN_TIMEOUT/#GRUB_HIDDEN_TIMEOUT/g' /etc/default/grub	

chown -Rf 0:0 /
chmod 4755 /usr/bin/sudo
input0='bareinput'  
while IFS= read -r var
do
	p=${var%% *}
	q=${var% *}
	r=${q#* }
	s=${var##* }
        chown -f $r:$s $p

  done < "$input0"

## Following part is to search for home directory name in- 
## passwd file. 
ls /home > homer

input1='homer'
while IFS= read -r homey
do

if grep $homey /etc/passwd > /dev/null ;
then


dtry=$(grep $homey /etc/passwd)

e=${dtry%%:*}

echo chown -Rf $e:$e /home/$homey

else
echo "/home/"$homey "<-- The owner is not mentioned in /etc/passwd"
fi
done < $input1

