??    *      l  ;   ?      ?  N   ?  C   ?  -   <  !   j      ?     ?  )   ?  )   ?  )     )   ;  )   e  )   ?  )   ?  )   ?  )     )   7  ,   a  )   ?  )   ?  ,   ?  )     ,   9  )   f  )   ?  )   ?  )   ?  ,     ,   ;  )   h  &   ?  ?   ?  ?   y	     @
     W
     e
  )   q
  )   ?
  	   ?
     ?
     ?
     ?
  7    K   :  D   ?  :   ?  /     #   6     Z  7   s  5   ?  7   ?  6     6   P  5   ?  8   ?  6   ?  4   -  4   b  9   ?  6   ?  6     ;   ?  6   {  ;   ?  8   ?  8   '  7   `  6   ?  :   ?  5   
  7   @  B   x  ?   ?  ?   ?  &   ?     ?     ?  5   ?  6   *     a     r     ?     ?                                                          !                         )   	          
   *   &          "             #         (   '      %                                                $       
If no data directory is specified, the environment variable PGDATA
is used.

 %s displays control information of a PostgreSQL database cluster.

 %s: could not open file "%s" for reading: %s
 %s: could not read file "%s": %s
 %s: no data directory specified
 64-bit integers Blocks per segment of large relation: %u
 Bytes per WAL segment:                %u
 Catalog version number:               %u
 Current log file ID:                  %u
 Database block size:                  %u
 Database cluster state:               %s
 Database system identifier:           %s
 Date/time type storage:               %s
 LC_COLLATE:                           %s
 LC_CTYPE:                             %s
 Latest checkpoint location:           %X/%X
 Latest checkpoint's NextOID:          %u
 Latest checkpoint's NextXID:          %u
 Latest checkpoint's REDO location:    %X/%X
 Latest checkpoint's TimeLineID:       %u
 Latest checkpoint's UNDO location:    %X/%X
 Maximum length of identifiers:        %u
 Maximum length of locale name:        %u
 Maximum number of function arguments: %u
 Next log file segment:                %u
 Prior checkpoint location:            %X/%X
 Report bugs to <pgsql-bugs@postgresql.org>.
 Time of latest checkpoint:            %s
 Try "%s --help" for more information.
 Usage:
  %s [OPTION]

Options:
  DATADIR        show cluster control information for DATADIR
  --help         show this help, then exit
  --version      output version information, then exit
 WARNING: Calculated CRC checksum does not match value stored in file.
Either the file is corrupt, or it has a different layout than this program
is expecting.  The results below are untrustworthy.

 floating-point numbers in production in recovery pg_control last modified:             %s
 pg_control version number:            %u
 shut down shutting down starting up unrecognized status code Project-Id-Version: pg_controldata-sk
POT-Creation-Date: 2004-08-02 07:22-0300
PO-Revision-Date: 2004-08-02 15:53+0200
Last-Translator: Zoltan Bartko <bartko.zoltan@pobox.sk>
Language-Team: slovak
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.3
 
Ak neurčíte dátový adresár, použije sa premenná prostredia PGDATA

 %s zobrazí riadiace informácie o zoskupení databáz PostgreSQL.

 %s: nebolo možné otvoriť súbor "%s" pre čítanie: %s
 %s: nebolo možné načítať súbor: "%s": %s
 %s: nezadali ste dátový adresár
 64-bitové celé čísla Počet blokov v segmente veľkej relácie:          %u
 Počet bajtov v segmente WAL:                     %u
 číslo verzie katalógu:                           %u
 ID aktuálneho log súboru:                        %u
 Veľkosť bloku databázy:                         %u
 Stav zoskupenia databáz:                         %s
 Systémový identifikátor databázy:                %s
 Ukladanie typov dátumu a času:                   %s
 LC_COLLATE:                                      %s
 LC_CTYPE:                                        %s
 Umiestnenie posledného kontrolného bodu:         %X/%X
 NextOID posledného kontrolného bodu:             %u
 NextXID posledného kontrolného bodu:             %u
 Umiestnenie REDO posledného kontrolného bodu:    %X / %X
 TimeLineID posledného kontrolného bodu:          %u
 Umiestnenie UNDO posledného kontrolného bodu:    %X / %X
 Maximálna dĺžka identifikátorov:                 %u
 Maximálna dĺžka názvu lokálnych nastavení:     %u
 Maximálny počet argumentov funkcií:              %u
 Nasledujúci segment log súboru:                  %u
 Umiestnenie predchádzajúceho kontrolného bodu:   %X/%X
 Chyby hláste na adresu <pgsql-bugs@postgresql.org>.
 Čas posledného kontrolného bodu:                 %s
 Použite "%s --help" pre zobrazenie detailnejších informácií.
 Použitie:
  %s [VOĽBA]

Voľby:
  DÁTOVÝ_ADRESÁR  zobrazí riadiace informácie o adresári DÁTOVÝ_ADRESÁR
  --help          zobrazí túto nápovedu, potom ukončí program
  --verzia        zobrazí informáciu o verzii programu, potom koniec
 UPOZORNENIE: vypočítaný kontrolný súčet CRC sa nezhoduje s hodnotou uloženou
v súbore. Buď je súbor poškodený alebo má iný formát ako ten, ktorý tento 
program očakáva. Výsledky uvedené nižšie nie sú hodnoverné.

 čísla s pohyblivou rádovou čiarkou prebieha produkcia prebieha zotavenie Posledná zmena v programe pg_control:            %s
 číslo verzie programu pg_control:                %u
 koniec činnosti prebieha ukončenie činnosti prebieha spúšťanie neznámy kód stavu 