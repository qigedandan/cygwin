??    *      l  ;   ?      ?  N   ?  C   ?  -   <  !   j      ?     ?  )   ?  )   ?  )     )   ;  )   e  )   ?  )   ?  )   ?  )     )   7  ,   a  )   ?  )   ?  ,   ?  )     ,   9  )   f  )   ?  )   ?  )   ?  ,     ,   ;  )   h  &   ?  ?   ?  ?   y	     @
     W
     e
  )   q
  )   ?
  	   ?
     ?
     ?
     ?
      p     K   ?  3   ?  *     5   ;     q  )   ?  )   ?  )   ?  )   ?  )   )  )   S  2   }  )   ?  )   ?  )     ,   .  )   [  (   ?  ,   ?  ,   ?  ,     )   5  )   _  )   ?  )   ?  ,   ?  .   
  )   9  -   c  ?   ?  ?   X     (     A     O  $   [  )   ?     ?     ?     ?      ?                                                          !                         )   	          
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
 shut down shutting down starting up unrecognized status code Project-Id-Version: PostgreSQL 8.0
POT-Creation-Date: 2004-09-10 13:08+0100
PO-Revision-Date: 2004-09-10 19:53+0100
Last-Translator: 
Language-Team: Tebaldi Mirko <mirko.tebaldi@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
 
Se non viene specificata un directory per i dati, la variabile d'ambiente PGDATA
sar? usata come predefinita.

 %s mostra informazioni di controllo su un cluster database di PostgreSQL.

 %s: impossibile aprire il file "%s" in lettura: %s
 %s: impossibile leggere dal file "%s": %s
 %s: non ? stata specificata una directory per i dati
 Interi a 64-bit Blocchi per segmento grandi relaz.:   %u
 Byte per segmento WAL:                %u
 Numero versione catalogo:             %u
 Id corrente file di log:              %u
 Dimensione blocco database:           %u
 Stato cluster database:               %s
 Identificatore sistema database:               %s
 Memorizzazione tipi Data/Ora:         %s
 LC_COLLATE:                           %s
 LC_CTYPE:                             %s
 Ultima posizione checkpoint:          %X/%X
 Ultimo NextOID checkpoint:            %u
 Ultimo NextXID checkpoint :          %u
 Ultima posizione REDO checkpoint:     %X/%X
 Ultimo TimeLineID del checkpoint :       %u
 Ultima posizione UNDO checkpoint:     %X/%X
 Massima lunghezza identificatori:     %u
 Maxssima lunghezza per nomi locali:   %u
 N? massimo di argomenti per funzione: %u
 Successivo segmento log file:         %u
 Precedente posizione checkpoint:      %X/%X
 Segnala errori a <pgsql-bugs@postgresql.org>.
 Orario ultimo checkpoint:             %s
 Prova "%s --help" per maggiori informazioni.
 Uso:
  %s [OPZIONI]

Opzioni:
  DATADIR		mostra informazioni di controllo cluster per DATADIR
  --help		mostra questa guida, quindi esce
  --versione	mostra informazioni sulla versione, quindi esce
 ATTENZIONE: La somma di controllo CRC non corrisponde al valore memorizzato nel file.
O il file ? corrotto, o ha un formato differente da quello previsto.
I risultati che ne conseguono sono senza garanzie.

 numeri in virgola mobile in produzione in recupero ultima modifica pg_control:		    %s
 pg_control numero di versione:        %u
 arresto arresto in corso avvio in corso codice di stato non riconosciuto 