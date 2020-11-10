#!/bin/bash
#Script que muestra la fecha del sistema completa
#Comando que propongo --->"fecha completa"
DAY=`date +"%A"`;
NUMBERDAY=`date +"%d"`;
MONTH=`date +"%B"`;
YEAR=`date +"%Y"`;
echo "Hoy es $DAY $NUMBERDAY de $MONTH de $YEAR";