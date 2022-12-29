#!/bin/bash

# Author = Vø1dn3t
# My github = "https://github.com/Voidnet01"
# Esta herramienta fue creada solo para fines educativos, no me hago responsable del mal uso de ella.

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

trap ctrl_c INT

function ctrl_c() {
  echo -e "\n\n${greenColour}[*] Saliendo . . .${endColour}"
  tput cnorm; exit 1
}

function panel() {
	echo -e  "${redColour}                                                     "
	echo -e  "	 ___ __  __      ___ __                                    "
	echo -e  "	(__ /   [__]|\ |[__ [__)                                   "
	echo -e  "	___)\__ |  || \|[___|  \                                   "
	echo -e  "	                                                           "
	echo -e  "	${yellowColour}Code By = Vø1dn3t${endColour} "
	echo -e  "       \n${redColour}Advertencia: Esta herramienta fue creada solo para fines educativos, no me hago responsable del mal uso de ella.${endColour}${endColour}"
        echo -e  "                                                                 "
}

function helpPanel() {
        panel
	echo -e "\n${purpleColour}[*]${endColour}${grayColour} Ejemplo de uso: ./Scanner.sh -i 192.168.0.1 ${endColour}"
	echo -e "\n${purpleColour}[*]${endColour}${grayColour} ./Scanner.sh -p -i 192.168.0.1/24 ${endColour}"
	echo -e "\n\t${turquoiseColour}i)${endColour}${greenColour} ip de la victima${endColour}"
	echo -e "\t${turquoiseColour}p)${encColour}${greenColour} hacer un ping al host${endColour}"
	echo -e "\t${turquoiseColour}h)${endColour}${greenColour} Mostrar este panel de ayuda${endColour}\n"
	exit 0
}

function Attack(){
	echo
	sudo nmap -sS -n -vvv -Pn --min-rate 5000 -p- $ip -oG attack && echo -e "${redColour}\n\n[*] Escaneo completado a la direccion:${endColour}${greenColour} $ip${endColour}" 
}

function ping(){
	echo
	sudo arp-scan  $ip  && echo -e "${redColour}\n[!] Ping finalizado a:${endColour}${greenColour} $ip${endColour}"
}

function dependencies(){
	tput civis
	clear; dependencies=(nmap arp-scan)

	echo -e "${yellowColour}[*]${endColour}${grayColour} Comprobando programas necesarios...${endColour}"
	sleep 2

	for program in "${dependencies[@]}"; do
		echo -ne "\n${yellowColour}[*]${endColour}${blueColour} Herramienta${endColour}${purpleColour} $program${endColour}${blueColour}...${endColour}"

		test -f /usr/bin/$program

		if [ "$(echo $?)" == "0" ]; then
			echo -e " ${greenColour}(V)${endColour}"
		else
			echo -e " ${redColour}(X)${endColour}\n"
			echo -e "${yellowColour}[*]${endColour}${grayColour} Instalando herramienta ${endColour}${blueColour}$program${endColour}${yellowColour}...${endColour}"
			sudo apt-get install $program -y > /dev/null 2>&1
		fi; sleep 1
	done
}

 if [ "$(id -u)" == "0" ]; then
	declare -i parameter_counter=0; while getopts "phi:" arg; do
		case $arg in
			i) ip=$OPTARG; let parameter_counter+=1 ;;
			p) let parameter_counter+=1 ;;
			h) ;;

                        \?) # invalid option
		                echo -e "\n[x] Error: Invalid option."
			        tput cnorm; exit;;
		esac
	done

	if [ $parameter_counter -eq 1 ]; then
	        dependencies
        	Attack
	elif [ $parameter_counter -eq 2 ]; then
		dependencies
		ping

         else helpPanel

	fi
else
	echo -e "\n${redColour}[*] No soy root${endColour}\n"
fi
