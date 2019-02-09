messages(){
	devices=`dmesg | grep ':'  | grep -v '\.\.' |  sed 's/.*] //g' | cut -d ':' -f 1 | cut -d ' ' -f 1 | sort -u`

	for dev in $devices
	do
		stats=`dmesg | grep $dev | wc -l`
		echo $dev "->" $stats
	done
}

history(){
	devices=`cat /var/log/apt/history.log | grep 'Requested-By' | cut -d ' ' -f 2 | sort -u`

	for dev in $devices
	do
		stats=`cat /var/log/apt/history.log | grep $dev | wc -l`
		echo $dev "->" $stats
	done
}

auth(){
	devices1=`cat /var/log/auth.log | grep 'FAILED' | cut -d ':' -f 4 | sort -u | cut -d 'y' -f 2`
	devices2=`cat /var/log/auth.log | grep 'Successful' | cut -d ':' -f 4 | sort -u | cut -d 'y' -f 2`

	for dev in $devices1
	do
		stats=`cat /var/log/auth.log | grep $dev | wc -l`
		echo "FAILED -> " $dev "->" $stats
	done

	for dev2 in $devices2
	do
		stats2=`cat /var/log/auth.log | grep $dev2 | wc -l`
		echo "Successful -> " $dev2 "->" $stats2
	done
}

alternatives(){
	devices=`cat /var/log/alternatives.log | grep 'update-alternatives' | sort -u`

	for dev in $devices
	do
		stats=`cat /var/log/alternatives.log | grep $dev | wc -l`
		echo "Numero de actualizaciones: " $dev "->" $stats
	done
}

alternatives