#!/bin/bash

read -p "introduzca el nombre del departamento: " departamento
usuario="user_$departamento"
comprueba_usuario=$(getent passwd $usuario)
continue=0

#Comprueba si existe el usuario a crear:

if [ -z $comprueba_usuario ]
then
        adduser $usuario
        continue=1
else
        echo "El usuario ya existe"
fi

#Crea el directorio personal para el usuario
if [ $continue -eq 1 ]
then
        mkdir /home/$usuario/web_departamento
        chown $usuario: /home/$usuario/web_departamento
fi

#Añade el alias y reinicia apache
if [ $continue -eq 1 ]
then
        printf "\n \t Alias "/$departamento" "/home/$usuario/web_departamento"" >>  /etc/apache2/sites-available/alias_departamentos
        systemctl restart apache2
fi






