#!/bin/bash
#Script que nos arroja la hora en un formato simple h/min donde hora va de 1-12 y min de 0-60
#Comando que propongo ---> "hora" o "hora simple"
#%r nos permite obtener la hora considerando la numeración de 1-12 y %p sirve para indicar si es am o pm
HORA=`date +"%r %p"`;
echo "Son las $HORA"; #Imprimimos en consola