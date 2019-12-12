#!/bin/bash
mv netflix.csv netflix_old.csv
wget https://raw.githubusercontent.com/acocauab/practica2csv/master/netflix.csv
diferent=`diff netflix.csv netflix_old.csv`
if [[ ! -z "$diferent" ]];
then 	
	echo "Canvis en el fitxer netflix.csv, vols actualitzar el fitxer? [s/n]"
	read opcio
	if [ "$opcio" == "s" ];then
	rm netflix_old.csv
	elif [ "$opcio" == "n" ];then
	rm netflix.csv
	mv netflix_old.csv netflix.csv
	echo "Operacio abortada"
	fi
else
	rm netflix.csv
	mv netflix_old.csv netflix.csv
	echo "No hi ha canvis a cometre"
fi
