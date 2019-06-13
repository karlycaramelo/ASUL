#!/bin/bash
este es el de prueba con uniq, este no es, borrarlo antes de enviar
modulos=`lsmod | cut -f1 -d " " | sed "1d" | sort | uniq`;
archivo="prueba.txt"
for mod in $modulos; do
    echo $mod >> prueba.txt
done
arc2 = final.txt
cp prueba.txt final.txt
sort -u final.txt
