??    :      ?  O   ?      ?  9   ?  -   3  ,   a  8   ?  *   ?  N   ?  N   A     ?  *   ?  +   ?       )   #  !   M  &   o     ?  $   ?     ?  )   ?       (   7     `  J   u     ?     ?  #   ?  #   "	  #   F	  Y   j	      ?	  @   ?	  D   &
  &   k
     ?
  )   ?
  )   ?
  )   ?
  )      )   J     t     ?  Q   ?  )   ?  )     )   F  )   p  )   ?  )   ?  )   ?  )     )   B  	   l  ?   v       &   ,  !   S     u  )   ?  ?  ?  T   ?  5   I  1     /   ?  *   ?  Q     Q   ^  @   ?  <   ?  .   .     ]  3   w  %   ?  "   ?      ?  ,        B  /   \     ?  )   ?     ?  W   ?  %   ?  #   e  +   ?  &   ?  &   ?  S        W  P   w  S   ?  *        G  5   V  #   ?  5   ?  *   ?  ,        >     K  f   i  )   ?  )   ?  6   $  6   [  6   ?  '   ?  -   ?  (     0   H     y  ?   ?       7   5  *   m     ?  !   ?     -              .       "             :   !   (   $              4   /   7          	                              2          8         '          0                    6   %   +       5   9   &          ,          #   3                 1         
                    )             *    
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
 %s: could not delete file %s: %s
 %s: could not open %s for reading: %s
 %s: could not open %s: %s
 %s: could not open directory %s: %s
 %s: could not read %s: %s
 %s: could not read from directory %s: %s
 %s: could not write %s: %s
 %s: could not write pg_control file: %s
 %s: fsync error: %s
 %s: internal error -- sizeof(ControlFileData) is too large ... fix xlog.c
 %s: invalid LC_COLLATE setting
 %s: invalid LC_CTYPE setting
 %s: invalid argument for -l option
 %s: invalid argument for -o option
 %s: invalid argument for -x option
 %s: lock file %s exists
Is a server running? If not, delete the lock file and try again.
 %s: no data directory specified
 %s: pg_control exists but has invalid CRC; proceed with caution
 %s: pg_control exists but is broken or unknown version; ignoring it
 %s: transaction ID (-x) must not be 0
 64-bit integers Blocks per segment of large relation: %u
 Catalog version number:               %u
 Current log file ID:                  %u
 Database block size:                  %u
 Date/time type storage:               %s
 Floating point Guessed pg_control values:

 If you are sure the data directory path is correct, do
  touch %s
and try again.
 LC_COLLATE:                           %s
 LC_CTYPE:                             %s
 Latest checkpoint's NextOID:          %u
 Latest checkpoint's NextXID:          %u
 Latest checkpoint's StartUpID:        %u
 Maximum length of identifiers:        %u
 Maximum length of locale name:        %u
 Maximum number of function arguments: %u
 Next log file segment:                %u
 Options:
 The database server was not shut down cleanly.
Resetting the transaction log may cause data to be lost.
If you want to proceed anyway, use -f to force reset.
 Transaction log reset
 Try '%s --help' for more information.
 Usage:
  %s [OPTION]... DATADIR

 pg_control values:

 pg_control version number:            %u
 Project-Id-Version: PostgreSQL 7.3
POT-Creation-Date: 2002-12-01 04:20-0500
PO-Revision-Date: 2002-12-04 23:15+0100
Last-Translator: Krisztian Szekely <szekelyk@different.hu>
Language-Team: Hungarian <szekelyk@different.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
 
Ha ezek az ?rt?kek elfogadhat?nak t?nnek, haszn?ld az -f param?tert a null?z?shoz.
 
