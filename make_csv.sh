#!/bin/bash

for i in `ls data/*.csv`; do 
   soubor=`echo "$i" | sed "s/\.csv//" | sed "s/data\///"`
   cp data/$soubor.csv csv/$soubor.csv
   gawk -v regexp='Ne .* 00:00:00' -f prevod.awk "data/$soubor.csv" > csv/$soubor-tydny.csv
   gawk -v regexp='00:00:00' -f prevod.awk "data/$soubor.csv" > csv/$soubor-dny.csv
   gawk -v regexp=' 01 00:00:00' -f prevod.awk "data/$soubor.csv" > csv/$soubor-mesice.csv
   gawk -v regexp='led 01 00:00:00' -f prevod.awk "data/$soubor.csv" > csv/$soubor-roky.csv
done
