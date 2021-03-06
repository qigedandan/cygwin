??    =        S   ?      8  9   9  -   s  ,   ?  8   ?  *     N   2  N   ?     ?  *   ?  +        G  !   c  )   ?  #   ?  &   ?  -   ?  !   (  !   J  +   l  "   ?  (   ?     ?  J   ?     D	     d	  #   ?	  #   ?	  #   ?	  \   ?	      K
  @   l
  D   ?
  &   ?
       )   )  )   S  )   }  )   ?  )   ?  )   ?     %  V   B  )   ?  )   ?  )   ?  )     )   A  )   k  )   ?  )   ?  )   ?  	     ?        ?  &   ?  !   ?  -        J     a  )   v  `  ?  ^     6   `  5   ?  ?   ?  %     Z   3  J   ?  %   ?  1   ?  1   1     c  ,   ?  0   ?  (   ?  -   
  1   8  '   j  &   ?  4   ?  -   ?  0        M  P   c  %   ?  #   ?  &   ?  &   %  &   L  t   s  $   ?  J     F   X  +   ?     ?  )   ?  )     )   /  )   Y  )   ?  )   ?     ?  t   ?  )   k  )   ?  )   ?  )   ?  )     )   =  )   g  )   ?  )   ?  
   ?  ?   ?  %   ?  5   ?  .   $  2   S     ?     ?  )   ?     !   0              1   3   4          *         -                        8   7       6          2   
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
POT-Creation-Date: 2004-12-29 03:15+0100
PO-Revision-Date: 2004-12-29 03:19+0100
Last-Translator: Peter Eisentraut <peter_e@gmx.net>
Language-Team: German <peter_e@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.0.1
 
Wenn diese Werte akzeptabel scheinen, dann benutzen Sie -f um das
Zur?cksetzen zu erzwingen.
 
Berichten Sie Fehler an <pgsql-bugs@postgresql.org>.
   --help          diese Hilfe anzeigen, dann beenden
   --version       Versionsinformationen anzeigen, dann beenden
   -f              ?nderung erzwingen
   -l TLI,DATEIID,SEG
                  minimale WAL-Startposition f?r neuen Log erzwingen
   -n              keine ?nderung, nur Kontrolldaten anzeigen (zum Testen)
   -o OID          n?chste OID setzen
   -x XID          n?chste Transaktions-ID setzen
 %s setzt den PostgreSQL-Transaktionslog zur?ck.

 %s: OID (-o) darf nicht 0 sein
 %s: kann nicht von ?root? ausgef?hrt werden
 %s: konnte pg_control Datei nicht erstellen: %s
 %s: konnte Datei ?%s? nicht l?schen: %s
 %s: konnte Verzeichnis ?%s? nicht ?ffnen: %s
 %s: konnte Datei ?%s? nicht zum Lesen ?ffnen: %s
 %s: konnte Datei ?%s? nicht ?ffnen: %s
 %s: konnte Datei ?%s? nicht lesen: %s
 %s: konnte aus dem Verzeichnis ?%s? nicht lesen: %s
 %s: konnte nicht in Datei ?%s? schreiben: %s
 %sL konnte pg_control Datei nicht schreiben: %s
 %s: fsync-Fehler: %s
 %s: interner Fehler -- sizeof(ControlFileData) is zu gro? ... xlog.c reparieren
 %s: ung?ltige LC_COLLATE-Einstellung
 %s: ung?ltige LC_CTYPE-Einstellung
 %s: ung?ltiges Argument f?r Option -l
 %s: ung?ltiges Argument f?r Option -o
 %s: ung?ltiges Argument f?r Option -x
 %s: Sperrdatei ?%s? existiert bereits
L?uft der Server?  Wenn nicht, dann Sperrdatei l?schen und nochmal versuchen.
 %s: kein Datenverzeichnis angegeben
 %s: pg_control existiert aber mit ung?ltiger CRC; mit Vorsicht fortfahren
 %s: pg_control ist kaputt oder hat unbekannte Version; wird ignoriert
 %s: Transaktions-ID (-x) darf nicht 0 sein
 64-Bit-Integers Bl?cke pro Segment:                   %u
 Katalog-Versionsnummer:               %u
 Aktuelle Logdatei-ID:                 %u
 Datenbank-Blockgr??e:                 %u
 Datenbanksystemidentifikation:        %s
 Datum/Zeit-Speicherung:               %s
 Gesch?tzte pg_control-Werte:

 Wenn Sie sicher sind, dass das Datenverzeichnis korrekt ist, f?hren Sie
  touch %s
aus und versuchen Sie es erneut.
 LC_COLLATE:                           %s
 LC_CTYPE:                             %s
 NextOID des letzten Checkpoints:      %u
 NextXID des letzten Checkpoints:      %u
 TimeLineID des letzten Checkpoints:   %u
 Maximale Namensl?nge:                 %u
 Maximall?nge eines Locale-Namen:      %u
 Maximale Funktionsargumente:          %u
 N?chstes Logdatei-Segment:            %u
 Optionen:
 Der Datenbankserver wurde nicht sauber heruntergefahren.
Beim Zur?cksetzen des Transaktionslogs k?nnen Daten verloren gehen.
Wenn Sie trotzdem weiter machen wollen, benutzen Sie -f um das
Zur?cksetzen zu erzwingen.
 Transaktionslog wurde zur?ck gesetzt
 Versuchen Sie ?%s --help? f?r weitere Informationen.
 Benutzung:
  %s [OPTION]... DATENVERZEICHNIS

 Sie m?ssen %s als PostgreSQL-Superuser ausf?hren.
 Flie?kommazahlen pg_control-Werte:

 pg_control-Versionsnummer:            %u
 