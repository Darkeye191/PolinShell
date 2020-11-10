#!/bin/bash

#CANCELAR Ctrl + c Y Ctrl + z
trap "" SIGINT   #Ctrl + c
trap "" SIGTSTP  #Ctrl + z

#COLORES
ROJO="\e[31m"
VERDE="\e[32m"
AZUL="\e[0;34m"

CYAN="\e[0;36m"
MAGNETA="\e[35m"
AMARILLO="\e[33m"


NEGRITA="\e[1m"
BLANCO="\e[97m"

RESET="\e[0m"

ubi=$(pwd);
#intala los requerimientos
sudo apt-get install whois
clear
sudo apt-get install mpg123
clear

#Login
echo -e "\n $NEGRITA Introduce tu usuario y contraseña $RESET\n "
read -p "$(echo -e "$CYAN User: $RESET" )" usuario
read -p "$(echo -e "$CYAN Contraseña:$RESET" )" -s contrasenia

aux=$( getent passwd | grep -w "$usuario" )

#Verifico usr
if [ -z "$aux" ]
	then
	echo -e "\n $NEGRITA $ROJO Error de usuario\nEjecute nuevamente el programa $RESET\n"
	exit
fi

echo -e "\n$MAGNETA"


echo "███████████   ███                                                       ███      █████"
echo "░███░░░░░███ ░░░                                                       ░░░      ░░███"
echo "░███    ░███ ████   ██████  ████████   █████ █████  ██████  ████████   ████   ███████   ██████"
echo "░██████████ ░░███  ███░░███░░███░░███ ░░███ ░░███  ███░░███░░███░░███ ░░███  ███░░███  ███░░███"
echo "░███░░░░░███ ░███ ░███████  ░███ ░███  ░███  ░███ ░███████  ░███ ░███  ░███ ░███ ░███ ░███ ░███"
echo "░███    ░███ ░███ ░███░░░   ░███ ░███  ░░███ ███  ░███░░░   ░███ ░███  ░███ ░███ ░███ ░███ ░███"
echo "███████████  █████░░██████  ████ █████  ░░█████   ░░██████  ████ █████ █████░░████████░░██████"
echo "░░░░░░░░░░░  ░░░░░  ░░░░░░  ░░░░ ░░░░░    ░░░░░     ░░░░░░  ░░░░ ░░░░░ ░░░░░  ░░░░░░░░  ░░░░░░" 

echo -e "$RESET"

#Obtenemos la contraseña encriptada y la comparamos
micontra=`mkpasswd -m sha-512 "$contrasenia" "${array[2]}"`
if [ `echo "$linea" | grep -c "$micontra"` -eq 1   ]
	#Si son iguales entramos a shell
	then
		USER=$usuario
		
		while :
		do
			read -p  "$(echo -e "$NEGRITA$MAGNETA$USER:$NEGRITA$VERDE$PWD$RESET"$  )" -a comando  
      		case ${comando[0]} in
				
				'arbol')
       				echo "ENTRA A ARBOL"
       					#Pedir carpeta, y pasarla al archivo
       					echo -e "Escribe la carpeta donde deseas mostrar el arbol"
       					read TREEFILLE
						bash arbolito.sh $TREEFILLE
					;;
          		'hora')
        				bash hora.sh 
					;;
				'fecha')
						bash fecha.sh
					;;
				'limpia')
						clear
					;;
				'ayuda')
          			echo "entra a ayuda"
						bash ayuda.sh
					;;
				'infosis')
        			echo "Entra a infosis"
						bash infosis.sh
					;;
				'reproductor')
					echo "entra a reproductor"
          				bash reproductor.sh
					;;
				'ahorcado')
          				bash ahorcado.sh
					;;
				'gato')
						bash gato.sh
					;;
				'creditos')
					echo "Somos Erick y Uriel"
					;;
				'buscar')
        			echo -e "Escribe la carpeta donde deseas buscar el archivo"
        			read BUSCANDO
        			echo -e "Escribe el archivo que deseas buscar"
        			read BUSCANDOANDO
					bash busqueda.sh $BUSCANDOANDO $BUSCANDO
					;;
				'salir')
					clear
					exit
					;;
				'exit')
						echo "Para salir escribe ssalir"
				;;
				*)
						command ${comando[@]}
				;;			
			esac
   	 	done
	else
		echo -e "$NEGRITA $ROJO Contraseña Incorrecta\n Ejecute nuevamente el programa $RESET"
	fi 