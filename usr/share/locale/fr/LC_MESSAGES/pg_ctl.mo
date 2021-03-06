??    c      4  ?   L      p      q     ?  &   ?     ?     ?  -   
	     8	     N	  r   k	     ?	  F   ?	  A   E
     ?
  7   ?
  !   ?
  3   ?
  ?   0  ?   p  H   ?  D   ?  E   >  ?   ?  B   ?  <     ?   D  0   ?  F   ?  8   =  2   v  O   ?  7   ?     1     8  ?   A  !   ?  :   ?  I   /  y   y  =   ?  >   1  ;   p  *   ?  1   ?  %   	  /   /  #   _     ?  3   ?  0   ?  ,     .   3  7   b  1   ?  0   ?  5   ?  "   3     V  $   m  ,   ?  J   ?     
  7   &  0   ^     ?  "   ?  %   ?  $   ?        4   1  %   f  $   ?  "   ?  F   ?  F        b  )   z  s   ?  h     &   ?     ?  &   ?  0   ?  )     "   2      U  (   v     ?  !   ?     ?     ?          &     ;     O     d     x  &   ?  "   ?  R  ?     1     Q  /   g  #   ?  $   ?  5   ?       !   1     S  #   ?  G   ?  H   ?     ?  8   ?  !   ?  8     8   ;  I   t  O   ?  P      [   _   <   ?   \   ?   A   U!  ?   ?!  4   !"  U   V"  6   ?"  2   ?"  \   #  F   s#     ?#  
   ?#  ?   ?#  &   ?$  ?   ?$  o   ?$  ?   [%  X   &  W   ^&  U   ?&  1   '  3   >'  2   r'  <   ?'  5   ?'  (   (  A   A(  E   ?(  8   ?(  =   )  D   @)  B   ?)  ?   ?)  @   *  0   I*     z*  +   ?*  <   ?*  f   ?*      c+  A   ?+  >   ?+     ,  $   ,  5   @,  )   v,  *   ?,  A   ?,  '   -  #   5-     Y-  d   w-  K   ?-  )   (.  +   R.  ?   ~.  y   /  .   ?/     ?/  4   ?/  8   ?/  0   '0  %   X0  (   ~0  0   ?0     ?0  '   ?0  !    1     B1     X1     u1     ?1  !   ?1     ?1  $   ?1  &   2  (   *2     J       `       )   C      9   Z   2       8      *       V   	   H   7      A          3   E                  c       _                      ]   F   -       ^         #      .          0          P              !   [          U   B   G   X       4       %   N           &   =         ;              @   +       I      ?       a   L   K           6       b   <             Q   >      R       O            Y   1   "      \       :       S   ,   $   (       W   T       5   
   M         '   /                 D        
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
 %s: could not open PID file "%s": %s
 %s: could not open service "%s": error code %d
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
 %s: invalid data in PID file "%s"
 %s: invalid option %s
 %s: missing arguments for kill mode
 %s: neither postmaster nor postgres running
 %s: no database directory specified and environment variable PGDATA unset
 %s: no operation specified
 %s: old postmaster process (PID: %ld) seems to be gone
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
 waiting for postmaster to shut down... waiting for postmaster to start... Project-Id-Version: PostgreSQL 8.0
POT-Creation-Date: 2005-11-03 19:20-0400
PO-Revision-Date: 2005-0611 13:01+0100
Last-Translator: Guillaume Lelarge <gleu@wanadoo.fr>
Language-Team: fran?ais <pgsql-fr@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.9.1
 
Signaux autoris?s pour kill :
 
Options g?n?rales :
 
Options pour enregistrer ou d?s-enregistrer :
 
Options pour lancer ou relancer :
 
Options pour arr?ter ou relancer :
 
Rapportez les bogues ? <pgsql-bugs@postgresql.org>.
 
Les modes d'arr?t sont :
   %s kill    SIGNAL ID_PROCESSUS
   %s register   [-N NOM_SERVICE] [-U NOM_UTILISATEUR] [-P MOTDEPASSE] [-D R?P_DONN?ES]
                    [-w] [-o "OPTIONS"]
   %s reload  [-D R?P_DONN?ES] [-s]
   %s restart [-w] [-D R?P_DONN?ES] [-s] [-m MODE_ARRET] [-o "OPTIONS"]
   %s start   [-w] [-D R?P_DONN?ES] [-s] [-l NOM_FICHIER] [-o "OPTIONS"]
   %s status  [-D R?P_DONN?ES]
   %s stop    [-W] [-D R?P_DONN?ES] [-s] [-m MODE_ARRET]
   %s unregister [-N NOM_SERVICE]
   --help                 affiche cette aide puis quitte
   --version              affiche la version puis quitte
   -D, --pgdata R?P_DONN?ES emplacement du stockage de la base de donn?es
   -N NOM_SERVICE  nom du service avec lequel enregistrer le serveur PostgreSQL
   -P MOT_DE_PASSE mot de passe du compte pour enregistrer le serveur PostgreSQL
   -U NOM_UTILISATEUR nom utilisateur du compte servant ? enregistrer le serveur PostgreSQL
   -W                     n'attend pas la fin de l'op?ration
   -l, --log NOMFICHIER   ?crit (ou ajoute) le journal de traces du serveur dans NOMFICHIER.
   -m MODE_ARRET      soit ?smart?, soit ?fast?, soit ?immediate?
   -o OPTIONS             options en ligne de commande ? passer au postmaster
                         (ex?cutable du serveur PostgreSQL)
   -p CHEMIN-POSTMASTER   normalement pas n?cessaire
   -s, --silent           affiche seulement les erreurs, aucun message d'informations
   -w                     attend la fin de l'op?ration
   fast        quitte directement, mais proprement
   immediate   quitte sans un arr?t complet ; am?nera une restauration au prochain lancement
   smart       quitte apr?s que tous les clients se soient d?connect?s
  fait
  a ?chou?
 %s est un outil pour lancer, arr?ter, relancer, recharger les fichiers de configuration,
