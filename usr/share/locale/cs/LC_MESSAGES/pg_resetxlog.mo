??    ;      ?  O   ?        9   	  -   C  ,   q  8   ?  *   ?  N     N   Q     ?  *   ?  +   ?       )   3  #   ]  &   ?  -   ?  !   ?  !   ?  +     "   F  (   i     ?  J   ?     ?     	  #   0	  #   T	  #   x	  \   ?	      ?	  @   
  D   [
  &   ?
     ?
  )   ?
  )     )   +  )   U  )     )   ?     ?  V   ?  )   G  )   q  )   ?  )   ?  )   ?  )     )   C  )   m  )   ?  	   ?  ?   ?     j  &   ?  !   ?     ?     ?  )   ?  S     P   t  5   ?  /   ?  3   +  *   _  Q   ?  Q   ?  *   .  3   Y  (   ?     ?  )   ?  !   ?  #     ,   @  "   m     ?  #   ?  %   ?  '   ?     "  P   7  "   ?      ?  &   ?  &   ?  &     o   A  %   ?  T   ?  I   ,  "   v     ?  "   ?  '   ?  -   ?  1   '  )   Y  0   ?      ?  a   ?  ?   7  6   w  )   ?  )   ?  +     *   .  (   Y  %   ?  3   ?     ?  ?   ?     ?  '   ?  %   ?     ?       '   .     -      2   9          "                  !   '   $               4   3       +      	   #      7                                       (   .             *      0          %          ;      &      /   ,         1          :      5              
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
 Project-Id-Version: pg_resetxlog-cs
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2004-10-27 14:17+0200
PO-Revision-Date: 2004-10-21 14:07+0200
Last-Translator: Karel Zak <zakkr@zf.jcu.cz>
Language-Team: Czech <cs@li.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.3.1
 
Jestli?e tyto hodnoty vypadaj? akceptovateln?, pou?ijte -f pro vynucen? reset.
 
Chyby hlaste na adresu <pgsql-bugs@postgresql.org>.
   --help          uk??e tuto n?pov?du a skon??
   --version       uk??e informace o verzi a skon??
   -f              provede vynucen? update
   -l FILEID,SEG   vynut? minim?ln? po??te?n? WAL pozici pro novou transak?n? log
   -n              bez zm?ny, jen uk??e z?skan? kontroln? hodnoty (pro testov?n?)
   -o OID          nastav? n?sleduj?c? OID
   -x XID          nastav? n?sleduj?c? ID transakce
 %s resetuje PostgreSQL transak?n? log.

 %s: OID (-o) nesm? b?t 0
 %s: nelze vytvo?it pg_control soubor: %s
 %s: nelze smazat soubor "%s": %s
 %s: nelze otev??t adres?? "%s": %s
 %s: nelze otev??t soubor "%s" pro ?ten?: %s
 %s: nelze otev??t soubor "%s": %s
 %s: nelze ??st soubor "%s": %s
 %s: nelze ??st z adres??e "%s": %s
 %s: nelze zapsat do souboru "%s": %s
 %s: nelze zapsat pg_control soubor: %s
 %s: fsync chyba: %s
 %s: intern? chyba -- sizeof(ControlFileData) je p??li? velk? ... opravte xlog.c
 %s: neplatn? nastaven? LC_COLLATE
 %s: neplatn? nastaven? LC_CTYPE
 %s: neplatn? argument pro p?ep?na? -l
 %s: neplatn? argument pro p?ep?na? -o
 %s: neplatn? argument pro p?ep?na? -x
 %s: soubor se z?mkem "%s" existuje
Neb??? ji? server?  Jestli?e ne, sma?te soubor se z?mkem a zkuste to znova.
 %s: nen? specifikov?n datov? adres??
 %s: pg_control existuje, ale s neplatn?m kontroln?m sou?tem CRC; postupujte opatrn?
 %s: pg_control existuje, ale je po?kozen nebo nezn?m? verze; ignoruji to
 %s: ID transakce (-x) nesm? b?t 0
 64-bitov? cel? ??sla Blok? v segmentu velk? relace: %u
 ??slo verze katalogu:               %u
 Sou?asn? ID log souboru:                  %u
 Velikost datab?zov?ho bloku:                  %u
 Identifik?tor datab?zov?ho syst?mu:   %s
 Zp?sob ulo?en? typu date/time:               %s
 Odhadnut? hodnoty pg_controlu:

 M?te-li jistotu, ?e je cesta k datov?mu adres??i spr?vn?, prove?te
  touch %s
a zkuste to znovu.
 LC_COLLATE (porovn?v?n? ?et?zc?):                           %s
 LC_CTYPE (typy znak?):                             %s
 NextOID posledn?ho kontroln?ho bodu:  %u
 NextXID posledn?ho kontroln?ho bodu:  %u
 TimeLineID posledn?ho kontroln?ho bodu: %u
 Maxim?ln? d?lka identifik?tor?:        %u
 Maxim?ln? d?lka jm?na locale:        %u
 Maxim?ln? po?et argument? funkc?: %u
 N?sleduj?c? segment log souboru:                %u
 P?ep?na?e:
 Datab?zov? server nebyl ukon?en standardn?.
Resetov?n? transak?n?ho logu m??e b?t d?vodem ke ztr?t? dat.
Jestli?e i p?esto chcete pokra?ovat, pou?ijte -f pro vynucen? reset.
 Transak?n? log resetov?n
 Zkuste "%s --help" pro v?ce informac?.
 Pou?it?:
  %s [P?EP?NA?]... ADRES??

 ??sla s plovouc? ??rkou Hodnoty pg_controlu:

 ??slo verze pg_controlu:            %u
 