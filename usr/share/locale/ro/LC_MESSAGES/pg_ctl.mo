??    a      $  ?   ,      8      9     Z  &   l     ?     ?  -   ?      	     	  r   3	     ?	  F   ?	  A   
     O
  7   j
  !   ?
  3   ?
  ?   ?
  ?   8  H   x  D   ?  E     ?   L  B   ?  <   ?  ?     0   ?  F   ?  8     2   >  O   q  7   ?     ?        ?   	  !   ?  :   ?  I   ?  y   A  =   ?  >   ?  ;   8  *   t  1   ?  $   ?  /   ?  #   &     J  3   h  0   ?  ,   ?  .   ?  7   )  1   a  0   ?  5   ?     ?  $     ,   6  J   c     ?  0   ?     ?  "     %   1  $   W      |  4   ?  %   ?  $   ?  "     F   @  F   ?     ?  )   ?  s     h   ?  &   ?       &     0   C  )   t  "   ?      ?  (   ?       !   &     H     d     x     ?     ?     ?     ?     ?  &      "   '  S  J     ?     ?  1   ?  '     &   +  3   R     ?     ?  w   ?     9  F   Y  C   ?     ?  7   ?  "   7  :   Z  H   ?  D   ?  Q   #  M   u  V   ?  A      N   \   ?   ?   ?   ?   9   ?!  L   ?!  >   "  F   K"  l   ?"  G   ?"  
   G#     R#  ?   Z#      $  =   ($  X   f$  ?   ?$  D   L%  B   ?%  ?   ?%  3   &  >   H&  .   ?&  :   ?&  5   ?&  %   ''  >   M'  ?   ?'  3   ?'  :    (  A   ;(  >   }(  9   ?(  A   ?(     8)  *   R)  .   })  b   ?)  "   *  ;   2*     n*     ?*  "   ?*  )   ?*  )   ?*  @   +  %   ^+  '   ?+  %   ?+  N   ?+  F   !,     h,  )   },  w   ?,  g   -  3   ?-     ?-      ?-  /   ?-  +   .  (   D.  (   m.  .   ?.     ?.  *   ?.     /     ./     B/  &   X/     /     ?/     ?/     ?/  $   ?/  )   ?/        B       *   `   ;   J       [            2          I   :   Q   X   ^   &   (       T       C   P         S      W       #      '              V      1          N       .   
         _       5                 Z   R   U   Y                  ?   6   <       9   0       !                      @              %   8   3   K   M   =      /   -   G   ,   F   O       "   )   \      >       $   E   7       L   A      ]          4   H          	                     +          D              a    
Allowed signal names for kill:
 
Common options:
 
Options for register and unregister:
 
Options for start or restart:
 
Options for stop or restart:
 
Report bugs to <pgsql-bugs@postgresql.org>.
 
Shutdown modes are:
   %s kill    SIGNALNAME PID
   %s register   [-N SERVICENAME] [-U USERNAME] [-P PASSWORD] [-D DATADIR]
                    [-w] [-o "OPTIONS"]
   %s reload  [-D DATADIR] [-s]
   %s restart [-w] [-D DATADIR] [-s] [-m SHUTDOWN-MODE] [-o "OPTIONS"]
   %s start   [-w] [-D DATADIR] [-s] [-l FILENAME] [-o "OPTIONS"]
   %s status  [-D DATADIR]
   %s stop    [-W] [-D DATADIR] [-s] [-m SHUTDOWN-MODE]
   %s unregister [-N SERVICENAME]
   --help                 show this help, then exit
   --version              output version information, then exit
   -D, --pgdata DATADIR   location of the database storage area
   -N SERVICENAME  service name with which to register PostgreSQL server
   -P PASSWORD     password of account to register PostgreSQL server
   -U USERNAME     user name of account to register PostgreSQL server
   -W                     do not wait until operation completes
   -l, --log FILENAME     write (or append) server log to FILENAME
   -m SHUTDOWN-MODE   may be "smart", "fast", or "immediate"
   -o OPTIONS             command line options to pass to the postmaster
                         (PostgreSQL server executable)
   -p PATH-TO-POSTMASTER  normally not necessary
   -s, --silent           only print errors, no informational messages
   -w                     wait until operation completes
   fast        quit directly, with proper shutdown
   immediate   quit without complete shutdown; will lead to recovery on restart
   smart       quit after all clients have disconnected
  done
  failed
 %s is a utility to start, stop, restart, reload configuration files,
report the status of a PostgreSQL server, or signal a PostgreSQL process.

 %s: PID file "%s" does not exist
 %s: a standalone backend "postgres" is running (PID: %ld)
 %s: another postmaster may be running; trying to start postmaster anyway
 %s: cannot be run as root
