#!/bin/bash

touch years.txt					#crea fitxer per desar tots els diferents anys

cp netflix.csv netflix1.csv			#crea copia del csv original
sed -i '1d' netflix1.csv			#mateix fitxer pero sense la capçalera
cat netflix1.csv | sort | uniq > netflix2.csv	#segona copia pero eliminant duplicats

file=netflix2.csv
nLinies=`wc -l $file | cut -d ' ' -f1`		#compta el nº de linies del fitxer i ho guarda en un variable

for j in `seq 2 1 $nLinies`;do					#bulce que llegeix cada linia del fitxer
	year=`head -n$j $file | tail -n 1 | cut -d ',' -f5`	#filtra nomes l'any
	echo $year >> years.txt					#imprimeix aquest any en el fitxer txt
done

sort years.txt | uniq > years1.txt		#ordena els anys del fitxer, elimina duplicats i ho desa en years1.txt
rm years.txt

while read year; do				#bulce que llegeix els anys del fitxer txt i crea una carpeta per cada any
	mkdir $year
	touch $year/$year-netflix.csv		#dins de aquesta carpeta crea un fitxer csv amb aquest format
done < years1.txt

for k in `seq 2 1 $nLinies`;do					#bucle que llegeix el netflix2.csv lina per linia
	year=`head -n$k $file | tail -n 1 | cut -d ',' -f5`	#filtra l'any
	linia=`head -n$k $file | tail -n 1`			#filtra la linia sencera
	echo $linia >> $year/$year-netflix.csv			#imprimeix la linia en el fitxer coincident amb l'any
done
rm years1.txt
rm netflix1.csv
rm netflix2.csv
