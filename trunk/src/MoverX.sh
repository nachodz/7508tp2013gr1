#! /bin/bash

function MoverX () {
   # Si no se pasan los 3 parametros solicitados, es un error
   if [ $# -eq 4 ] 
   then
      return 1
   fi

   # Tomo los parametros
   origen=$1
   destino=$2
   comando=$3
   
   carpetaOrigen=${origen%/*}
   archivo=${origen##*/}
   
   # 1.1 Verifico si la carpeta de origen y de destino son iguales
   if [ $carpetaOrigen = $destino ] 
   then
      echo "Origen y destino iguales"
      return 1
   fi

   # 1.2 Verifico que existan el archivo origen y la carpeta destino
   if [ ! -f $origen  ] || [ ! -d $destino ]
   then
      echo "No existe origen o destino"
      return 1
   fi

   # 1.3 Verifico si es un archivo duplicado
   echo "$destino/$archivo"
   if [ -f "$destino/$archivo" ] 
   then
      # Verifico si existe la carpeta dup, si no, la creo
	  if [ ! -d "$destino/dup" ]; then
	     mkdir "$destino/dup"
      fi
	  
	  # Falta generar el n�mero de control
	  
	  #Copio el archivo a la carpeta de duplicados
      echo "Duplicado"
	  cp $origen "$destino/dup/$archivo"
	  return 1
   fi
     
   echo "Todo piola"
   cp $origen $destino
   return 0
}
