??    =        S   ?      8  9   9  -   s  ,   ?  8   ?  *     N   2  N   ?     ?  *   ?  +        G  !   c  )   ?  #   ?  &   ?  -   ?  !   (  !   J  +   l  "   ?  (   ?     ?  J   ?     D	     d	  #   ?	  #   ?	  #   ?	  \   ?	      K
  @   l
  D   ?
  &   ?
       )   )  )   S  )   }  )   ?  )   ?  )   ?     %  V   B  )   ?  )   ?  )   ?  )     )   A  )   k  )   ?  )   ?  )   ?  	     ?        ?  &   ?  !   ?  -        J     a  )   v  A  ?  M   ?  4   0  2   e  :   ?  (   ?  G   ?  L   D  !   ?  -   ?  -   ?       !   -  (   O  %   x  &   ?  .   ?  "   ?  !     *   9  #   d  )   ?     ?  G   ?  (     %   6  &   \  &   ?  &   ?  W   ?     )  H   H  N   ?  )   ?     
  )     )   C  )   m  )   ?  )   ?  )   ?       X   2  )   ?  )   ?  )   ?  )   	  )   3  )   ]  )   ?  )   ?  )   ?  	     ?     $   ?  ,   ?  *     1   <     n     }  )   ?     !   0              1   3   4          *         -                        8   7       6          2   
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
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2005-01-06 12:42+0100
PO-Revision-Date: 2005-01-06 12:43+0100
Last-Translator: Dennis Bj?rklund <db@zigo.dhs.org>
Language-Team: Swedish <sv@li.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
 
Om dessa v?rden verkar acceptable, anv?nd -f f?r
att forcera ?terst?llande.
 
Reportera buggar till <pgsql-bugs@postgresql.org>.
   --help          visa denna hj?lp, avsluta sedan
   --version       visa versionsinformation, avsluta sedan
   -f              forcera ?terst?llande
   -l TLI,FILID,SEG    ange minsta WAL-startposition f?r ny transaktion
   -n              ingen updatering, visa bara kontrollv?rden (f?r testning)
   -o OID          s?tt n?sta OID
   -x XID          s?tt n?sta transaktions-ID
 %s ?terst?ller PostgreSQL transaktionslogg.

 %s: OID (-o) f?r inte vara 0
 %s: kan inte exekveras av "root"
 %s: kunde inte skapa pg_control-fil: %s
 %s: kunde inte radera filen "%s": %s
 %s: kunde inte ?ppna katalog "%s": %s
 %s: kunde inte ?ppna fil "%s" f?r l?sning: %s
 %s: kunde inte ?ppna fil "%s": %s
 %s: kunde inte l?sa fil "%s": %s
 %s: kunde inte l?sa fr?n katalog "%s": %s
 %s: kunde inte skriva fil "%s": %s
 %s: kunde inte skriva pg_control-fil: %s
 %s: fsync fel: %s
 %s: internt fel -- sizeof(ControlFileData) ?r f?r stor ... laga xlog.c
 %s: ogiltigt inst?llning f?r LC_COLLATE
 %s: ogiltig inst?llning f?r LC_CTYPE
 %s: ogiltigt argument till flaggan -l
 %s: ogiltigt argument till flaggan -o
 %s: ogiltigt argument till flaggan -x
 %s: l?sfil "%s" existerar
K?r servern redan? Om inte, radera l?sfilen och f?rs?k igen.
 %s: ingen datakatalog angiven
 %s: pg_control existerar men har ogiltig CRC; forts?tt med f?rsiktighet
 %s: pg_control existerar men ?r trasig eller har ok?nd version; ignorerar den
 %s: transaktions-ID (-x) f?r inte vara 0
 64-bits heltal Block per segment i stor relation:    %u
 Katalogversionsnummer:                %u
 Aktuell loggfil-ID:                   %u
 Databasens blockstorlek:              %u
 Databasens systemidentifierare:       %s
 Lagringstyp f?r datum/tid:            %s
 Gissade pg_control-v?rden:

 Om du ?r s?ker p? att datakatalogs?kv?gen ?r korrekt s? g?r
  touch %s
och f?rs?k igen.
 LC_COLLATE:                           %s
 LC_CTYPE:                             %s
 Senaste kontrollpunktens NextOID:     %u
 Senaste kontrollpunktens NextXID:     %u
 Senaste kontrollpunktens TimeLineID:  %u
 Maximal l?ngd p? identifierare:       %u
 Maximal l?ngd p? lokalnamn:           %u
 Maximalt antal funktionsargument:     %u
 N?sta loggfilsegment:                 %u
 Flaggor:
 Databasservern st?ngdes inte ner korrekt. Att ?terst?lla
transaktionsloggen kan medf?ra att data f?rloras.
Om du vill forts?tta ?nd?, anv?nd -f f?r att forcera
?terst?llande.
 ?terst?llande fr?n transaktionslogg
 F?rs?k med "%s --help" f?r mer information.
 Anv?ndning:
  %s [FLAGGA]... DATAKATALOG

 Du m?ste k?ra %s som PostgreSQLs superanv?ndare.
 flyttalsnummer pg_control-v?rden:

 pg_control versionsnummer:            %u
 