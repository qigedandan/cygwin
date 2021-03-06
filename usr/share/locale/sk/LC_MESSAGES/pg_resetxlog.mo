??    ;      ?  O   ?        9   	  -   C  ,   q  8   ?  *   ?  N     N   Q     ?  *   ?  +   ?       )   3  #   ]  &   ?  -   ?  !   ?  !   ?  +     "   F  (   i     ?  J   ?     ?     	  #   0	  #   T	  #   x	  \   ?	      ?	  @   
  D   [
  &   ?
     ?
  )   ?
  )     )   +  )   U  )     )   ?     ?  V   ?  )   G  )   q  )   ?  )   ?  )   ?  )     )   C  )   m  )   ?  	   ?  ?   ?     j  &   ?  !   ?     ?     ?  )   ?  5     X   V  6   ?  J   ?  B   1  2   t  ~   ?  w   &  2   ?  =   ?  )        9  3   U  ,   ?  .   ?  :   ?  ,      1   M  1     -   ?  3   ?       ]   (  $   ?  "   ?  %   ?  %   ?  %     h   @  #   ?  D   ?  O     %   b     ?  7   ?  7   ?  6     6   H  8     6   ?  !   ?  l     4   ~  4   ?  6   ?  6     6   V  8   ?  8   ?  7   ?  6   7     n  ?   w     ,  3   I  /   }  &   ?     ?  6   ?     -      2   9          "                  !   '   $               4   3       +      	   #      7                                       (   .             *      0          %          ;      &      /   ,         1          :      5              
              8       )             6    
If these values seem acceptable, use -f to force reset.
 
Report bugs to <pgsql-bugs@postgresql.org>.
   --help          show this help, then exit
   --version       output version information, then exit
   -f              force update to be done
   -l FILEID,SEG   force minimum WAL starting location for new transaction log
   -n              no update, just show extracted control values (for testing)
   -o OID          set next OID
   -x XID          set next transaction ID
 %s resets the PostgreSQL transaction log.

 %s: OID (-o) must not be 0
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

 floating-point numbers pg_control values:

 pg_control version number:            %u
 Project-Id-Version: pg_resetxlog-sk
POT-Creation-Date: 2004-08-05 07:23-0300
PO-Revision-Date: 2004-08-13 15:12+0200
Last-Translator: Zoltan Bartko <bartko.zoltan@pobox.sk>
Language-Team: slovak
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.3
 
Ak sa tieto hodnoty zdajú byť prijateľné, použite -f pre vynútenie 
vynulovania.
 
Chyby hláste na adresu <pgsql-bugs@postgresql.org>.
   --help             zobraziť túto nápovedu, potom ukončiť činnosť
   --version          zobraziť informácie o verzii, potom koniec
   -f              vynúť vykonanie aktualizácie
   -l ID_SÚBORU,SEG                   vynúť minimálne umiestnenie štartu WAL pre nový log 
                  transakcií
   -n              žiadne aktualizcácie, iba zobraz extrahované riadiace 
                  hodnoty (pre testovanie)
   -o OID          nastav nasledujúcu hodnotu OID
   -x XID          nastav ID hodnotu nasledujúcej transakcie
 %s vynuluje log transakcií PostgreSQL.

 %s: OID (-o) nesmie byť 0
 %s: nebolo možné vytvoriť súbor pg_control: %s
 %s: nebolo možné vymazať súbor "%s": %s
 %s: nebolo možné otvoriť adresár "%s": %s
 %s: nebolo možné otvoriť súbor "%s" pre čítanie: %s
 %s: nebolo možné otvoriť súbor "%s": %s
 %s: nebolo možné čítať zo súboru: "%s": %s
 %s: nebolo možné čítať z adresára "%s": %s
 %s: nebolo možné zapísať súbor "%s": %s
 %s: nebolo možné zapísať súbor pg_control: %s
 %s: chyba fsync: %s
 %s: interná chyba -- hodnota sizeof(ControlFileDate) je príliš veľká ...
opravte xlog.c
 %s: neplatné nastavenie LC_COLLATE
 %s: neplatné nastavenie LC_CTYPE
 %s: neplatný argument pre voľbu -l
 %s: neplatný argument pre voľbu -o
 %s: neplatný argument pre voľbu -x
 %s: existuje súbor uzamknutia "%s"
Beží server? Ak nie, vymažte spúbor uzamknutia a skúste znovu.
 %s: nezadali ste dátový adresár
 %s: pg_control existuje, ale má neplatné CRC; pokračujte opatrne
 %s: pg_control existuje, ale je porušený alebo neznámej verzie. Ignoruje sa
 %s: ID transakcie (-x) nesmie byť 0
 64-bitové celé čísla Počet blokov v segmente veľkej relácie:          %u
 číslo verzie katalógu:                           %u
 ID aktuálneho log súboru:                        %u
 Veľkosť bloku databázy:                         %u
 Systémový identifikátor databázy:                %s
 Ukladanie typov dátumu a času:                   %s
 Odhadované hodnoty pg_control:

 Ak máte istotu, že cesta k dátovému adresáru je správna, použite príkaz
  touch %s
a skúste znovu.
 LC_COLLATE:                                      %s
 LC_CTYPE:                                        %s
 NextOID posledného kontrolného bodu:             %u
 NextXID posledného kontrolného bodu:             %u
 TimeLineID posledného kontrolného bodu:          %u
 Maximálna dĺžka identifikátorov:                 %u
 Maximálna dĺžka názvu lokálnych nastavení:     %u
 Maximálny počet argumentov funkcií:              %u
 Nasledujúci segment log súboru:                  %u
 Voľby:
 Databázový server nebol vypnutý riadne.
Vynulovanie logu transakcií môže spôsobiť stratu dát.
Ak chcete napriek tomu pokračovať, použite -f pre vynútenie vynulovania.
 Vynulovanie logu transkcií
 Zadajte '%s --help' pre detailnejšie informácie.
 Použitie:
  %s [VOĽBY]... DÁTOVÝ_ADRESÁR

 čísla s pohyblivou rádovou čiarkou hodnoty pg_control:

 číslo verzie programu pg_control:                %u
 