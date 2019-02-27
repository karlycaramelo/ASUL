#!/bin/bash

genera_pass(){
	pass=`shuf -i10000000-99999999 -n1`
	aux=`echo $pass | md5sum`
	echo $aux
}
genera_pass
