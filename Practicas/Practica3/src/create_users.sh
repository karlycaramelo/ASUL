# github.com/truerandom
ban=4pSM4pSs4pSQ4pSs4pSA4pSQ4pSsIOKUrOKUjOKUgOKUkOKUrOKUgOKUkOKUjOKUgOKUkOKUjOKUkOKUjOKUjOKUrOKUkOKUjOKUgOKUkOKUjOKUrOKUkAog4pSCIOKUnOKUrOKUmOKUgiDilILilJzilKQg4pSc4pSs4pSY4pSc4pSA4pSk4pSC4pSC4pSCIOKUguKUguKUgiDilILilILilILilIIKIOKUtCDilLTilJTilIDilJTilIDilJjilJTilIDilJjilLTilJTilIDilLQg4pS04pSY4pSU4pSY4pSA4pS04pSY4pSU4pSA4pSY4pS0IOKUtAo=
echo $ban | base64 -d

# priv check
if [[ $(id -u) -ne 0 ]];
then
	echo "Must be run as root | sudo"
	exit
fi

# checking args
if [ "$#" -eq 2 ]
then
	user_file=$1
	num_users=$2
	if [ -r $user_file ]
	then 
		tam=`wc -l $user_file | cut -d ' ' -f 1 ` 
		if [ $tam  -gt $num_users ]
		then 
			users_to_add=`cat $user_file | head -n $num_users`
		else
			echo "[x] check num_users argument max users to add is $tam"
			exit
		fi
	else
		echo "[x] file not readable "
		exit
	fi
else
	echo "[i] Usage: $0 user_file num_users";
	exit
fi

# Returns an openssl rand hex password
genPass(){
	echo `openssl rand -hex 5`
}

# Returns a random integer [1,4]
getOption(){
	echo `shuf -i1-4 -n1`
}

# Random expiration date
getDate(){
	echo -ne "2019-`shuf -i1-12 -n1`-`shuf -i1-28 -n1`"
}

# Generate a username from line
get_username(){
	# gets the full string (blanks included)
	usrline="$@"
	username=`echo $usrline | cut -d ' ' -f 1 | cut -c 1,2``echo $usrline | tr ' ' '\n' | tail -n2 | head -n1`
	echo $username | tr '[:upper:]' '[:lower:]'
}

# Adding user
add_user(){
	uname="$1"
	opt="$2"
	pass="$3"
	finact=`getDate`
	case $opt in
		1) useradd $uname 2> /dev/null ;;
		2) useradd $uname -p $pass 2> /dev/null ;;
		3) useradd $uname -p $pass -m 2> /dev/null ;;
		*) useradd $uname -p $pass -m -e $finact 2> /dev/null ;;
	esac
}

while IFS='' read -r userline || [[ -n "$line" ]]; do
	user=`get_username $userline`
	pass=`genPass`
	option=`getOption`
	ubase=$user
	
	add_user $ubase $option $pass
	res=$?
	if [ $res == 0 ]; then
		echo "User created -> $ubase:$pass"
	else
		i=0
		e=1
		while [ $e != 0 ]
		do
			new_name=$ubase$i
			add_user $new_name $option $pass
			e=$?
			i=$((i+1))
		done
		echo "User created -> $new_name:$pass"
	fi
done < "$1"
