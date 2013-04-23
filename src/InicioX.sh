#!/bin/bash

#===========================================================
# ARCHIVO: InicioX.sh
#
# FIRMA: TODO:HACER!
#
# DESCRIPCION: TODO:HACER!
#
# AUTOR: De Zan, Ignacio. 
# PADRON: 91525
#
#===========================================================

#Inicializar el archivo log con GlogX

function grabarLog {
 cmd="[InicioX]" 
 msj="Inicio de Ejecución"
 tmsj="I"

 #GlogX "$cmd" "$msj" "$tmsj"
 
 echo $cmd $msj $tmsj

}

# Chequea que existan los comandos en la carpeta BINDIR, 
# y tengan los permisos de ejecucion seteados,sino los setea.

function chequearComandos {

 for i in ${comandos[*]}
   do
     if [ -f $BINDIR/$i ]; then
          echo "El comando $i existe\n"
 
          if [ -x $BINDIR/$i ]; then 
            echo "y tiene permisos de ejecucion\n"
          else 
            chmod 777 $BINDIR/$i
            echo `ls -l $BINDIR/$i`
          fi
         
     else
        echo "El comando $i no existe\n" 
     fi
   done  
}

# Chequea que existan los maestros en la carpeta MAEDIR, 
# y tengan los permisos de lectura seteados,sino los setea.

function chequearMaestros {

 for i in PPI.mae p-s.mae
   do
     if [ -f $MAEDIR/$i ]; then
          echo "El archivo maestro $i existe\n"
 
          if [ -r $MAEDIR/$i ] &&  ! [ -w $MAEDIR/$i ]; then 
            echo "y tiene permisos de lectura, pero no escritura\n"
          else 
            chmod 444 $MAEDIR/$i
            echo `ls -l $MAEDIR/$i`
          fi
         
     else
        echo "El archivo maestro $i no existe\n" 
     fi
   done  

}

# Chequea que existan las tablas en la carpeta CONFDIR, 
# y tengan los permisos de lectura seteados,sino los setea.

function chequearTablas {

 for i in T2.tab T1.tab
   do
     if [ -f $CONFDIR/$i ]; then
          echo "El archivo maestro $i existe\n"
 
          if [ -r $CONFDIR/$i ] &&  ! [ -w $CONFDIR/$i ]; then 
            echo "y tiene permisos de lectura, pero no escritura\n"
          else 
            chmod 444 $CONFDIR/$i
            echo `ls -l $CONFDIR/$i`
          fi
         
     else
        echo "El archivo maestro $i no existe\n"
     fi
   done  

}

# Lee las variables de Config del archivo InstalX.conf

function setVariablesDeConfiguracion {

 for var in ${variables[*]}
   do    
    export $var=`grep "$var" "$1" | cut -d"=" -f 2`
   done 
}

#Verifica que las variables de ambiente este seteadas

function chequearVarConfig {

   for var in ${variables[*]}
     do
       res=`env | grep $var | cut -d"=" -f 2`
       if [ -z $res ]; then
         echo "Falta la variable de ambiente $var" >> errorVar.tmp
       else
         echo "$var=$res"
       fi      
     done
    
    if [ -f errorVar.tmp ]; then
      mostrarArchivo "errorVar.tmp"
      rm errorVar.tmp
    else
      return 1
    fi
}

# Muestra archivo por pantalla

function mostrarArchivo {
  
  while read -r linea
   do
     echo $linea
   done < $1
}

# Chequea que la carpeta donde se encuentran los comandos, este incluido en la variable PATH,
# para su correcta ejecucion, sino lo setea

function chequearPaths {
   
   ejec=`echo $PATH | grep $BINDIR`

   # echo $ejec    Sacar!

   if [ -z $ejec ]; then

    echo "No esta el path de ejecutables, agregando..."
    export PATH=$PATH:$BINDIR
    echo "Agregado"
   # echo $PATH --- Sacar!

   else

    echo "Esta el path de ejecutables"
    # echo $PATH --- Sacar!

   fi 
}
 
#Funcion principal

function main {

  variables=(GRUPO BINDIR MAEDIR ARRIDIR ACEPDIR RECHDIR PROCDIR REPODIR LOGDIR LOGEXT LOGSIZE DATASIZE)

  comandos=(InstalarX.sh InicioX.sh DetectaX.sh Interprete.sh Reporte.pl MoverX.sh StartX.sh StopX.sh GlogX.sh VlogX.sh)

  confFile=InstalX.conf

  CONFDIR="/home/nacho/Escritorio/PruebasSSOO/Config"
  
  #grabarLog
  if [ chequearVarConfig == 1 ]; then
    echo "No hay faltantes"
  else
     echo "Hay faltantes"
  fi 
  #setVariablesDeConfiguracion $CONFDIR/$confFile
  #chequearPaths
  #chequearComandos
  #chequearMaestros
  #chequearTablas
  

}

main
