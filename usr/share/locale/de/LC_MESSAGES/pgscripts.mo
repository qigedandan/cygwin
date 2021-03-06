??    {      ?  ?   ?      h
  K   i
     ?
  ^   ?
  
   *  >   5  =   t  -   ?     ?  #   ?       (   8     a  <   ~  9   ?  6   ?  H   ,  E   u  B   ?  6   ?  9   5  C   o  9   ?  4   ?  H   "  ;   k  E   ?  :   ?  9   (  7   b  4   ?  L   ?  J     3   g  0   ?  ;   ?  3     7   <  2   t  :   ?  5   ?  G     0   `  <   ?  M   ?  J     G   g  4   ?  H   ?  E   -  <   s  6   ?  I   ?  4   1  1   f  ;   ?  8   ?  5     =   C  8   ?  8   ?  9   ?  /   -  <   ]  #   ?  #   ?  ?   ?  #   "     F  3   f  &   ?  5   ?  E   ?  4   =  D   r     ?  *   ?  8      6   9  %   p  (   ?  (   ?  8   ?  #   !      E     f  8   ?  4   ?  $   ?       ,   9  ,   f     ?     ?  #   ?  G   ?  4   '     \  &   {     ?  )   ?  7   ?     !  +   6     b     s     ?     ?     ?  
   ?     ?     ?  9      >   B   P   ?      ?   &   ?      !  '   
!     2!     4!     7!     9!  `  =!  l   ?"     #  [   "#     ~#  U   ?#  R   ?#  6   3$     j$      ?$     ?$  )   ?$      ?$  E   	%  B   O%  ?   ?%  O   ?%  L   "&  I   o&  H   ?&  E   '  A   H'  ;   ?'  C   ?'  I   
(  I   T(  >   ?(  E   ?(  @   #)  5   d)  2   ?)  ?   ?)  ?   T*  4   ?*  1   +  ?   J+  A   ?+  H   ?+  6   ,  D   L,  G   ?,  l   ?,  4   F-  n   {-  y   ?-  s   d.  m   ?.  <   F/  Q   ?/  N   ?/  H   $0  @   m0  K   ?0  9   ?0  6   41  @   k1  =   ?1  :   ?1  h   %2  @   ?2  :   ?2  K   
3  6   V3  C   ?3  '   ?3  -   ?3  H   '4  &   p4  &   ?4  9   ?4  *   ?4  E   #5  J   i5  D   ?5  I   ?5     C6  2   `6  B   ?6  M   ?6  ,   $7  /   Q7  7   ?7  E   ?7  4   ?7  2   48  ,   g8  ;   ?8  9   ?8  /   
9  *   :9  %   e9  $   ?9     ?9     ?9  1   ?9  J   :  :   a:  #   ?:  -   ?:  *   ?:  3   ;  C   M;     ?;  4   ?;     ?;  -   <  5   0<  0   f<     ?<  
   ?<  #   ?<     ?<  :   ?<  D   =  K   `=  	   ?=  5   ?=     ?=  3   ?=     ,>     .>     3>     5>            r   X   j              M   A   K   V   {           "   (   ?       )       =   O   T   ,          v      U               >   &   J   !           g             p   	       7          [           Y   x       Z         ;   /   a       E           B   q   2              D   c   P   t   z       '       w   5       R   4   #   1      n   N   :   y   Q   $   .                 u               3       <          o   W                +   S   G   L   %      ^   ]   9           b   6   s   f   I                   m   _      \   `          -   l           0   h       i   k   H   F       *       
   C      @   e         d   8           
By default, a database with the same name as the current user is created.
 
Connection options:
 
If one of -a, -A, -d, -D, and USERNAME is not specified, you will
be prompted interactively.
 
Options:
 
Read the description of the SQL command CLUSTER for details.
 
Read the description of the SQL command VACUUM for details.
 
Report bugs to <pgsql-bugs@postgresql.org>.
   %s [OPTION]... DBNAME
   %s [OPTION]... LANGNAME [DBNAME]
   %s [OPTION]... [DBNAME]
   %s [OPTION]... [DBNAME] [DESCRIPTION]
   %s [OPTION]... [USERNAME]
   --help                          show this help, then exit
   --help                       show this help, then exit
   --help                    show this help, then exit
   --version                       output version information, then exit
   --version                    output version information, then exit
   --version                 output version information, then exit
   -A, --no-adduser          user cannot add new users
   -D, --no-createdb         user cannot create databases
   -D, --tablespace=TABLESPACE  default tablespace for the database
   -E, --encoding=ENCODING      encoding for the database
   -E, --encrypted           encrypt stored password
   -L, --pglib=DIRECTORY     find language interpreter file in DIRECTORY
   -N, --unencrypted         do not encrypt stored password
   -O, --owner=OWNER            database user to own the new database
   -P, --pwprompt            assign a password to new user
   -T, --template=TEMPLATE      template database to copy
   -U, --username=USERNAME      user name to connect as
   -U, --username=USERNAME   user name to connect as
   -U, --username=USERNAME   user name to connect as (not the one to create)
   -U, --username=USERNAME   user name to connect as (not the one to drop)
   -W, --password               prompt for password
   -W, --password            prompt for password
   -W, --password            prompt for password to connect
   -a, --adduser             user can add new users
   -a, --all                       vacuum all databases
   -a, --all                 cluster all databases
   -d, --createdb            user can create new databases
   -d, --dbname=DBNAME             database to vacuum
   -d, --dbname=DBNAME       database from which to remove the language
   -d, --dbname=DBNAME       database to cluster
   -d, --dbname=DBNAME       database to install language in
   -e, --echo                      show the commands being sent to the server
   -e, --echo                   show the commands being sent to the server
   -e, --echo                show the commands being sent to the server
   -f, --full                      do full vacuuming
   -h, --host=HOSTNAME          database server host or socket directory
   -h, --host=HOSTNAME       database server host or socket directory
   -i, --interactive         prompt before deleting anything
   -i, --sysid=SYSID         select sysid for new user
   -l, --list                show a list of currently installed languages
   -p, --port=PORT              database server port
   -p, --port=PORT           database server port
   -q, --quiet                     don't write any messages
   -q, --quiet                  don't write any messages
   -q, --quiet               don't write any messages
   -t, --table='TABLE[(COLUMNS)]'  vacuum specific table only
   -t, --table=TABLE         cluster specific table only
   -v, --verbose                   write a lot of output
   -z, --analyze                   update optimizer hints
 %s cleans and analyzes a PostgreSQL database.

 %s clusters all previously clustered tables in a database.

 %s creates a PostgreSQL database.

 %s creates a new PostgreSQL user.

 %s installs a procedural language into a PostgreSQL database.

 %s removes a PostgreSQL database.

 %s removes a PostgreSQL user.

 %s removes a procedural language from a database.

 %s: "%s" is not a valid encoding name
 %s: cannot cluster a specific table in all databases
 %s: cannot cluster all databases and a specific one at the same time
 %s: cannot vacuum a specific table in all databases
 %s: cannot vacuum all databases and a specific one at the same time
 %s: clustering database "%s"
 %s: clustering of database "%s" failed: %s %s: clustering of table "%s" in database "%s" failed: %s %s: comment creation failed (database was created): %s %s: could not connect to database %s
 %s: could not connect to database %s: %s %s: could not get current user name: %s
 %s: could not obtain information about current user: %s
 %s: creation of new user failed: %s %s: database creation failed: %s %s: database removal failed: %s %s: language "%s" is already installed in database "%s"
 %s: language "%s" is not installed in database "%s"
 %s: language installation failed: %s %s: language removal failed: %s %s: missing required argument database name
 %s: missing required argument language name
 %s: query failed: %s %s: query was: %s
 %s: removal of user "%s" failed: %s %s: still %s functions declared in language "%s"; language not removed
 %s: too many command-line arguments (first is "%s")
 %s: unsupported language "%s"
 %s: user ID must be a positive number
 %s: vacuuming database "%s"
 %s: vacuuming of database "%s" failed: %s %s: vacuuming of table "%s" in database "%s" failed: %s Are you sure? (y/n)  Database "%s" will be permanently removed.
 Enter it again:  Enter name of user to add:  Enter name of user to drop:  Enter password for new user:  Name Password:  Passwords didn't match.
 Procedural Languages Shall the new user be allowed to create databases? (y/n)  Shall the new user be allowed to create more new users? (y/n)  Supported languages are plpgsql, pltcl, pltclu, plperl, plperlu, and plpythonu.
 Trusted? Try "%s --help" for more information.
 Usage:
 User "%s" will be permanently removed.
 n no y yes Project-Id-Version: PostgreSQL 8.0
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2004-12-12 18:37+0100
PO-Revision-Date: 2004-12-12 18:39+0100
Last-Translator: Peter Eisentraut <peter_e@gmx.net>
Language-Team: German <peter_e@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.0.1
 
Wenn nichts anderes angegeben ist, dann wird eine Datenbank mit dem Namen
des aktuellen Benutzers erzeugt.
 
Verbindungsoptionen:
 
Wenn -a, -A, -d, -D oder BENUTZER nicht angegeben wird, dann wird
interaktiv nachgefragt.
 
Optionen:
 
F?r weitere Informationen lesen Sie bitte die Beschreibung des
SQL-Befehls CLUSTER.
 
F?r weitere Information lesen Sie bitte die Beschreibung des
SQL-Befehls VACUUM.
 
Berichten Sie Fehler an <pgsql-bugs@postgresql.org>.
  %s [OPTION]... DBNAME
 %s [OPTION]... SPRACHE [DBNAME]
   %s [OPTION]... [DBNAME]
   %s [OPTION]... [DBNAME] [BESCHREIBUNG]
   %s [OPTION]... [BENUTZERNAME]
   --help                          diese Hilfe anzeigen, dann beenden
   --help                       diese Hilfe anzeigen, dann beenden
   --help                    diese Hilfe anzeigen, dann beenden
   --version                       Versionsinformationen anzeigen, dann beenden
   --version                    Versionsinformationen anzeigen, dann beenden
   --version                 Versionsinformationen anzeigen, dann beenden
   -A, --no-adduser          Benutzer kann keine neuen Benutzer erzeugen
   -D, --no-createdb         Benutzer kann keine Datenbanken erzeugen
   -D, --tablespace=TABLESPACE  Standard-Tablespace der Datenbank
   -E, --encoding=KODIERUNG     Kodierung f?r die Datenbank
   -E, --encrypted           verschl?ssle das gespeicherte Passwort
   -L, --pglib=VERZEICHNIS   finde Sprachinterpreter-Datei in VERZEICHNIS
   -N, --unencrypted         verschl?ssle das gespeicherte Passwort nicht
   -O, --owner=EIGENT?MER       Eigent?mer der neuen Datenbank
   -P, --pwprompt            weise dem neuen Benutzer ein Passwort zu
   -T, --template=TEMPLATE      zu kopierende Template-Datenbank
   -U, --username=NAME          Datenbankbenutzername
   -U, --username=NAME       Datenbankbenutzername
   -U, --username=BENUTZER   Datenbankbenutzername f?r die Verbindung
                            (nicht der Name des neuen Benutzers)
   -U, --username=BENUTZER   Datenbankbenutzername f?r die Verbindung
                            (nicht der Name des zu l?schenden Benutzers)
   -W, --password               nach Passwort fragen
   -W, --password            nach Passwort fragen
   -W, --password            frage nach Passwort f?r Verbindung
   -a, --adduser             Benutzer kann neue Benutzer erzeugen
   -a, --all                       f?hre Vacuum in allen Datenbanken aus
   -a, --all                 clustere alle Datenbanken
   -d, --createdb            Benutzer kann neue Datenbanken erzeugen
   -d, --dbname=DBNAME             f?hre Vacuum in dieser Datenbank aus
   -d, --dbname=DBNAME       Datenbank, aus der die Sprache gel?scht
                            werden soll
   -d, --dbname=DBNAME       zu clusternde Datenbank
   -d, --dbname=DBNAME       Datenbank, in der die Sprache installiert
                            werden soll
   -e, --echo                      zeige die Befehle, die an den Server
                                  gesendet werden
   -e, --echo                   zeige die Befehle, die an den Server
                               gesendet werden
   -e, --echo                zeige die Befehle, die an den Server
                            gesendet werden
   -f, --full                      f?hre volles Vacuum durch
   -h, --host=HOSTNAME          Name des Datenbankservers oder Socket-Verzeichnis
   -h, --host=HOSTNAME       Name des Datenbankservers oder Socket-Verzeichnis
   -i, --interactive         frage nach, bevor irgendetwas gel?scht wird
   -i, --sysid=SYSID         w?hle System-ID des neuen Benutzers
   -l, --list                zeige Liste gegenw?rtig installierter Sprachen
   -p, --port=PORT              Port des Datenbankservers
   -p, --port=PORT           Port des Datenbankservers
   -q, --quiet                     unterdr?cke alle Mitteilungen
   -q, --quiet                  unterdr?cke alle Mitteilungen
   -q, --quiet               unterdr?cke alle Mitteilungen
   -t, --table='TABELLE[(SPALTEN)]'
                                  f?hre Vacuum f?r diese Tabelle aus
   -t, --table=TABELLE       clustere nur eine bestimmte Tabelle
   -v, --verbose                   erzeuge viele Meldungen
   -z, --analyze                   aktualisiere Hinweise f?r den Optimierer
 %s s?ubert und analysiert eine PostgreSQL-Datenbank.

 %s clustert alle vorher geclusterten Tabellen in einer Datenbank.

 %s erzeugt eine PostgreSQL-Datenbank.

 %s erzeugt einen neuen PostgreSQL-Benutzer.

 %s installiert eine prozedurale Sprache in einer PostgreSQL-Datenbank.

 %s l?scht eine PostgreSQL-Datenbank.

 %s l?scht einen PostgreSQL-Benutzer.

 %s l?scht eine prozedurale Sprache aus einer Datenbank.

 %s: ?%s? ist kein g?ltiger Kodierungsname
 %s: kann nicht eine bestimmte Tabelle in allen Datenbanken clustern.
 %s: kann nicht alle Datenbanken und eine bestimmte gleichzeitig clustern.
 %s: kann nicht eine bestimmte Tabelle in allen Datenbanken vacuumen
 %s: kann nicht alle Datenbanken und eine bestimmte gleichzeitig vacuumen
 %s: clustere Datenbank ?%s?
 %s: Clustern der Datenbank ?%s? fehlgeschlagen: %s %s: Clustern der Tabelle ?%s? in Datenbank ?%s? fehlgeschlagen: %s %s: Erzeugung des Kommentars ist fehlgeschlagen (Datenbank wurde erzeugt): %s %s: konnte nicht mit Datenbank %s verbinden
 %s: konnte nicht mit Datenbank %s verbinden: %s %s: konnte aktuellen Benutzernamen nicht ermitteln: %s
 %s: konnte Informationen ?ber aktuellen Benutzer nicht ermitteln: %s
 %s: Erzeugung des neuen Benutzers fehlgeschlagen: %s %s: Erzeugung der Datenbank ist fehlgeschlagen: %s %s: L?schen der Datenbank fehlgeschlagen: %s %s: Sprache ?%s? ist bereits in Datenbank ?%s? installiert
 %s: Sprache ?%s? ist nicht in Datenbank ?%s? installiert
 %s: Installation der Sprache fehlgeschlagen: %s %s: L?schen der Sprache fehlgeschlagen: %s %s: Datenbankname als Argument fehlt
 %s: Sprachenname als Argument fehlt
 %s: Anfrage fehlgeschlagen: %s %s: Anfrage war: %s
 %s: L?schen des Benutzers ?%s? fehlgeschlagen: %s %s: noch %s Funktionen in Sprache ?%s? deklariert; Sprache nicht gel?scht
 %s: zu viele Kommandozeilenargumente (das erste ist ?%s?)
 %s: Sprache ?%s? nicht unterst?tzt
 %s: Benutzer-ID muss eine positive Zahl sein
 %s: f?hre Vacuuming in Datenbank ?%s? aus
 %s: Vacuuming der Datenbank ?%s? fehlgeschlagen: %s %s: Vacuuming der Tabelle ?%s? in Datenbank ?%s? fehlgeschlagen: %s Sind Sie sich sicher? (j/n)  Datenbank ?%s? wird unwiderruflich gel?scht werden.
 Geben Sie es noch einmal ein:  Geben Sie den Namen des neuen Benutzers ein:  Geben Sie den Namen des zu l?schenden Benutzers ein:  Geben Sie das Passwort des neuen Benutzers ein:  Name Passwort:  Passw?rter stimmten nicht ?berein.
 Prozedurale Sprachen Soll der neue Benutzer Datenbanken erzeugen d?rfen? (j/n)  Soll der neue Benutzer weitere neue Benutzer erzeugen d?rfen? (j/n)  Unterst?tzte Sprachen sind plpgsql, pltclu, plperl, plperlu und plpythonu.
 Vertraut? Versuchen Sie ?%s --help? f?r weitere Informationen.
 Benutzung:
 Benutzer ?%s? wird unwiderruflich gel?scht werden.
 n nein j ja 