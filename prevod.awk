BEGIN { 
   FS = ";" 
};
function nacti_zaznam(datum_, smer1_, smer2_, soucet_, teplota_) {
   if(datum == ""){
      datum = datum_
   }

   smer1 += smer1_
   smer2 += smer2_
   soucet += soucet_
   teplota += teplota_
   i += 1

   d = datum_
   gsub("-", " ", d)
   gsub(":", " ", d)
   date = strftime("%a %b %d %H:%M:%S %Z %Y", mktime(d))

   if(match(date, regexp) != 0){
      print datum,";",smer1,";", smer2,";", soucet,";", teplota/i
      smer1 = 0
      smer2 = 0
      soucet = 0
      teplota = 0
      i = 0

      datum = datum_
   }
}

/^[0-9]{4}-[0-9]{2}-[0-9]{2} ([0-9]{2}:){2}[0-9]{2}(;[0-9]*){3};[-0-9]*$/{
   nacti_zaznam($1, $2, $3, $4, $5)
}

/^[0-9]{4}-[0-9]{2}-[0-9]{2} ([0-9]{2}:){2}[0-9]{2}(;[-0-9]*){2};[-0-9]*$/{
   nacti_zaznam($1, $2, 0, $3, $4)
}

END {
      print datum,";",smer1,";", smer2,";", soucet,";", teplota/(i+1)
      print $1,"; 0; 0; 0; 0"
}
