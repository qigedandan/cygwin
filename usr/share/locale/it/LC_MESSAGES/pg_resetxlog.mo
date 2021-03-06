??    ;      ?  O   ?        9   	  -   C  ,   q  8   ?  *   ?  N     N   Q     ?  *   ?  +   ?       )   3  #   ]  &   ?  -   ?  !   ?  !   ?  +     "   F  (   i     ?  J   ?     ?     	  #   0	  #   T	  #   x	  \   ?	      ?	  @   
  D   [
  &   ?
     ?
  )   ?
  )     )   +  )   U  )     )   ?     ?  V   ?  )   G  )   q  )   ?  )   ?  )   ?  )     )   C  )   m  )   ?  	   ?  ?   ?     j  &   ?  !   ?     ?     ?  )   ?       O   8  0   ?  1   ?  ?   ?  7   +  P   c  c   ?  *     8   C  9   |  !   ?  .   ?  +     ,   3  7   `  (   ?  )   ?  0   ?  +     0   H     y  T   ?  $   ?  "   	  &   ,  &   S  &   z  k   ?  6     C   D  Z   ?  2   ?       6   &  +   ]  2   ?  0   ?  5   ?  I   #     m  W   ?  )   ?  )     '   9  '   a  .   ?  2   ?  5   ?  1   !  :   S  	   ?  ?   ?  %   R  -   x  %   ?     ?     ?  *   ?     -      2   9          "                  !   '   $               4   3       +      	   #      7                                       (   .             *      0          %          ;      &      /   ,         1          :      5              
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
 Project-Id-Version: PostgreSQL 7.4
POT-Creation-Date: 2004-09-10 13:08+0100
PO-Revision-Date: 2004-09-10 19:34+0100
Last-Translator: 
Language-Team: Tebaldi Mirko <mirko.tebaldi@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
 
Se questi parametri sembrano accettabili, utilizzate -f per forzare un reset.
 
Segnalare bachi a <pgsql-bugs@postgresql.org>.
   --help           mostra questo aiuto, poi esci
   --version       mostra informazioni sulla versione, poi esci
   -f              forza lesecuzione dell'aggiornamento
   -l FILEID,SEG   forza un nuovo inizio di WAL minimo per una nuova transazione
   -n              nessun aggiornamento, mostra solo i valori di controllo estrati (solo per prove)
   -o OID          imposta il prossimo OID
   -x XID          imposta il prossimo ID di transazione
 %s riavvia il registro delle transazioni di PostgreSQL.

 %s: l'OID (-o) non deve essere 0
 %s: impossibile creare il file pg_control: %s
 %s: impossibile eliminare il file "%s": %s
 %s: impossibile aprire la cartella "%s": %s
 %s: impossibile aprire il file "%s" per la lettura: %s
 %s: impossibile aprire il file "%s": %s
 %s: impossibile leggere il file "%s": %s
 %s: impossibile leggere dalla cartella "%s": %s
 %s: impossibile scrivere sul file "%s": %s
 %s: impossibile scrivere il file pg_control: %s
 %s: errore fsync: %s
 %s: errore interno -- sizeof(ControlFileData) è troppo grande ... sistemare xlog.c
 %s: settaggio errato per LC_COLLATE
 %s: settaggio errato per LC_CTYPE
 %s: parametro errato per l'opzione -l
 %s: parametro errato per l'opzione -o
 %s: parametro errato per l'opzione -x
 %s: il lock file "%s" esiste
Il server è in esecuzione? Se non lo è, eliminate il lock file e riprovate.
 %s: non è stata specificata una directory per i dati
 %s: pg_control esiste ma ha un CRC invalido; procedere con cautela
 %s: pg_control esiste ma è inutilizzabile o è una versione sconosciuta; verrà ignorato
 %s: l'ID della transazione (-x) non deve essere 0
 Interi a 64 bit Blocchi per ogni segmento di una grossa relazione: %u
 Numero versione catalogo:               %u
 ID file di registro corrente:                  %u
 Dimensione blocco database:                  %u
 Identificatore sistema database:                  %s
 Tipo di immagazzinaggio per dati temporali (date/time):               %s
 Valori pg_control indovinati:

 Se sei sicuro che il percorso della cartella è corretto, esegui
  touch %s
e riprova.
 LC_COLLATE:                           %s
 LC_CTYPE:                             %s
 Ultimo checkpoint NextOID:          %u
 Ultimo checkpoint NextXID:          %u
 Ultimo TimeLineId del checkpoint:          %u
 Lunghezza massima degli identificatori:        %u
 Dimensione massima del nome di una locale:        %u
 Numero massimo di parametri per una funzione: %u
 Prossimo segmento del file di registro:                %u
 Opzioni:
 Il server database non è stato chiuso correttamente.
Resettare il registro delle trasazioni può causare una perdita di dati.
Se volete continuare, utilizzate -f per forzare il reset.
 registro delle transazioni riavviato
 Prova "%s --help" per maggiori informazioni.
 Utilizzo:
  %s [OPZIONI]... DATADIR

 Numeri in virgola mobile Valori pg_control:

 Numero versione pg_control:            %u
 