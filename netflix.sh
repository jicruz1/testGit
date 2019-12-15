#!/bin/bash

menu()
{
	echo "1.Recomanació ràpida."
	echo "2.Llistar per any."
	echo "3.Llistar per rating."
	echo "4.Sortir."
}

recomanacio()
{
echo "-----------------------------------
 Recomanació rápida
-----------------------------------"
	randomTitle=`shuf -n 1 netflix1.csv`
	nom=`echo $randomTitle | cut -d , -f 1`

while [ "$nom" == "title" ]; do
	randomTitle=`shuf -n 1 netflix1.csv`
	nom=`echo $randomTitle | cut -d , -f 1`
done
	any=`echo $randomTitle | cut -d , -f 5`
	rating=`echo $randomTitle | cut -d , -f 2`
	descripcio=`echo $randomTitle | cut -d , -f 3`
	echo $nom , $any
	echo $rating
	echo $descripcio
}

llistarAny()
{
 printf "\033c"
 echo "Insereix l'any:"
 read any
 printf "\033c"

OLDIFS=$IFS
IFS=","
while read title rating ratinglevel ratingdescription release_year user_rating_score user_rating_size
 do

   if [ $any == $release_year ] ;
   then echo $title , $rating
	echo "----------------------------------"
   fi
 done < netflix1.csv
 IFS=$OLDIFSIFS=$OLDIFS
sleep 3

}
rating()
{
 printf "\033c"
 echo "Insereix el rating [1-5]:"
 read nombre
 printf "\033c"

 OLDIFS=$IFS
 IFS=","
 while read title rating ratinglevel ratingdescription release_year user_rating_score user_rating_size
 do
   case $nombre in
	1)	
		if [[ ! -z "$user_rating_score" ]];
		then
			if [ "$user_rating_score" -ge 0 ] && [ "$user_rating_score" -lt 65 ];
			then
				echo "[     *     ] , " $title , $release_year
			elif [ "$user_rating_score" -ge 65 ] && [ "$user_rating_score" -lt 75 ];
			then
				echo "[    * *    ] , " $title , $release_year
			elif [ "$user_rating_score" -ge 75 ] && [ "$user_rating_score" -lt 85 ];
			then
				echo "[   * * *   ] , " $title , $release_year
			elif [ "$user_rating_score" -ge 85 ] && [ "$user_rating_score" -lt 95 ];
			then
				echo "[  * * * *  ] , " $title , $release_year
			elif [ "$user_rating_score" -ge 95 ];
			then
				echo "[ * * * * * ] , " $title , $release_year
			fi
		fi
		;;
	2)
		if [[ ! -z "$user_rating_score" ]];
		then
			if [ "$user_rating_score" -ge 65 ] && [ "$user_rating_score" -lt 75 ];
			then
				echo "[    * *    ] , " $title , $release_year
			elif [ "$user_rating_score" -ge 75 ] && [ "$user_rating_score" -lt 85 ];
			then
				echo "[   * * *   ] , " $title , $release_year
			elif [ "$user_rating_score" -ge 85 ] && [ "$user_rating_score" -lt 95 ];
			then
				echo "[  * * * *  ] , " $title , $release_year
			elif [ "$user_rating_score" -ge 95 ];
			then
				echo "[ * * * * * ] , " $title , $release_year
			fi
		fi
		;;
	3)
		
		if [[ ! -z "$user_rating_score" ]];
		then
			if [ "$user_rating_score" -ge 75 ] && [ "$user_rating_score" -lt 85 ];
			then
				echo "[   * * *   ] , " $title , $release_year
			elif [ "$user_rating_score" -ge 85 ] && [ "$user_rating_score" -lt 95 ];
			then
				echo "[  * * * *  ] , " $title , $release_year
			elif [ "$user_rating_score" -ge 95 ];
			then
				echo "[ * * * * * ] , " $title , $release_year
			fi
		fi
		;;
	4)
		if [[ ! -z "$user_rating_score" ]];
		then
			if [ "$user_rating_score" -ge 85 ] && [ "$user_rating_score" -lt 95 ];
			then
				echo "[  * * * *  ] , " $title , $release_year
			elif [ "$user_rating_score" -ge 95 ];
			then
				echo "[ * * * * * ] , " $title , $release_year
			fi
		fi
		;;
	5)
		if [[ ! -z "$user_rating_score" ]];
		then
			if [ "$user_rating_score" -ge 95 ];
			then
				echo "[ * * * * * ] , " $title , $release_year
			fi
		fi
		;;
	*)
		echo "Nombre no valid"
		exit
		;;
	esac
 done < netflix2.csv
 IFS=$OLDIFSIFS=$OLDIFS
sleep 3
}

cat netflix.csv | sort | uniq > netflix1.csv
cat netflix1.csv | sort -t\, -k6,6 > netflix2.csv
sed -i '$ d' netflix2.csv
printf "\033c"
menu
read opcio
printf "\033c"
while [ $opcio != 4 ]; do

	if [ $opcio == 1 ]; then
	printf "\033c"
	recomanacio
	sleep 1
	printf "\033c"
	elif [ $opcio == 2 ]; then
	printf "\033c"
	llistarAny
	sleep 1
	printf "\033c"
	elif [ $opcio == 3 ]; then
	printf "\033c"
	rating
	sleep 7
	printf "\033c"
	elif [ $opcio != 4 ]; then
	printf "\033c"
        echo "Error opcio" $opcio "es incorrecte"
	sleep 1
	printf "\033c"
	fi
menu
read opcio
printf "\033c"
done
echo "Something"
