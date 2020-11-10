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

read -p  "$(echo -e "$ROJO Ingresa la ruta absoluta del directorio $RESET"  )" -a ubiact

menuRep()
{

  #VARIABLES LOCALES:
  opcion=0
  band=1

  while [ $opcion -ne 3 ]; do
    clear

    printf " Tu ubicacion actual es: $AZUL$ubiact$RESET \n\n"
    printf " Menu del reproductor ProlinShell:\n\n"
    printf "\t 1.- Reproducir la lista de la carpeta actual\n"
    printf "\t 2.- Listar opciones del reproductor ProlinShell\n"
    printf "\t 3.- Salir del reproductor ProlinShell\n\n"
    printf " Seleccione una opcion: "
    read opcion

    if [ $opcion -le 0 -o $opcion -ge 4 ]; then
      printf "\n Dato invalido, presione cualquier tecla para continuar ... "
      read opcion
      opcion=0;

    else

      #LIMPIAMOS LA PANTALLA:
      command clear

      #INGRESAMOS A UNA DE LAS OPCIONES ESCOGIDAS POR EL USUARIO:
      if [ $opcion -eq 1 ]; then

        cont=1
        for archivo in $ubiact/*.mp3; do
          #printf "\n\t$cont. ${archivo##*/}\n\n"
          canciones[$(($cont-1))]="${archivo##*/}"
          cont=$(($cont+1))
        done

        if [ $(which mpg123) ]; then

          while [ $band -eq 1 ]; do
            printf "\n\t                REPRODUCCION DE LA LISTA ACTUAL             n\n"
            printf " Directorio actual: $AZUL$ubiact$RESET \n\n"

            cont=1
            for archivo in $ubiact/*.mp3; do
              printf "\n\t$cont. ${archivo##*/}"
              canciones[$(($cont-1))]="${archivo##*/}"
              cont=$(($cont+1))
            done

            printf "\n\n Seleccione una opcion:\n"
            printf "\n [ # ]: Reproduce el numero de cancion seleccionado (# - cualquier numero mayor a 0 y menor al total)."
            printf "\n [ * ]: Reproduce todas las canciones de la lista."
            printf "\n [ 0 ]: Reproduce la lista de canciones aleatoramente."
            printf "\n [ q ]: Salir.\n"
            printf "\n Opcion: "
            read opcion

            if [ "$opcion" = "q" ]; then
              band=0

            elif [ "$opcion" = "*" ]; then
              numero=1
              while [ $numero -eq 1 ]; do
                for archivo in "$ubiact"/*; do
                  if [ "${archivo##*.}" = "mp3" ]; then
                    command mpg123 "${archivo##*/}"
                  fi
                done
                printf "\n La reproduccion de todos los archivos a concluido, desea reiniciar la reproduccion [1 - si / ! 1 - salir]: "
                read numero
                if [ $numero -ne 1 ]; then
                  band=0
                  printf "\n Presione enter para continuar ... "
                  read opcion
                fi
              done

            elif [ $opcion -gt 0 ]; then
              if [ $opcion -lt $cont ]; then
                printf "\n $AZULReproduccion iniciada$RESET\n\n"
                printf "\n Para quitar reproduccion presione q y enter ...\n\n"
                command mpg123 "${canciones[$opcion]}"
                read opcion
              else
                printf "\n Error, no es posible acceder al numero ingresado ya que esta fuera del limite."
                printf "\n Presione 0 y enter para salir o solo enter para continuar: "
                read opcion
                if [ $opcion -eq 0 ]; then
                  band=0
                fi
              fi


            elif [ $opcion -eq 0 ]; then
              command clear
              printf "\n\n Para quitar reproduccion presione q y enter ...\n\n"
              command mpg123 -z "${ubiact}"/*

            else
              command clear
              printf "\n\n\n Opcion invalida solo es posible ingresar numeros"
              printf "\n\n Presione enter para continuar... "
              read opcion
            fi

            command clear

            opcion=0
          done

          band=1

        else
          printf "\n Para iniciar el reproductor es necesario tener instalado mpg123\n"
          printf "\n Desea instalar el reproductor mpg123 [y - si /n - no]: "
          read var
          printf "\n -> $var"
          if [ $var = "y" ]; then
            $instmp
            printf "\n Presione enter para continuar ..."
            read var
            #opcion=0;
          elif [ $var = "n" ]; then
            opcion=0;
          else
            printf "\n ¡Opcion invalida! ..."
          fi
        fi
      fi

      if [ $opcion -eq 2 ]; then
        printf "\n\t>>>>>>>>>>>>>> LISTA DE OPCIONES DEL REPRODUCTOR PREBESHELL <<<<<<<<<<<<<<\n\n"
        printf " [s] o [space] > Pausar\n"
        printf " [f]           > Siguiente\n"
        printf " [d]           > Previa\n"
        printf " [b]           > Repetir\n"
        printf " [.]           > Adelante\n"
        printf " [a]           > Atras\n"
        printf " [+]           > Subir volumen\n"
        printf " [-]           > Bajar volumen\n"
        printf " [q]           > Quitar reproduccion\n\n"
        printf " Presione cualquier tecla para continuar ... "
        read opcion
        opcion=0;
      fi
    fi
  done

  #LIMPIAMOS LA PANTALLA:
  command clear
}

menuRep