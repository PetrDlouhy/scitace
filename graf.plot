#!/bin/bash
soubor=`echo "$1" | sed "s/\.csv//" | sed "s/data\///"`
nazev=`echo "$soubor" | sed "s/_/ /g"`

gnuplot <<EOF
reset
#set terminal postscript enhanced color
set terminal png enhanced truecolor size 1024,768
#set terminal canvas size 1024,768 enhanced standalone mousing
set datafile commentschars "#"
set locale "cs_CZ.UTF-8"
#set decimalsign locale "cs_CZ.UTF-8"
set decimalsign "."
set format y "%'.0f"
set encoding utf8
set title "Počet cyklistů na měřeném profilu ${nazev}"
set ylabel "Počet"
#set y2label "Teplota"
set y2tics nomirror tc lt 3
set xlabel "Čas"
set datafile separator ";"
set grid

set xtics rotate
set xdata time
set format x "%b %Y"
set timefmt "%Y-%m-%d %H:%M"
#set xrange ["2010-11-03 01:00":"2010-11-16 13:00"]

#set output "grafy/$soubor.html"
set output "grafy-png/$soubor.png"
plot "data/$soubor.csv" \
in 0 u 1:2 t "směr 1"  with steps linestyle 1 linetype rgb "red" lw 1,\
'' in 0 u 1:3 t "směr 2"  with steps linestyle 1 linetype rgb "green" lw 1,\
'' in 0 u 1:4 t "součet" with steps linestyle 1 linetype rgb "blue" lw 1
#'' in 0 u 1:5 axes x1y2 with steps t "teplota"

set title "Počet cyklistů na měřeném profilu ${nazev} - součty po týdnu"

#set output "grafy/${soubor}-tydny.html"
set output "grafy-png/${soubor}-tydny.png"
plot "<gawk -v regexp='Ne .* 00:00:00' -f prevod.awk \"data/$soubor.csv\"" \
in 0 u 1:2 with steps t "směr 1",\
'' in 0 u 1:3 with steps t "směr 2",\
'' in 0 u 1:4 with steps t "součet"
#'' in 0 u 1:5 axes x1y2 with steps t "průměrná teplota"

set title "Počet cyklistů na měřeném profilu ${nazev} - součty po dni"

#set output "grafy/${soubor}-dny.html"
set output "grafy-png/${soubor}-dny.png"
plot "<gawk -v regexp='00:00:00' -f prevod.awk \"data/$soubor.csv\"" \
in 0 u 1:2 with steps t "směr 1",\
'' in 0 u 1:3 with steps t "směr 2",\
'' in 0 u 1:4 with steps t "součet"
#'' in 0 u 1:5 axes x1y2 with steps t "průměrná teplota"

set title "Počet cyklistů na měřeném profilu ${nazev} - součty po měsíci"

#set output "grafy/${soubor}-mesice.html"
set output "grafy-png/${soubor}-mesice.png"
plot "<gawk -v regexp=' 01 00:00:00' -f prevod.awk \"data/$soubor.csv\"" \
in 0 u 1:2 with steps t "směr 1",\
'' in 0 u 1:3 with steps t "směr 2",\
'' in 0 u 1:4 with steps t "součet"
#'' in 0 u 1:5 axes x1y2 with steps t "průměrná teplota"

set title "Počet cyklistů na měřeném profilu ${nazev} - součty po roce"

#set output "grafy/${soubor}-roky.html"
set output "grafy-png/${soubor}-roky.png"
plot "<gawk -v regexp='led 01 00:00:00' -f prevod.awk \"data/$soubor.csv\"" \
in 0 u 1:2 with steps t "směr 1",\
'' in 0 u 1:3 with steps t "směr 2",\
'' in 0 u 1:4 with steps t "součet"
#'' in 0 u 1:5 axes x1y2 with steps t "průměrná teplota"
EOF