Please log in (using, e.g., "su") as the (unprivileged) user that will
own the server process.
 %s: cannot reload postmaster; postgres is running (PID: %ld)
 %s: cannot restart postmaster; postgres is running (PID: %ld)
 %s: cannot stop postmaster; postgres is running (PID: %ld)
 %s: could not find own program executable
 %s: could not find postmaster program executable
 %s: could not open PID file "%s": %s %s: could not open service "%s": error code %d
 %s: could not open service manager
 %s: could not read file "%s"
 %s: could not register service "%s": error code %d
 %s: could not send reload signal (PID: %ld): %s
 %s: could not send signal %d (PID: %ld): %s
 %s: could not send stop signal (PID: %ld): %s
 %s: could not start postmaster
Examine the log output.
 %s: could not start postmaster: exit code was %d
 %s: could not start service "%s": error code %d
 %s: could not unregister service "%s": error code %d
 %s: invalid option %s
 %s: missing arguments for kill mode
 %s: neither postmaster nor postgres running
 %s: no database directory specified and environment variable PGDATA unset
 %s: no operation specified
 %s: option file "%s" must have exactly one line
 %s: out of memory
 %s: postmaster does not shut down
 %s: postmaster is running (PID: %ld)
 %s: service "%s" already registered
 %s: service "%s" not registered
 %s: too many command-line arguments (first is "%s")
 %s: unrecognized operation mode "%s"
 %s: unrecognized shutdown mode "%s"
 %s: unrecognized signal name "%s"
 (The default is to wait for shutdown, but not for start or restart.)

 If the -D option is omitted, the environment variable PGDATA is used.
 Is postmaster running?
 Please terminate postgres and try again.
 The program "postmaster" is needed by %s but was not found in the
same directory as "%s".
Check your installation.
 The program "postmaster" was found by "%s"
but was not the same version as %s.
Check your installation.
 Try "%s --help" for more information.
 Usage:
 child process exited with exit code %d child process exited with unrecognized status %d child process was terminated by signal %d could not change directory to "%s" could not find a "%s" to execute could not identify current directory: %s could not read binary "%s" could not read symbolic link "%s" could not start postmaster
 invalid binary "%s" postmaster shutting down
 postmaster signaled
 postmaster started
 postmaster starting
 postmaster stopped
 starting postmaster anyway
 waiting for postmaster to shut down... waiting for postmaster to start... Project-Id-Version: pg_ctl-ro-8.0
POT-Creation-Date: 2005-01-16 01:11+0000
PO-Revision-Date: 2005-01-16 10:54+0200
Last-Translator: Alin Vaida <alin.vaida@gmail.com>
Language-Team: Romanian <translators@postgresql.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.10
 
Semnale permise pentru kill:
 
Op?iuni generale:
 
Op?iuni pentru ?nregistrare ?i de-?nregistrare:
 
Op?iuni pentru pornire sau repornire:
 
Op?iuni pentru oprire sau repornire:
 
Raporta?i erorile la <pgsql-bugs@postgresql.org>.
 
Modurile de ?nchidere sunt:
   %s kill    NUMESEMNAL PID
   %s register   [-N NUMESERVICIU] [-U NUMEUTILIZATOR] [-P PAROL?] [-D DIRDATE]
                    [-w] [-o "OP?IUNI"]
   %s reload  [-D DIRDATE] [-s]
   %s restart [-w] [-D DIRDATE] [-s] [-m MOD-?NCHIDERE] [-o "OP?IUNI"]
   %s start   [-w] [-D DIRDATE] [-s] [-l NUMEFI?IER] [-o "OP?IUNI"]
   %s status  [-D DIRDATE]
   %s stop    [-W] [-D DIRDATE] [-s] [-m MOD-?NCHIDERE]
   %s unregister [-N NUMESERVICIU]
   --help                 afi?eaz? acest ajutor, apoi iese
   --version              afi?eaz? informa?ii despre versiune, apoi iese
   -D, --pgdata DIRDATE   loca?ia ariei de stocare a bazelor de date
   -N NUMESERVICIU  numele serviciului pentru ?nregistrarea serverului PostgreSQL
   -P PAROL?       parola contului pentru ?nregistrarea serverului PostgreSQL
   -U NUMEUTILIZATOR  numele utilizatorului pentru ?nregistrarea serverului PostgreSQL
   -W                     nu se a?teapt? terminarea opera?iunilor
   -l, --log NUMEFI?IER   scrie (sau adaug?) jurnalul serverului ?n NUMEFI?IER
   -m MOD-?NCHIDERE   poate fi "smart", "fast", sau "immediate"
   -o OP?IUNI             op?iuni din linia de comand? trimise c?tre postmaster
                         (fi?ierul executabil pentru serverul PostgreSQL)
   -p CALE-C?TRE-POSTMASTER  ?n mod normal, nu e necesar?
   -s, --silent           afi?eaz? numai erorile, f?r? mesaje informa?ionale
   -w                     se a?teapt? terminarea opera?iunilor
   fast (rapid)           termin? direct, cu ?nchidere corespunz?toare
   immediate (imediat)    termin? f?ra ?nchidere complet?, ceea ce va duce la recuperare odat? cu repornirea
   smart (iste?)          termin? dup? ce to?i clien?ii s-au deconectat
  terminat
  e?uat
 %s este un utilitar pentru pornit, oprit, repornit, re?nc?rcat fi?ierele de configurare,
