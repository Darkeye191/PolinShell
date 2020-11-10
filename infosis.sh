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

Mtotal=`cat /proc/meminfo | grep "MemTotal" | grep "[1-9].*" -o`
Mlibre=`cat /proc/meminfo | grep "MemFree" | grep "[1-9].*" -o`
Mswap=`cat /proc/meminfo | grep "SwapTotal" | grep "[1-9].*" -o`

#Creacion de variables para estetica

SO=`cat /proc/sys/kernel/ostype`
Kernel=`cat /proc/version | awk {'print $3'}`
Procesador=`cat /proc/cpuinfo | grep --max-count=1 "model name"`
VProcesador=`cat /proc/cpuinfo | grep "cpu MHz"`
CProcesador=`cat /proc/cpuinfo | grep --max-count=1 "cache size"`

clear

echo -e "$AZUL Tu sistema cuenta con :$RESET"
echo ""
echo -e "Sistema operativo es $AMARILLO $SO $RESET"
echo -e "La versión del kernel es $AMARILLO$Kernel$RESET"
echo ""
echo -e "La memoria total es de $AMARILLO$Mtotal$RESET"
echo -e "La memorial libre es de $AMARILLO$Mlibre$RESET"
echo -e "La swap es de $AMARILLO$Mswap$RESET"
echo ""
echo -e "El procesador es: $AMARILLO$Procesador$RESET"
echo -e "El tamaño de la memoria caché es de: $AMARILLO$CProcesador$RESET"
echo -e "La velodcidad de cada nucleo es\n$AMARILLO$VProcesador$RESET"