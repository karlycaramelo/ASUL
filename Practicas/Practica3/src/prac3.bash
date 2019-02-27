#!/bin/bash

num_users=3;
nom="nombres.txt"
nombres=`cat $nom | cut -f1 -d "," | sort -u`;
usuarios_activos=`cat /etc/passwd | cut -f1 -d ":"`
for usuario in $usuarios_activos; do
	for user in $nombres; do
		if [ "$usuario" == "$user" ]; then
			sin_rep=`cat $nom | cut -f1 -d "," | sort -u | grep -v "$user" | sed "s/ /|/g"`
		fi
	done
done
echo $sin_rep > sin_rep;
sed -i "s/ /\n/g" sin_rep;
for((i=1; i<=$num_users; i++)); do
	nombreactual=`head -n $i sin_rep | tail -n 1 | cut -f1 -d "," | sed "s/|/_/g"`
	echo "Nombre:"$nombreactual
	random=`shuf -i1-3 -n1`;
	pass=`bash pass.bash`;
	if [ $random -eq 1 ]; then
		useradd $nombreactual -m -p $pass 
	elif [ $random -eq 2 ]; then
		useradd $nombreactual -p $pass
	elif [ $random -eq 3 ]; then
		useradd $nombreactual
	fi
done