raportat starea unui server PostgreSQL sau trimis semnale unui proces PostgreSQL.

 %s: fi?ierul PID "%s" nu exist?
 %s: ruleaz? un proces "postgres" de sine st?t?tor (PID: %ld)
 %s: e posibil ca alt? instan?? de postmaster s? ruleze; se ?ncearc? pornirea lui oricum
 %s: nu poate fi rulat ca root
Autentifica?i-v? (folosind, de ex., "su") ca utilizatorul (neprivilegiat) care va de?ine procesul serverului.
 %s: imposibil de re?nc?rcat postmaster; postgres ruleaz? (PID: %ld)
 %s: imposibil de repornit postmaster; postgres ruleaz? (PID: %ld)
 %s: imposibil de oprit postmaster; postgres ruleaz? (PID: %ld)
 %s: imposibil de g?sit propriul program executabil
 %s: imposibil de g?sit programul executabil pentru postmaster
 %s: imposibil de deschis fi?ierul PID "%s": %s %s: imposibil de deschis serviciul "%s": cod de eroare %d
 %s: imposibil de deschis administratorul de servicii
 %s: imposibil de citit fi?ierul "%s"
 %s: imposibil de ?nregistrat serviciul "%s": cod de eroare %d
 %s: imposibil de trimis semnalul de re?nc?rcare (PID: %ld): %s
 %s: imposibil de trimis semnalul %d (PID: %ld): %s
 %s: imposibil de trimis semnalul de oprire (PID: %ld): %s
 %s: imposibil de pornit postmaster
Examina?i jurnalul de ie?ire.
 %s: imposibil de pornit postmaster: codul de ie?ire a fost %d
 %s: imposibil de pornit serviciul "%s": cod de eroare %d
 %s: imposibil de de-?nregistrat serviciul "%s": cod de eroare %d
 %s: op?iune incorect? %s
 %s: lipse?te argumentul pentru modul kill
 %s: nu ruleaz? nici postmaster, nici postgres
 %s: nici un director pentru baze de date specificat, iar variabila de mediu PGDATA nu este setat?
 %s: nici o opera?iune specificat?
 %s: fi?ierul de op?iuni "%s" trebuie s? aib? exact o linie
 %s: memorie insuficient?
 %s: postmaster nu se ?nchide
 %s: postmaster ruleaz? (PID: %ld)
 %s: serviciul "%s" este deja ?nregistrat
 %s: serviciul "%s" nu a fost ?nregistrat
 %s: prea multe argumente ?n linia de comand? (primul este "%s")
 %s: mod de operare nerecunoscut "%s"
 %s: mod de ?nchidere nerecunoscut "%s"
 %s: nume de semnal nerecunoscut "%s"
 (Implicit, se a?teapt? pentru ?nchidere, nu ?i pentru pornire sau repornire)

 Dac? este omis? op?iunea -D, este folosit? variabila de mediu PGDATA.
 Ruleaz? postmaster?
 Termina?i postgres ?i ?ncerca?i din nou.
 Programul "postmaster" este necesar pentru %s, dar nu a fost g?sit ?n acela?i director cu "%s".
Verifica?i instalarea.
 Programul "postmaster" a fost g?sit de "%s",
dar nu are aceea?i versiune cu %s.
Verifica?i instalarea.
 ?ncerca?i "%s --help" pentru mai multe informa?ii.
 Utilizare:
 procesul fiu a ie?it cu codul %d procesul fiu a ie?it cu starea nerecunoscut? %d procesul fiu a fost terminat cu semnalul %d imposibil de schimbat directorul ?n "%s" imposibil de g?sit "%s" pentru executare imposibil de identificat directorul curent: %s imposibil de citit binar "%s" imposibil de citit leg?tura simbolic? "%s" imposibil de pornit postmaster
 binar incorect "%s" ?nchidere postmaster
 semnalul a fost trimis lui postmaster
 postmaster pornit
 postmaster porne?te
 postmaster oprit
 pornire postmaster oricum
 ?nchidere postmaster ?n a?teptare... se a?teapt? ca postmaster s? porneasc?... 