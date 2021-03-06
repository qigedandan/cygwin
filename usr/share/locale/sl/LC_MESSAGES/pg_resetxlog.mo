??    =        S   ?      8  9   9  -   s  ,   ?  8   ?  *     N   2  N   ?     ?  *   ?  +        G  !   c  )   ?  #   ?  &   ?  -   ?  !   (  !   J  +   l  "   ?  (   ?     ?  J   ?     D	     d	  #   ?	  #   ?	  #   ?	  \   ?	      K
  @   l
  D   ?
  &   ?
       )   )  )   S  )   }  )   ?  )   ?  )   ?     %  V   B  )   ?  )   ?  )   ?  )     )   A  )   k  )   ?  )   ?  )   ?  	     ?        ?  &   ?  !   ?  -        J     a  )   v  ?  ?  [   >  :   ?  7   ?  B     .   P  S     O   ?  (   #  3   L  0   ?     ?  5   ?  5     /   9  ,   i  7   ?  -   ?  .   ?  -   +  .   Y  4   ?     ?  Y   ?  %   -  #   S  &   w  &   ?  &   ?  ?   ?  %   p  M   ?  K   ?  &   0     W  O   j  +   ?  +   ?  +     +   >  +   j      ?  l   ?  +   $  +   P  ,   |  +   ?  +   ?  +     L   -  +   z  +   ?  
   ?  ?   ?  '   ?  (   ?  .   ?  4        N     i  +   ?     !   0              1   3   4          *         -                        8   7       6          2   
       (                          ;                "          9   )   <   .                  /   	          #      :   =   5   &   $                     ,           +      '                      %    
If these values seem acceptable, use -f to force reset.
 
Report bugs to <pgsql-bugs@postgresql.org>.
   --help          show this help, then exit
   --version       output version information, then exit
   -f              force update to be done
   -l TLI,FILE,SEG force minimum WAL starting location for new transaction log
   -n              no update, just show extracted control values (for testing)
   -o OID          set next OID
   -x XID          set next transaction ID
 %s resets the PostgreSQL transaction log.

 %s: OID (-o) must not be 0
 %s: cannot be executed by "root"
 %s: could not create pg_control file: %s
 %s: could not delete file "%s": %s
 %s: could not open directory "%s": %s
 %s: could not open file "%s" for reading: %s
 %s: could not open file "%s": %s
 %s: could not read file "%s": %s
 %s: could not read from directory "%s": %s
 %s: could not write file "%s": %s
 %s: could not write pg_control file: %s
 %s: fsync error: %s
 %s: internal error -- sizeof(ControlFileData) is too large ... fix xlog.c
 %s: invalid LC_COLLATE setting
 %s: invalid LC_CTYPE setting
 %s: invalid argument for option -l
 %s: invalid argument for option -o
 %s: invalid argument for option -x
 %s: lock file "%s" exists
Is a server running?  If not, delete the lock file and try again.
 %s: no data directory specified
 %s: pg_control exists but has invalid CRC; proceed with caution
 %s: pg_control exists but is broken or unknown version; ignoring it
 %s: transaction ID (-x) must not be 0
 64-bit integers Blocks per segment of large relation: %u
 Catalog version number:               %u
 Current log file ID:                  %u
 Database block size:                  %u
 Database system identifier:           %s
 Date/time type storage:               %s
 Guessed pg_control values:

 If you are sure the data directory path is correct, execute
  touch %s
and try again.
 LC_COLLATE:                           %s
 LC_CTYPE:                             %s
 Latest checkpoint's NextOID:          %u
 Latest checkpoint's NextXID:          %u
 Latest checkpoint's TimeLineID:       %u
 Maximum length of identifiers:        %u
 Maximum length of locale name:        %u
 Maximum number of function arguments: %u
 Next log file segment:                %u
 Options:
 The database server was not shut down cleanly.
Resetting the transaction log may cause data to be lost.
If you want to proceed anyway, use -f to force reset.
 Transaction log reset
 Try "%s --help" for more information.
 Usage:
  %s [OPTION]... DATADIR

 You must run %s as the PostgreSQL superuser.
 floating-point numbers pg_control values:

 pg_control version number:            %u
 Project-Id-Version: PostgreSQL 8.0
POT-Creation-Date: 2005-01-16 01:12+0000
PO-Revision-Date: 2005-01-17 01:43+0100
Last-Translator: Aleksander Kmetec <aleksander.kmetec@intera.si>
Language-Team: Slovenian <aleksander.kmetec@intera.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Poedit-Language: Slovenian
X-Poedit-Country: SLOVENIA
X-Generator: KBabel 1.3.1
 
?e se vam te vrednosti zdijo sprejemljive, uporabite -f za njihovo prisilno ponastavitev.
 
Napake sporo?ajte na naslov <pgsql-bugs@postgresql.org>.
   --help          izpi?i to pomo?, nato kon?aj program
   --version       izpi?i podatke o razli?ici, nato kon?aj program
   -f              prisili izvedbo posodobitve
   -l TLI,FILE,SEG dolo?i najmanj?o za?etno WAL lokacijo za novi dnevnik transakcij
   -n              ne posodabljaj, ampak samo prika?i vrednosti (za testiranje)
   -o OID          nastavi naslednji OID
   -x XID          nastavi naslednji ID transakcije
 %s ponastavi PostgreSQL-ov dnevnik transakcij.

 %s: OID (-o) ne sme biti 0
 %s: uporabnik "root" ne more poganjati tega programa
 %s: datoteke pg_control ni bilo mogo?e ustvariti: %s
 %s: datoteke "%s" ni bilo mogo?e pobrisati: %s
 %s: imenika "%s" ni bilo mogo?e odpreti: %s
 %s: datoteke "%s" ni bilo mogo?e odpreti za branje: %s
 %s: datoteke "%s" ni bilo mogo?e odpreti: %s
 %s: datoteke "%s" ni bilo mogo?e prebrati: %s
 %s: iz imenika "%s" ni bilo mogo?e brati: %s
 %s: datoteke "%s" ni bilo mogo?e zapisati: %s
 %s: datoteke pg_control ni bilo mogo?e zapisati: %s
 %s: fsync napaka: %s
 %s: interna napaka -- vrednost sizeof(ControlFileData) je prevelika ... popravite xlog.c
 %s: neveljavna nastavitev LC_COLLATE
 %s: neveljavna nastavitev LC_CTYPE
 %s: neveljaven argument k mo?nosti -l
 %s: neveljaven argument k mo?nosti -o
 %s: neveljaven argument k mo?nosti -x
 %s: najdena je bila zaklepna datoteka "%s"
Ali je stre?nik ?e zagnan? ?e ni, potem pobri?ite zaklepno datoteko in poskusite znova.
 %s: podatkovni imenik ni bil naveden
 %s: pg_control obstaja, vendar ima neveljaven CRC; nadaljujte s previdnostjo
 %s: pg_control obstaja, vendar je pokvarjen ali neznane verzije; ignoriram
 %s: ID transakcije (-x) ne sme biti 0
 64-bitni integerji ?tevilo blokov na posamezni segment
velike relacije ....................... %u
 Razli?ica kataloga .................... %u
 Trenutni ID dnevnika .................. %u
 Velikost bloka ........................ %u
 Identifikator sistema podatkovnih baz:  %s
 Na?in shranjevanja datuma/?asa ........ %s
 Uganjene pg_control vrednosti:

 ?e ste prepri?ani, da je pot do podatkovnega imenika pravilna, po?enite ukaz
  touch %s
in poskusite znova.
 LC_COLLATE ............................ %s
 LC_CTYPE .............................. %s
 NextOID zadnje kontrolne to?ke ......... %u
 NextXID zadnje kontrolne to?ke ........ %u
 TimeLineID zadnje kontrolne to?ke ..... %u
 Najve?ja dol?ina identifikatorjev ..... %u
 Najve?ja dol?ina imena podro?nih
nastavitev (locale settings) .......... %u
 Najve?je ?tevilo argumentov funkcije .. %u
 Naslednji segment dnevnika ............ %u
 Mo?nosti:
 Podatkovni stre?nik ni bil pravilno zaustavljen.
Ponastavitev dnevnika transakcij lahko povzro?i izgubo podatkov.
?e kljub temu ?elite nadaljevati, uporabite -f za prisilno ponastavitev.
 Dnevnik transakcij je bil ponastavljen
 Za ve? informacij poskusite "%s --help"
 Uporaba:
  %s [MO?NOST]... PODATKOVNI_IMENIK

 Program %s morate zagnati kot PostgreSQL superuser.
 ?tevila s plavajo?o vejico pg_control vrednosti:

 Razli?ica pg_control .................. %u
 