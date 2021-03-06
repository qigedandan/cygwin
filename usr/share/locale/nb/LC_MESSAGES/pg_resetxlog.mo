??    :      ?  O   ?      ?  9   ?  -   3  ,   a  8   ?  *   ?  N   ?  N   A     ?  *   ?  +   ?       )   #  #   M  &   q  -   ?  !   ?  !   ?  +   
  "   6  (   Y     ?  J   ?     ?     	  #    	  #   D	  #   h	  \   ?	      ?	  @   

  D   K
  &   ?
     ?
  )   ?
  )   ?
  )     )   E  )   o     ?  V   ?  )     )   7  )   a  )   ?  )   ?  )   ?  )   	  )   3  )   ]  	   ?  ?   ?     0  &   G  !   n     ?     ?  )   ?  c  ?  H   J  1   ?  8   ?  9   ?  '   8  H   `  M   ?  "   ?  .     .   I     x  +   ?  %   ?  '   ?  .     #   >  #   b  +   ?  %   ?  )   ?       K     '   b  %   ?  #   ?  #   ?  #   ?  c     !   ?  J   ?  O   ?  '   =     e  *   u  *   ?  *   ?  *   ?  *   !     L  R   k  )   ?  )   ?  *     *   =  *   h  *   ?  )   ?  *   ?  *        >  ?   E       &      '   G     o     x  *   ?     ,      1   8      2   "                  !   6   $               3   .       *      	   #                                              '   -             )      /          %          :      &          +         0          9      4              
              7       (             5    
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
 Date/time type storage:               %s
 Guessed pg_control values:

 If you are sure the data directory path is correct, execute
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
 Try "%s --help" for more information.
 Usage:
  %s [OPTION]... DATADIR

 floating-point numbers pg_control values:

 pg_control version number:            %u
 Project-Id-Version: PostgreSQL 7.4
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2003-09-29 15:49+0200
PO-Revision-Date: 2003-09-29 15:55+0200
Last-Translator: Trond Endrest?l <trond@ramstind.gtf.ol.no>
Language-Team: Norwegian bokm?l <i18n-nb@lister.ping.uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
 
Dersom disse verdiene er akseptable, bruk -f for tvungen nullstilling.
 
Rapporter bugs til <pgsql-bugs@postgresql.org>.
   --help          vise denne hjelpen, deretter avslutte
   --version       vise programversjon, deretter avslutte
   -f              tvungen nullstilling
   -l FILID,SEG    angi minste WAL-startposisjon for ny transaksjonslogg
   -n              ingen oppdatering, bare vise kontrollverdier (for testing)
   -o OID          sette neste OID
   -x XID          sette neste transaksjons-ID
 %s nullstiller PostgreSQLs transaksjonslogg.

 %s: OID (-o) m? ikke v?re 0
 %s: kunne ikke opprette pg_control-fil: %s
 %s: kunne ikke slette filen ?%s?: %s
 %s: kunne ikke ?pne katalogen ?%s?: %s
 %s: kunne ikke ?pne filen ?%s? for lesing: %s
 %s: kunne ikke ?pne filen ?%s?: %s
 %s: kunne ikke lese filen ?%s?: %s
 %s: kunne ikke lese fra katalogen ?%s?: %s
 %s: kunne ikke skrive filen ?%s?: %s
 %s: kunne ikke skrive pg_control-fil: %s
 %s: fsync-feil: %s
 %s: intern feil -- sizeof(ControlFileData) er for stor ... korriger xlog.c
 %s: ugyldig innstilling for LC_COLLATE
 %s: ugyldig innstilling for LC_CTYPE
 %s: ugyldig argument til valget -l
 %s: ugyldig argument til valget -o
 %s: ugyldig argument til valget -x
 %s: l?sefilen ?%s? eksisterer
Kj?rer en server allerede? Hvis ikke, slett l?sefilen og pr?v igjen.
 %s: ingen datakatalog er oppgitt
 %s: pg_control eksisterer, men har ugyldig CRC; fortsett med forsiktighet
 %s: pg_control eksisterer, men er b0rken eller har ukjent versjon; ignorer den
 %s: transaksjon-ID (-x) m? ikke v?re 0
 64-bits heltall Blokker pr segment i en stor relasjon: %u
 Katalogversjonsnummer:                 %u
 N?v?rende loggfil-ID:                  %u
 Databasens blokkst?rrelse:             %u
 Lagringstype for dato/tid:             %s
 Gjettede pg_control-verdier:

 Om du er sikker p? at datakatalogstien er riktig, utf?r
  touch %s
og pr?v igjen.
 LC_COLLATE:                           %s
 LC_CTYPE:                             %s
 Nyeste kontrollpunkts NextOID:         %u
 Nyeste kontrollpunkts NextXID:         %u
 Nyeste kontrollpunkts StartUpID:       %u
 Maksimal lengde p? identifikatorer:    %u
 Maksimal lengdre p? localenavn:       %u
 Maksimalt antall funksjonsargumenter:  %u
 Neste loggfilsegment:                  %u
 Valg:
 Databaseserveren ble ikke avsluttet pent og pyntelig.
Nullstilling av transaksjonsloggen kan f?re til at data g?r tapt.
Dersom du likevel vil fortsette, bruk -f for tvungen nullstilling.
 Nullstilte transaksjonsloggen
 Pr?v ?%s --help? for mer informasjon.
 Bruksm?te:
  %s [VALG]... DATAKATALOG

 flyttall pg_control-verdier:

 pg_control versjonsnummer:             %u
 