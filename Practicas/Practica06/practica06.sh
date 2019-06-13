#!/bin/bash

modulos=`lsmod | cut -f1 -d " " | sed "1d" | sort`;
archivo="prueba.txt"
for mod in $modulos; do
    actuales=`grep "$mod" $archivo`
    if [ "$mod" != "$actuales" ]; then
        echo $mod >> prueba.txt
    fi
done
