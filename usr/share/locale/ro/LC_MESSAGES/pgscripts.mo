??    y      ?  ?   ?      8
  K   9
     ?
  ^   ?
  
   ?
  >     =   D  -   ?     ?  #   ?     ?  (        1  <   N  9   ?  6   ?  H   ?  E   E  B   ?  6   ?  9     C   ?  9   ?  4   ?  H   ?  ;   ;  E   w  :   ?  9   ?  7   2  4   j  L   ?  J   ?  3   7  0   k  ;   ?  3   ?  7     2   D  :   w  5   ?  G   ?  0   0  <   a  M   ?  J   ?  G   7  4     H   ?  E   ?  <   C  6   ?  I   ?  4     1   6  ;   h  8   ?  5   ?  =     8   Q  8   ?  /   ?  <   ?  #   0  #   T  ?   x  #   ?     ?  3   ?  &   0  5   W  E   ?  4   ?  D        M  *   k  8   ?  6   ?  %     (   ,  (   U  8   ~  #   ?      ?     ?  8     4   U  $   ?     ?  ,   ?  ,   ?     )     >  #   Q  G   u  4   ?     ?  &        8  )   U  7        ?  +   ?     ?     	     %     B     `  
   e     p     ?  9   ?  >   ?  P      &   h      ?   '   ?      ?      ?      ?      ?   V  ?   N   !"     p"  u   ?"  
   ?"  <   	#  ;   F#  3   ?#     ?#  %   ?#     ?#  &   $  "   7$  C   Z$  @   ?$  =   ?$  S   %  P   q%  M   ?%  J   &  D   [&  N   ?&  ?   ?&  8   /'  T   h'  ;   ?'  J   ?'  E   D(  =   ?(  T   ?(  Q   )  U   o)  X   ?)  /   *  ,   N*  =   {*  G   ?*  ?   +  :   A+  A   |+  8   ?+  F   ?+  3   >,  H   r,  H   ?,  E   -  B   J-  0   ?-  X   ?-  U   .  J   m.  C   ?.  @   ?.  A   =/  >   /  ?   ?/  <   ?/  9   ;0  A   u0  <   ?0  /   ?0  4   $1  C   Y1  '   ?1  *   ?1  D   ?1  '   52  &   ]2  7   ?2  .   ?2  ?   ?2  J   +3  >   v3  I   ?3     ?3  ,   4  ;   K4  B   ?4  -   ?4  0   ?4  :   )5  C   d5  &   ?5  %   ?5  (   ?5  :   6  8   Y6  %   ?6  %   ?6  8   ?6  3   7     K7     e7  .   ~7  Q   ?7  @   ?7     @8  9   \8     ?8  *   ?8  :   ?8     9  -   -9     [9  .   q9  ,   ?9  +   ?9     ?9     ?9     :     :  2   3:  6   f:  P   ?:  3   ?:     ";  ,   .;     [;     ];     `;     b;            q       ?   F   7   e   w   K   s   >   I   0   M      r   +   y   [          $                 R       -             @   Z           `   x   	   1       G   k              )   p       3   W   d   =   6   Q   m   B              J                      
   L             D   O   9          \          %   t               u   .   P   _   S       f   *      o         n           C       #       4       ;   E      N   j      a          ,   v   H   (      ^   <      h      :   "   A      /      l   T   '                      i   g       X      !   8       c       ]       U           5   Y   &      b       2   V    
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
 Try "%s --help" for more information.
 Usage:
 User "%s" will be permanently removed.
 n no y yes Project-Id-Version: pgscripts-ro-8.0
POT-Creation-Date: 2005-01-16 01:14+0000
PO-Revision-Date: 2005-01-16 16:23+0200
Last-Translator: Alin Vaida <alin.vaida@gmail.com>
Language-Team: Romanian <translators@postgresql.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.10
 
Implicit, este creat? o baz? de date cu acela?i nume ca utilizatorul curent.
 
Op?iuni de conectare:
 
Dac? una din op?iunile -a, -A, -d, -D ?i NUMEUTILIZATOR nu este specificat?, ea va fi solicitat? ?n mod interactiv.
 
Op?iuni:
 
Consulta?i descrierea comenzii SQL CLUSTER pentru detalii.
 
Consulta?i descrierea comenzii SQL VACUUM pentru detalii.
 
Raporta?i erorile la <pgsql-bugs@postgresql.org>.
   %s [OP?IUNE]...NUMEBD
   %s [OP?IUNE]...NUMELIMBAJ [NUMEBD]
   %s [OP?IUNE]...[NUMEDB]
   %s [OP?IUNE].. [NUMEBD] [DESCRIERE]
   %s [OP?IUNE]...[NUMEUTILIZATOR]
   --help                          afi?eaz? acest ajutor, apoi iese
   --help                       afi?eaz? acest ajutor, apoi iese
   --help                    afi?eaz? acest ajutor, apoi iese
   --version                       afi?eaz? informa?iile despre versiune, apoi iese
   --version                    afi?eaz? informa?iile despre versiune, apoi iese
   --version                 afi?eaz? informa?iile despre versiune, apoi iese
   -A, --no-adduser          utilizatorul nu poate ad?uga al?i utilizatori
   -D, --no-createdb         utilizatorul nu poate crea baze de date
   -D, --tablespace=SPA?IUTBL   spa?iul de tabele implicit pentru baza de date
   -E, --encoding=CODIFICARE    codificarea pentru baza de date
   -E, --encrypted           parola este stocat? criptat
   -L, --pglib=DIRECTOR      caut? fi?ierul de interpretare a limbajului ?n DIRECTOR
   -N, --unencrypted         parola nu este stocat? criptat
   -O, --owner=PROPRIETAR       utilizatorul care de?ine noua baz? de date
   -P, --pwprompt            se asigneaz? o parol? utilizatorului nou
   -T, --template=?ABLON        ?ablonul bazei de date copiat
   -U, --username=USERNAME      conectare ca utilizatorul de baze de date specificat
   -U, --username=USERNAME   conectare ca utilizatorul de baze de date specificat
   -U, --username=USERNAME   numele utilizatorului pentru conectare (nu cel de creat)
   -U, --username=USERNAME   numele utilizatorului pentru conectare (nu cel de eliminat)
   -W, --password               solicit? parola
   -W, --password            solicit? parola
   -W, --password            solicit? parola pentru conectare
   -a, --adduser             utilizatorul poate ad?uga al?i utilizatori
   -a, --all                       videaz? toate bazele de date
   -a, --all                 grupeaz? toate bazele de date
   -d, --createdb            utilizatorul poate crea baze de date
   -d, --dbname=NUMEBD             baza de date de vidat
   -d, --dbname=NUMEBD       baza de date din care se elimin? limbajul
   -d, --dbname=DBNAME       baza de date de grupat
   -d, --dbname=NUMEBD       baza de date ?n care se instaleaz? limbajul
   -e, --echo                      afi?eaz? comenzile trimise serverului
   -e, --echo                   afi?eaz? comenzile trimise serverului
   -e, --echo                afi?eaz??comenzile?trimise?serverului
   -f, --full                      vidare total?
   -h, --host=NUMEGAZD?         gazda serverului de baze de date sau directorul soclului
   -h, --host=NUMEGAZD?      gazda serverului de baze de date sau directorul soclului
   -i, --interactive         solicit? confirmarea ?nainte de a ?terge ceva
   -i, --sysid=SYSID         id-ul de sistem pentru noul utilizator
   -l, --list                afi?eaz? lista limbajelor instalate
   -p, --port=PORT              portul serverului de baze de date
   -p, --port=PORT           portul serverului de baze de date
   -q, --quiet                     nu se afi?eaz? nici un mesaj
   -q, --quiet                  nu se afi?eaz? nici un mesaj
   -q, --quiet               nu se afi?eaz? nici un mesaj
   -t, --table='TABEL?[(COLOANE)]' videaz? numai o anumit? tabel?
   -t, --table=TABLE         grupeaz? numai o anumit? tabel?
   -v, --verbose                   mod detaliat
 %s cur??? ?i analizeaz? o baz? de date PostgreSQL.

 %s grupeaz? toate tabelele grupate anterior dintr-o baz? de date.

 %s creeaz? o baz? de date PostgreSQL.

 %s creeaz? un utilizator PostgreSQL nou.

 %s instaleaz? un limbaj procedural ?ntr-o baz? de date PostgreSQL.

 %s elimin? o baz? de date PostgreSQL.

 %s elimin? un utilizator PostgreSQL.

 %s elimin? un limbaj procedural dintr-o baz? de date.

 %s: "%s" nu este un nume de codificare corect
 %s: imposibil de grupat o tabel? anume ?n toate bazele de date
 %s: imposibil de grupat toate bazele de date ?i una anume ?n acela?i timp
 %s: imposibil de vidat o tabel? anume ?n toate bazele de date
 %s: imposibil de vidat toate bazele de date ?i una anume ?n acela?i timp
 %s: grupare baz? de date "%s"
 %s: gruparea bazei de date "%s" a e?uat: %s  %s: gruparea tabelei "%s" din baza de date "%s" a e?uat: %s %s: crearea comentariului a e?uat (baza de date a fost creat?): %s %s: imposibil de conectat la baza de date %s
 %s: imposibil de conectat la baza de date %s: %s %s: imposibil de ob?inut numele utilizatorului curent: %s
 %s: imposibil de ob?inut informa?ii despre utilizatorul curent: %s
 %s: crearea utilizatorului a e?uat: %s %s: crearea bazei de date a e?uat: %s %s: eliminarea bazei de date a e?uat: %s %s: limbajul "%s" este deja instalat ?n baza de date "%s"
 %s: limbajul "%s" nu este instalat ?n baza de date "%s"
 %s: instalarea limbajului a e?uat: %s %s: eliminarea limbajului a e?uat: %s %s: lipse?te argumentul solicitat, numele bazei de date
 %s: lipse?te argumentul necesar, numele limbajului
 %s: interogare e?uat?: %s %s: interogarea era: %s
 %s: eliminarea utilizatorului "%s" a e?uat: %s %s: %s func?ii sunt inc? declarate ?n limbajul "%s"; limbajul nu a fost eliminat
 %s: prea multe argumente ?n linia de comand? (primul este "%s")
 %s: limbaj nesuportat "%s"
 %s: ID-ul utilizatorului trebuie s? fie un num?r pozitiv
 %s: vidare baz? de date "%s"
 %s: vidarea bazei de date "%s" a e?uat: %s %s: vidarea tabelei "%s" din baza de date "%s" a e?uat: %s Continua?i? (d/n)  Baza de date "%s" va fi eliminat? definitiv.
 Introduce?i din nou:  Introduce?i numele utilizatorului de ad?ugat:  Introduce?i numele utilizatorului de ?ters:  Introduce?i parola pentru noul utilizator:  Nume Parol?:  Parola nu se verific?.
 Limbaje procedurale Noul utilizator va putea crea baze de date? (d/n)  Noul utilizator va putea crea al?i utilizatori? (d/n)  Limbajele suportate sunt plpgsql, pltcl, pltclu, plperl, plperlu, ?i plpythonu.
 ?ncerca?i "%s --help" pentru mai multe informa?ii.
 Utilizare:
 Utilizatorul "%s" va fi eliminat definitiv.
 n nu d da 