rapporter le statut d'un serveur PostgreSQL
ou de lancer un signal ? un processus PostgreSQL

 %s : le fichier PID ?%s? n'existe pas
 %s : un moteur ?postgres? est en cours d'ex?cution (PID : %ld)
 %s : un autre postmaster pourrait ?tre en cours d'ex?cution ; n?anmoins, je vais essayer de lancer postmaster.
 %s : ne peut ?tre lanc? en tant que root
Merci de vous connecter (avec l'aide de ?su?) comme utilisateur (non privil?gi?)
qui sera le propri?taire du processus serveur.
 %s : impossible de recharger postmaster ; postgres est en cours d'ex?cution (PID : %ld)
 %s : impossible de relancer postmaster ; postgres est en cours d'ex?cution (PID : %ld)
 %s : impossible d'arr?ter postmaster ; postgres est en cours d'ex?cution (PID : %ld)
 %s : impossible de trouver mon propre ex?cutable
 %s : impossible de trouver l'ex?cutable postmaster
 %s : impossible d'ouvrir le fichier PID ?%s? : %s
 %s : impossible d'ouvrir le service ?%s? : code d'erreur %d
 %s : impossible d'ouvrir le gestionnaire de services
 %s : impossible de lire le fichier ?%s?
 %s : impossible d'enregistrer le service ?%s? : code d'erreur %d
 %s : impossible d'envoyer le signal de rechargement (PID : %ld) : %s
 %s : impossible d'envoyer le signal %d (PID : %ld) : %s
 %s : impossible d'envoyer le signal d'arr?t (PID : %ld) : %s
 %s : impossible de lancer postmaster
Examinez le journal des traces
 %s : impossible d'ex?cuter postmaster : le code d'erreur ?tait %d
 %s : impossible de d?marrer le service ?%s? : code d'erreur %d
 %s : impossible de supprimer le service ?%s? : code d'erreur %d
 %s : donn?es invalides dans le fichier PID ?%s?
 %s : option invalide %s
 %s : arguments manquants pour le mode kill
 %s : ni postmaster ni postgres ne sont en cours d'ex?cution
 %s : aucun r?pertoire de bases de donn?es sp?cifi? et variable d'environnement PGDATA non initialis?e
 %s : aucune op?ration sp?cifi?e
 %s : l'ancien processus postmaster (PID : %ld) semble ?tre parti
 %s : le fichier d'option ?%s? doit avoir exactement une ligne
 %s : m?moire ?puis?e
 %s : postmaster ne s'est pas arr?t?
 %s : postmaster est en cours d'ex?cution (PID : %ld)
 %s : le service ?%s? est d?j? enregistr?
 %s : le service ?%s? n'est pas enregistr?
 %s : trop d'arguments en ligne de commande (le premier est ?%s?)
 %s : mode d'op?ration non reconnu ?%s?
 %s : mode d'arr?t non reconnu ?%s?
 %s : signal non reconnu ?%s?
 (Le comportement par d?faut revient ? attendre l'arr?t, sauf pour le lancement et le relancement.)

 Si l'option -D est omise, la variable d'environnement PGDATA est utilis?e.
 postmaster est-il en cours d'ex?cution ?
 Merci d'arr?ter postgres et de re-essayer.
 Le programme ?postmaster? est n?cessaire pour %s mais n'a pas ?t? trouv? dans
le m?me r?pertoire que ?%s?.
V?rifiez votre installation.
 Le programme ?postmaster? a ?t? trouv? par ?%s?
mais n'?tait pas de la m?me version que %s.
V?rifiez votre installation.
 Essayez ?%s --help? pour plus d'informations.
 Usage :
 le processus fils a quitt? avec un code de sortie %d le processus fils a quitt? avec un statut %d non reconnu le processus fils a ?t? termin? par le signal %d n'a pas pu acc?der au r?pertoire ?%s? impossible de trouver un ?%s? ? ex?cuter n'a pas pu identifier le r?pertoire courant : %s n'a pas pu lire le binaire ?%s? n'a pas pu lire le lien symbolique ?%s? impossible d'ex?cuter postmaster
 binaire invalide ?%s? postmaster en cours d'arr?t
 envoi d'un signal ? postmaster
 postmaster d?marr?
 postmaster en cours de d?marrage
 postmaster arr?t?
 lancement de postmaster malgr? tout
 en attente de l'arr?t du postmaster... en attente du lancement de postmaster... 