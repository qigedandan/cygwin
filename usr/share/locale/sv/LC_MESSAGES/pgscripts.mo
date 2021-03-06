??    {      ?  ?   ?      h
  K   i
     ?
  ^   ?
  
   *  >   5  =   t  -   ?     ?  #   ?       (   8     a  <   ~  9   ?  6   ?  H   ,  E   u  B   ?  6   ?  9   5  C   o  9   ?  4   ?  H   "  ;   k  E   ?  :   ?  9   (  7   b  4   ?  L   ?  J     3   g  0   ?  ;   ?  3     7   <  2   t  :   ?  5   ?  G     0   `  <   ?  M   ?  J     G   g  4   ?  H   ?  E   -  <   s  6   ?  I   ?  4   1  1   f  ;   ?  8   ?  5     =   C  8   ?  8   ?  9   ?  /   -  <   ]  #   ?  #   ?  ?   ?  #   "     F  3   f  &   ?  5   ?  E   ?  4   =  D   r     ?  *   ?  8      6   9  %   p  (   ?  (   ?  8   ?  #   !      E     f  8   ?  4   ?  $   ?       ,   9  ,   f     ?     ?  #   ?  G   ?  4   '     \  &   {     ?  )   ?  7   ?     !  +   6     b     s     ?     ?     ?  
   ?     ?     ?  9      >   B   P   ?      ?   &   ?      !  '   
!     2!     4!     7!     9!  A  =!  S   "     ?"  m   ?"  
   W#  :   b#  9   ?#  5   ?#     $      &$     G$  (   b$      ?$  B   ?$  ?   ?$  >   /%  J   n%  G   ?%  D   &  H   F&  C   ?&  C   ?&  ;   '  7   S'  ?   ?'  8   ?'  N   (  D   S(  <   ?(  ?   ?(  <   )  ?   R)  m   ?)  4   S*  1   ?*  D   ?*  C   ?*  ?   C+  3   ?+  >   ?+  =   ?+  H   4,  0   },  ;   ?,  J   ?,  G   5-  D   }-  2   ?-  O   ?-  L   E.  7   ?.  >   ?.  ?   	/  5   I/  2   /  B   ?/  ?   ?/  <   50  h   r0  ;   ?0  :   1  @   R1  5   ?1  =   ?1  "   2  '   *2  ;   R2  $   ?2  &   ?2  0   ?2  *   3  9   63  ?   p3  @   ?3  E   ?3     74  .   V4  <   ?4  ?   ?4  )   5  ,   ,5  :   Y5  =   ?5  -   ?5  (    6  +   )6  7   U6  2   ?6  &   ?6  )   ?6  $   7  (   67     _7     z7  2   ?7  Q   ?7  4   8     G8  /   d8     ?8  +   ?8  9   ?8     9  3   .9     b9  *   u9  /   ?9  #   ?9     ?9  
   ?9     :     :  9   -:  B   g:  B   ?:  	   ?:  ,   ?:     $;  4   1;     f;     h;     l;     n;            r   X   j              M   A   K   V   {           "   (   ?       )       =   O   T   ,          v      U               >   &   J   !           g             p   	       7          [           Y   x       Z         ;   /   a       E           B   q   2              D   c   P   t   z       '       w   5       R   4   #   1      n   N   :   y   Q   $   .                 u               3       <          o   W                +   S   G   L   %      ^   ]   9           b   6   s   f   I                   m   _      \   `          -   l           0   h       i   k   H   F       *       
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
POT-Creation-Date: 2005-01-06 12:37+0100
PO-Revision-Date: 2005-01-06 12:39+0100
Last-Translator: Dennis Bj?rklund <db@zigo.dhs.org>
Language-Team: Swedish <sv@li.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
 
Som standard s? skapas en databas med samma namn som det aktuella anv?ndarnamnet.
 
Anslutningsflaggor:
 
Om n?gon av -a, -A, -d, -D, resp. ANV?NDARNAMN inte angivits s?
kommer du att f? fr?gor om dem vid k?rning.
 
Flaggor:
 
L?s beskrivningen av SQL-kommandot CLUSTER f?r detaljer.
 
L?s beskrivningen p? SQL-kommandot VACUUM f?r detaljer.
 
Rapportera buggar till <pgsql-bugs@postgresql.org>.
   %s [FLAGGA]... DBNAMN
   %s [FLAGGA]... SPR?K [DBNAMN]
   %s [FLAGGA]... [DBNAMN]
   %s [FLAGGA]... [DBNAMN] [BESKRIVNING]
   %s [FLAGGA]... [ANV?NDARNAMN]
   --help                          visa denna hj?lp, avsluta sedan
   --help                       visa denna hj?lp, avsluta sedan
   --help                    visa denna hj?lpen, avsluta sedan
   --version                       visa versionsinformation, avsluta sedan
   --version                    visa versionsinformation, avsluta sedan
   --version                 visa versionsinformation, avsluta sedan
   -A, --no-adduser          anv?ndare kan inte l?gga till nya anv?ndare
   -D, --no-createdb         anv?ndare kan inte skapa nya databaser
   -D, --tablespace=TABLESPACE  standardtabellutrymme f?r databasen
   -E, --encoding=ENCODING      teckenkodning f?r databasen
   -E, --encrypted           spara l?senordet krypterat
   -L, --pglib=KATALOG       hitta spr?kinterpretator i KATALOG
   -N, --unencrypted         spara l?senordet okrypterat
   -O, --owner=?GARE            databasanv?ndare som blir ?gare till databasen
   -P, --pwprompt            s?tt ett l?senord p? den nya anv?ndaren
   -T, --template=MALL          databasmall att kopiera fr?n
   -U, --username=ANV?NDARE     anv?ndarnamn att koppla upp som
   -U, --username=ANV?NDARE  anv?ndarnamn att koppla upp som
   -U, --username=ANV?NDARNAMN
                            anv?ndarnamn att koppla upp som
                            (inte den som skall skapas)
   -U, --username=USERNAMN   anv?ndare att koppla upp som
                            (inte den som tas bort)
   -W, --password               fr?ga efter l?senord
   -W, --password            fr?ga efter l?senord
   -W, --password            fr?ga efter l?senord f?r att koppla upp
   -a, --adduser             anv?ndare kan l?gga till nya anv?ndare
   -a, --all                       k?r vacuum p? alla databaser
   -a, --all                 klustra alla databaser
   -d, --createdb            anv?ndare kan skapa nya databaser
   -d, --dbname=DBNAMN             databas att k?ra vacuum p?
   -d, --dbname=DBNAMN       databasen som vi skall ta bort spr?ket fr?n
   -d, --dbname=DBNAME       databas att klustra
   -d, --dbname=DBNAMN       databas att installera spr?k i
   -e, --echo                      visa kommandon som skickas till servern
   -e, --echo                   visa kommandon som skickas till servern
   -e, --echo                visa kommandon som skickas till servern
   -f, --full                      k?r full vacuum
   -h, --host=V?RDNAMN          databasens v?rdnamn eller uttag(socket)-katalog
   -h, --host=V?RDNAMN       databasens v?rdnamn eller uttag(socket)-katalog
   -i, --interactive         fr?ga innan n?got tas bort
   -i, --sysid=SYSID         v?lj system-id f?r nya anv?ndaren
   -l, --list                lista spr?k som ?r installerade nu
   -p, --port=PORT              databasens serverport
   -p, --port=PORT           databasens serverport
   -q, --quiet                     skriv inte ut n?gra meddelanden
   -q, --quiet                  skriv inte ut n?gra meddelanden
   -q, --quiet               skriv inte ut n?gra meddelanden
   -t, --table='TABELL[(KOLUMNER)]'
                                 k?r vakum enbart p? specifik tabell
   -t, --table=TABLE         klustra enbart specifik tabell
   -v, --verbose                   skriv massor med utdata
   -z, --analyze                   updatera optimeringsstatistik
 %s st?dar upp och analyserar en PostgreSQL-databas.

 %s klustrar alla tidigare klustrade tabeller i en database.

 %s skapar en PostgreSQL-databas.

 %s skapar en ny PostgreSQL-anv?ndare.

 %s installerar ett procedurspr?k i en PostgreSQL-databas.

 %s tar bort en PostgreSQL-databas.

 %s tar bort en PostgreSQL-anv?ndare.

 %s tar bort ett procedurspr?k fr?n en databas.

 %s: "%s" ?r inte ett giltigt kodningsnamn
 %s: kan inte klustra en specifik tabell i alla databaser
 %s: kan inte klustra alla databaser och en specifik p? en g?ng
 %s: kan inte k?ra vacuum p? en specifik tabell i alla databaser
 %s: kan inte k?ra vacuum p? alla tabeller och en specifik p? en g?ng
 %s: klustring av databas "%s"
 %s: klustring av databas "%s" misslyckades: %s %s: klustring av tabell "%s" i databas "%s" misslyckades: %s %s: skapande av kommentar misslyckades (databasen skapades): %s %s: kunde inte koppla upp mot databas %s
 %s: kunde inte koppla upp mot databas %s: %s %s: kunde inte ta reda p? det aktuella anv?ndarnamnet: %s
 %s: kunde inte f? information om den aktuella anv?ndaren: %s
 %s: skapande av ny anv?ndare misslyckades: %s %s: skapande av databas misslyckades: %s %s: borttagning av databas misslyckades: %s %s: spr?ket "%s" ?r redan installerat i databasen "%s"
 %s: spr?k "%s" ?r inte installerat i databas "%s"
 %s: spr?kinstallation misslyckades: %s %s: borttagning av spr?k misslyckades: %s %s: saknar databasnamn vilket kr?vs
 %s: saknar spr?knamnsargument som kr?vs
 %s: fr?ga misslyckades: %s %s: fr?ga var: %s
 %s: borttagning av anv?ndare "%s" misslyckades: %s %s: fortfarande %s funktioner deklarerade i spr?ket "%s"; spr?ket inte borttaget
 %s: f?r m?nga kommandoradsargument (f?rsta ?r "%s")
 %s: st?djer inte spr?k "%s"
 %s: anv?ndar-ID m?ste vara ett positivt nummer
 %s: k?r vacuum p? databas "%s"
 %s: vacuum av databas "%s" misslyckades: %s %s: vaccum p? tabell "%s" i databas "%s" misslyckades: %s ?r du s?ker? (j/n)  Databasen "%s" kommer att bli permanent borttagen.
 Mata in det igen:  Mata in namn p? anv?ndare att l?gga till:  Mata in namn p? anv?ndaren som skall tas bort:  Mata in l?senord f?r ny anv?ndare:  Namn L?senord:  L?senorden matchade inte.
 Procedurspr?k Skall den nya anv?ndaren till?tas skapa databaser? (j/n)  Skall den nya anv?ndaren till?tas skapa fler nya anv?ndare? (j/n)  Spr?k som st?ds ?r plpgsql, pltcl, plperl, plperlu och plpythonu.
 Litas p?? F?rs?k med "%s --help" f?r mer information.
 Anv?ndning:
 Anv?ndaren "%s" kommer ett bli permanent borttagen.
 n nej j ja 