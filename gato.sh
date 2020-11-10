#!/bin/bash

ROJO="\e[31m"
VERDE="\e[32m"
AZUL="\e[0;34m"

CYAN="\e[0;36m"
MAGNETA="\e[35m"
AMARILLO="\e[33m"


NEGRITA="\e[1m"
BLANCO="\e[97m"

RESET="\e[0m"

function imprime_ganaste {
echo -e "$MAGENTA"
	echo "@@@  @@@   @@@@@@   @@@@@@@@      @@@@@@@@   @@@@@@   @@@  @@@   @@@@@@   @@@@@@@    @@@@@@   "
	echo "@@@  @@@  @@@@@@@@  @@@@@@@@     @@@@@@@@@  @@@@@@@@  @@@@ @@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  "
	echo "@@!  @@@  @@!  @@@       @@!     !@@        @@!  @@@  @@!@!@@@  @@!  @@@  @@!  @@@  @@!  @@@  "
	echo "!@!  @!@  !@!  @!@      !@!      !@!        !@!  @!@  !@!!@!@!  !@!  @!@  !@!  @!@  !@!  @!@  "
	echo "@!@!@!@!  @!@!@!@!     @!!       !@! @!@!@  @!@!@!@!  @!@ !!@!  @!@!@!@!  @!@  !@!  @!@  !@!  "
	echo "!!!@!!!!  !!!@!!!!    !!!        !!! !!@!!  !!!@!!!!  !@!  !!!  !!!@!!!!  !@!  !!!  !@!  !!!  "
	echo "!!:  !!!  !!:  !!!   !!:         :!!   !!:  !!:  !!!  !!:  !!!  !!:  !!!  !!:  !!!  !!:  !!!  "
	echo ":!:  !:!  :!:  !:!  :!:          :!:   !::  :!:  !:!  :!:  !:!  :!:  !:!  :!:  !:!  :!:  !:!  "
	echo "::   :::  ::   :::   :: ::::      ::: ::::  ::   :::   ::   ::  ::   :::   :::: ::  ::::: ::  "
	echo " :   : :   :   : :  : :: : :      :: :: :    :   : :  ::    :    :   : :  :: :  :    : :  :    "

echo -en "\n\n\n$RESET"
}

function linea2(){ #Imprime el primer gato, referencia para ingresar los números.
					#Una función puede recibir los argumentos que sean, estos se manejaran dentro
	echo "_____________";	#en el orden en que se pasaron.
	echo "|   |   |   |";
	echo "| $1 | $2 | $3 |";
	echo "|___|___|___|";
}

function linea(){ #Imprime cada gato con la nueva marca. Hay una conversión porque se pasan argumentos númericos y queremos
				#imprimir "X" o "O" o " "(Espacio en blanco).
	a=(" " " " " ")		#Arreglo auxiliar.
	aux=("$1" "$2" "$3") #Arreglo de los argumentos recibidos, se pasan de 3 en 3.
						#Las banderas son:
						# 0=Espacio
						# 1="X", jugador 1
						# 2="O", jugador 2

	for (( i = 0; i < 3; i++ )); do
		
		if [ "${aux["${i}"]}" = 0 ]; then #Este if se puede eliminar porque el arreglo a está inicializado en " "(Espacios).
			a["$i"]=" ";
			
		fi
		if [ "${aux["${i}"]}" = 1 ]; then
			a["$i"]="X";
			
		fi
		if [ "${aux["${i}"]}" = 2 ]; then
			a["$i"]="O";
			
		fi
		
	done

	echo "_____________";
	echo "|   |   |   |";
	echo "| "${a[0]}" | "${a[1]}" | "${a[2]}" |"; #Imprime el gato con el arreglo auxiliar A
	echo "|___|___|___|";
}


bandera=0; #Indica el final del juego, si es 1, ganó el jugador 1, si es 2, ganó el jugador 2 y si es 3, empate.
contador=0; #Auxiliar que cuenta las casillas utilizadas, si es 9 y no hubo un ganador antes, bandera se vuelve 3 y rompe 
			#el ciclo while principal
line=(0 0 0 0 0 0 0 0 0); #Auxiliar que guarda las casillas utilizadas, si son 0 estan vacias, 1 es del jugador 1 y 2 
							#es del jugadr 2


echo "Vamos a jugar gato.";
echo "Jugador 1 es X. Jugador 2 es O.";
echo "Para hacer su movimiento, ingrese el número de casilla que quiere, basado en este cuadro:"
linea2 "1" "2" "3"; #El primer argumento es 1, entonces $1=1 en la función y asi sucesivamente.
linea2 "4" "5" "6"; #El primer argumento es 4, entonces $1=4 en la función y asi sucesivamente.
linea2 "7" "8" "9";

