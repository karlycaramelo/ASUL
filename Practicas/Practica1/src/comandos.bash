#!/bin/bash

descolorear(){
	sed -i "s/alias echo='tput setaf 1; echo'/#alias echo='tput setaf 1; echo'/" ~/.bashrc
	sed -i 's/export/#export/' ~/.bashrc
	sed -i "s/alias grep='grep --color=always'/#alias grep='grep --color=always'/" ~/.bashrc
	source ~/.bashrc
}

colorear(){
	sed -i "s/#alias echo='tput setaf 1; echo'/alias echo='tput setaf 1; echo'/" ~/.bashrc
        sed -i 's/#export/export/' ~/.bashrc
        sed -i "s/#alias grep='grep --color=always'/alias grep='grep --color=always'/" ~/.bashrc
        source ~/.bashrc
}