Hibajelz?seket a <pgsql-bugs@postgresql.org> c?mre.
   --help          e seg?ts?g ki?r?sa, majd kil?p
   --version       verzi? kijelz?se, majd kil?p
   -f              friss?t?s k?nyszer?t?se
   -l F?JLAZONOS?T?,SZEGMENS   minim?lis WAL kezd?poz?ci? ?j tranzakci?s napl?hoz
   -n              nem friss?t, csak megmutatja a vez?rl??rt?keket (tesztel?shez)
   -o OID          k?vetkez? objektum azonos?t? (OID) be?ll?t?sa
   -x XID          k?vetkez? tranzakci? azonos?t? be?ll?t?sa
 %s null?zza a PostgreSQL tranzakci?s napl?t.

 %s: OID (-o) nem lehet 0
 %s: nem siker?lt l?trehozni a pg_control f?jlt: %s
 %s: a f?jl t?rl?se sikertelen %s: %s
 %s: %s nem nyithat? olvas?sra: %s
 %s: megnyit?s sikertelen %s: %s
 %s: a k?nyvt?r megnyit?sa sikertelen %s: %s
 %s: nem olvashat? %s: %s
 %s: az olvas?s sikertelen a k?nyvt?rb?l %s: %s
 %s: ?r?sa sikertelen %s: %s
 %s: pg_control f?jl ?r?sa sikertelen: %s
 %s: fsync hiba: %s
 %s: bels? hiba -- sizeof(ControlFileData) ?rt?ke t?l nagy ... jav?tsd a xlog.c f?jlban
 %s: ?rv?nytelen LC_COLLATE be?ll?t?s
 %s: ?rv?nytelen LC_CTYPE be?ll?t?s
 %s: a param?ter az -l opci?hoz ?rv?nytelen
 %s: -o opci?hoz ?rv?nytelen param?ter
 %s: -x opci?hoz ?rv?nytelen param?ter
 %s: %s z?rol?f?jl l?tezik
Fut egy szerver? Ha nem, t?r?ld a f?jlt ?s pr?b?ld ?jra!
 %s: adatk?nyvt?r nincs megadva
 %s: pg_control l?tezik, de ?rv?nytelen a CRC ?rt?kkel; folytat?s csak ?vatosan!
 %s: pg_control l?tezik, de s?r?lt vagy ismeretlen verzi?ju; figyelmen k?v?l hagyom
 %s: tranzakci? azonos?t? (-x) nem lehet 0
 64 bites eg?sz Szegmensenk?nti blokkok sz?ma a nagy rel?ci?kban: %u
 Katal?gus verzi?:               %u
 Aktu?lis napl?f?jl azonos?t? (ID):                %u
 Adatb?zis blokkm?ret:                  %u
 D?tum/id? t?rol?si t?pusa:               %s
 Lebeg?pontos Saccolt pg_control ?rt?kek:

 Ha biztos vagy benne, hogy az el?r?si ?t helyes, akkor add ki a
  touch %s
parancsot ?s pr?b?ld ?jra.
 LC_COLLATE:                           %s
 LC_CTYPE:                             %s
 A legut?bbi ellen?rz?pont NextOID ?rt?ke:          %u
 A legut?bbi ellen?rz?pont NextXID ?rt?ke:          %u
 A legut?bbi ellen?rz?pont StartUpID ?rt?ke:        %u
 Azonos?t?k maxim?lis hossza:        %u
 Lokaliz?ci?s n?v maxim?lis hossza:        %u
 F?ggv?nyparam?terek maxim?lis sz?ma: %u
 K?vetkez? napl?f?jl szegmens:                %u
 Opci?k:
 Az adatb?zis szerver nem szab?lyosan ?llt le.
A tranzakci?s napl? null?z?sa adatveszt?st okozhat.
Ha m?gis szeretn?d, a -f param?terrel null?zhatsz.
 Tranzakci?s napl? null?z?sa
 Tov?bbi inform?ci?hoz pr?b?ld a '%s --help' parancsot.
 Haszn?lat:
  %s [OPCI?K]... ADATK?NYVT?R

 pg_control ?rt?kek:

 pg_control verzi?:            %u
 