while [ $bandera = 0 ] #While principal, repetirá el programa hasta que haya un ganador o empate
do
#Jugador 1	
aux1=0;
aux2=0;
while [[ $aux2 = 0 ]]; do #while auxiliar que valida poder marcar la casilla deseada, si está libre, aux2 cambia de valor y sale
	if [[ $contador = 9 ]]; then
		bandera=3;	#Condicion de empate, rompe el while principal
		break;
	fi

	echo "Jugador 1, ingrese la casilla que desea: ";
	read N;
#Nota: teclear Enter en esta parte, lo toma como si hubiera tecleado la ultima posición.
#Se arregló agregando las primeras 2 condiciones del sig if 
#unicamente admite valores [1,9], no admite otra tecla.
#la tercera condición valida que el lugar esté libre	
	if [ "$N" -ge "1" 2>/dev/null ] && [ $N -le "9" ] && [ ${line[${N}-1]} = 0 ] 
		then

			line[${N}-1]=1; #añade la bandera del jugador al arreglo line en la posición deseada
			((contador++)); #aumenta contador
			aux2=1; #para salir del while auxiliar
		else
			clear;
			echo "Lugar ocupado o casilla invalida. Intente de nuevo.";

			
	fi
	done
	

	for (( i = 0; i < 9; i=i+3 )); do #Revisa las combinaciones de casillas 0-1-2/3-4-5/6-7-8 (horizontal) y si son iguales, gana
		if [ ${line[0+${i}]} = 1 ] && [ ${line[1+${i}]} = 1 ] && [ ${line[2+${i}]} = 1 ]
		then
			bandera=${line[0+${i}]};
			break;	
		fi
	done
	for (( i = 0; i < 3; i++ )); do #lo mismo de arriba pero con 0-3-6/1-4-7/2-5-8 (vertical)
		if [ ${line[0+${i}]} = 1 ] && [ ${line[3+${i}]} = 1 ] && [ ${line[6+${i}]} = 1 ]
		then
			bandera=${line[0+${i}]};
			break;
		fi
	done

	if [ ${line[0]} = 1 ] && [ ${line[4]} = 1 ] && [ ${line[8]} = 1 ] #revisa la diagonal
	then
		bandera=${line[0]};
		break;
	fi
	if [ ${line[2]} = 1 ] && [ ${line[4]} = 1 ] && [ ${line[6]} = 1 ] #revisa la diagonal invertida
	then
		bandera=${line[2]};
		break;
	fi

#en cada if, vuelve bandera igual al ganador

	if [[ $bandera = 1 ]]; then #rompe while principal
		break;
	fi
clear;
	for (( ir = 0; ir < 9; ir=ir+3 )); do #imprime el gato hasta el momento
			linea "${line[0+"${ir}"]}" "${line[1+"${ir}"]}" "${line[2+"${ir}"]}";
		done	
	
#son las mismas instrucciones, solo cambian los datos
while [[ $aux1 = 0 ]]; do
	if [[ $contador = 9 ]]; then
		bandera=3;
		break;
	fi
	echo "Jugador 2, ingrese la casilla que desea: ";
	read N;
	if [ "$N" -ge "1" 2>/dev/null ] && [ $N -le "9" ] && [ ${line[${N}-1]} = 0 ] #El comando 2>/dev/null redirecciona el error a un cubo de basura
		then
			line[${N}-1]=2;
			((contador++));
			aux1=1;
		else
			clear;
			echo "Lugar ocupado. Intente de nuevo.";
			
	fi
	done
	
	echo $contador;
	for (( i = 0; i < 9; i=i+3 )); do
		if [ ${line[0+${i}]} = 2 ] && [ ${line[1+${i}]} = 2 ] && [ ${line[2+${i}]} = 2 ]
		then
			bandera=${line[0+${i}]};
			break;	
		fi
	done
	for (( i = 0; i < 3; i++ )); do
		if [ ${line[0+${i}]} = 2 ] && [ ${line[3+${i}]} = 2 ] && [ ${line[6+${i}]} = 2 ]
		then
			bandera=${line[0+${i}]};
			break;
		fi
	done

	if [ ${line[0]} = 2 ] && [ ${line[4]} = 2 ] && [ ${line[8]} = 2 ]
	then
		bandera=${line[0]};
		break;
	fi
	if [ ${line[2]} = 2 ] && [ ${line[4]} = 2 ] && [ ${line[6]} = 2 ] 
	then
		bandera=${line[2]};
		break;
	fi
clear;
for (( ir = 0; ir < 9; ir=ir+3 )); do
			linea "${line[0+"${ir}"]}" "${line[1+"${ir}"]}" "${line[2+"${ir}"]}";
		done	
done



clear;
for (( ir = 0; ir < 9; ir=ir+3 )); do #imprime el gato final
			linea "${line[0+"${ir}"]}" "${line[1+"${ir}"]}" "${line[2+"${ir}"]}";
		done	

if [[ $bandera = 3 ]]; then #valida el valor de bandera
	echo "Empate!"; #si es 3, empate
else
	echo "Ganó el jugador: "$bandera; #si es diferente de 3, imprime el jugador ganador
	imprime_ganaste;
fi


