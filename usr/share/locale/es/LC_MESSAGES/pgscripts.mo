??    {      ?  ?   ?      h
  K   i
     ?
  ^   ?
  
   *  >   5  =   t  -   ?     ?  #   ?       (   8     a  <   ~  9   ?  6   ?  H   ,  E   u  B   ?  6   ?  9   5  C   o  9   ?  4   ?  H   "  ;   k  E   ?  :   ?  9   (  7   b  4   ?  L   ?  J     3   g  0   ?  ;   ?  3     7   <  2   t  :   ?  5   ?  G     0   `  <   ?  M   ?  J     G   g  4   ?  H   ?  E   -  <   s  6   ?  I   ?  4   1  1   f  ;   ?  8   ?  5     =   C  8   ?  8   ?  9   ?  /   -  <   ]  #   ?  #   ?  ?   ?  #   "     F  3   f  &   ?  5   ?  E   ?  4   =  D   r     ?  *   ?  8      6   9  %   p  (   ?  (   ?  8   ?  #   !      E     f  8   ?  4   ?  $   ?       ,   9  ,   f     ?     ?  #   ?  G   ?  4   '     \  &   {     ?  )   ?  7   ?     !  +   6     b     s     ?     ?     ?  
   ?     ?     ?  9      >   B   P   ?      ?   &   ?      !  '   
!     2!     4!     7!     9!  \  =!  ]   ?"     ?"  P   #     a#  N   m#  M   ?#  0   
$     ;$  *   [$  !   ?$  (   ?$     ?$  7   ?$  7   %%  9   ]%  A   ?%  A   ?%  E   &  E   a&  E   ?&  G   ?&  ]   5'  =   ?'  K   ?'  ?   (  G   ](  D   ?(  :   ?(  ?   %)  ?   e)  y   ?)  }   *  4   ?*  4   ?*  =   +  B   E+  <   ?+  ?   ?+  B   ,  4   H,  s   },  6   ?,  F   (-  F   o-  F   ?-  J   ?-  /   H.  H   x.  H   ?.  8   
/  @   C/  H   ?/  0   ?/  0   ?/  2   /0  2   b0  7   ?0  U   ?0  6   #1  C   Z1  8   ?1  ;   ?1  L   2  '   `2  )   ?2  D   ?2  -   ?2  &   %3  9   L3  0   ?3  K   ?3  a   4  K   e4  _   ?4  &   5  8   85  I   q5  F   ?5  .   6  1   16  7   c6  ?   ?6  +   ?6  -   7  0   57  @   f7  @   ?7  )   ?7  )   8  /   <8  *   l8     ?8     ?8  -   ?8  Z   ?8  /   S9     ?9  1   ?9  $   ?9  2   ?9  C   -:     q:  6   ?:     ?:  )   ?:  *   ?:  -   );     W;     ^;  )   k;     ?;  C   ?;  B   ?;  S   3<  
   ?<  (   ?<     ?<  0   ?<     ?<     ?<     ?<     ?<            r   X   j              M   A   K   V   {           "   (   ?       )       =   O   T   ,          v      U               >   &   J   !           g             p   	       7          [           Y   x       Z         ;   /   a       E           B   q   2              D   c   P   t   z       '       w   5       R   4   #   1      n   N   :   y   Q   $   .                 u               3       <          o   W                +   S   G   L   %      ^   ]   9           b   6   s   f   I                   m   _      \   `          -   l           0   h       i   k   H   F       *       
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
 n no y yes Project-Id-Version: pgscripts 8.0
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2005-09-27 23:01-0400
PO-Revision-Date: 2003-10-05 20:10-0400
Last-Translator: Alvaro Herrera <alvherre@dcc.uchile.cl>
Language-Team: Castellano <pgsql-es-ayuda@postgresql.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
 
Si no se especifica, se crear? una base de datos con el mismo nombre que
el usuario actual.
 
Opciones de conexi?n:
 
Si no se especifican -a, -A, -d, -D y USUARIO, se preguntar?
interactivamente.
 
Opciones:
 
Lea la descripci?n del comando CLUSTER de SQL para obtener mayores detalles.
 
Lea la descripci?n del comando VACUUM de SQL para obtener mayores detalles.
 
Reporte errores a <pgsql-bugs@postgresql.org>.
   %s [OPCI?N]... BASE-DE-DATOS
   %s [OPCI?N]... LENGUAJE [BASE-DE-DATOS]
   %s [OPCI?N]... [BASE-DE-DATOS]
   %s [OPCI?N]... [NOMBRE] [DESCRIPCI?N]
   %s [OPCI?N]... [USUARIO]
   --help                    mostrar esta ayuda y salir
   --help                    mostrar esta ayuda y salir
   --help                    desplegar esta ayuda y salir
   --version                 mostrar el n?mero de versi?n y salir
   --version                 mostrar el n?mero de versi?n y salir
   --version                 desplegar informaci?n de versi?n y salir
   -A, --no-adduser          el usuario no podr? crear otros usuarios
   -D, --no-createdb         el usuario no podr? crear bases de datos
   -D, --tablespace=TBLSPC   tablespace por omisi?n de la base de datos
   -E, --encoding=CODIFICACI?N
                            codificaci?n para la base de datos
   -E, --encrypted           almacenar la constrase?a cifrada
   -L, --pglib=DIRECTORIO    buscar el archivo del int?rprete en DIRECTORIO
   -N, --unencrypted         almacenar la contrase?a sin cifrar
   -O, --owner=DUE?O         usuario que ser? due?o de la base de datos
   -P, --pwprompt            asignar una contrase?a al nuevo usuario
   -T, --template=PATR?N     base de datos patr?n a copiar
   -U, --username=USUARIO    nombre de usuario para la conexi?n
   -U, --username=USUARIO    nombre de usuario para la conexi?n
   -U, --username=NOMBRE     nombre de usuario con el cual conectarse
                            (no el usuario a crear)
   -U, --username=USUARIO    nombre del usuario con el cual conectarse
                            (no el usuario a eliminar)
   -W, --password            preguntar la contrase?a
   -W, --password            preguntar la contrase?a
   -W, --password            pedir contrase?a para conectarse
   -a, --adduser             el usuario podr? crear otros usuarios
   -a, --all                 limpia todas las bases de datos
   -a, --all                 reordenar todas las bases de datos
   -d, --createdb            el usuario podr? crear bases de datos
   -d, --dbname=BASE         base de datos a limpiar
   -d, --dbname=BASE         nombre de la base de datos de la cual
                            eliminar el lenguaje
   -d, --dbname=BASE         base de datos a reordenar
   -d, --dbname=BASE         base de datos en que instalar el lenguaje
   -e, --echo                mostrar los comandos enviados al servidor
   -e, --echo                mostrar los comandos enviados al servidor
   -e, --echo                mostrar los comandos a medida que se ejecutan
   -f, --full                usar ?vacuum full?
   -h, --host=ANFITRI?N      nombre del servidor o directorio del socket
   -h, --host=ANFITRI?N      nombre del servidor o directorio del socket
   -i, --interactive         preguntar antes de eliminar
   -i, --sysid=SYSID         escoger un ID para el nuevo usuario
   -l, --list                listar los lenguajes instalados actualmente
   -p, --port=PUERTO         puerto del servidor
   -p, --port=PUERTO         puerto del servidor
   -q, --quiet               no desplegar mensajes
   -q, --quiet               no desplegar mensajes
   -q, --quiet               no escribir ning?n mensaje
   -t, --table='TABLE[(COLUMNS)]'
                            limpiar s?lo esta tabla
   -t, --table=TABLA         reordenar s?lo esta tabla
   -v, --verbose             desplegar varios mensajes informativos
   -z, --analyze             actualizar las estad?sticas
 %s limpia (VACUUM) y analiza una base de datos PostgreSQL.
 %s reordena todas las tablas previamente reordenadas
en una base de datos.

 %s crea una base de datos PostgreSQL.

 %s crea un nuevo usuario de PostgreSQL.

 %s instala un lenguaje procedural en una base de datos PostgreSQL.

 %s elimina una base de datos de PostgreSQL.

 %s elimina un usuario de PostgreSQL.

 %s elimina un lenguaje procedural de una base de datos.

 %s: ?%s? no es un nombre de codificaci?n v?lido
 %s: no se puede reordenar una tabla espec?fica en todas
las bases de datos
 %s: no se pueden reordenar todas las bases de datos y una de ellas
en particular simult?neamente
 %s: no se puede limpiar a una tabla espec?fica en todas
las bases de datos
 %s: no se pueden limpiar todas las bases de datos y una de ellas
en particular simult?neamente
 %s: reordenando la base de datos ?%s?
 %s: fall? el reordenamiento de la base de datos ?%s?:
%s %s: fall? el reordenamiento de la tabla ?%s? en
la base de datos ?%s?:
%s %s: fall? la creaci?n del comentario (la base de datos fue creada):
%s %s: no se pudo conectar a la base de datos %s
 %s: no se pudo conectar a la base de datos %s: %s %s: no se pudo obtener el nombre de usuario actual: %s
 %s: no se pudo obtener informaci?n sobre el usuario actual: %s
 %s: fall? la creaci?n del nuevo usuario:
%s %s: fall? la creaci?n de la base de datos:
%s %s: fall? la eliminaci?n de la base de datos: %s %s: el lenguaje ?%s? ya est? instalado en la base de datos ?%s?
 %s: el lenguaje ?%s? no est? instalado en la base de datos ?%s?
 %s: fall? la instalaci?n del lenguaje:
%s %s: fall? la eliminaci?n del lenguaje: %s %s: falta el nombre de base de datos requerido
 %s: falta el nombre de lenguaje requerido
 %s: la consulta fall?: %s %s: la consulta era: %s
 %s: fall? la eliminaci?n del usuario ?%s?:
%s %s: a?n hay %s funciones declaradas en el lenguaje ?%s?;
el lenguaje no ha sido eliminado
 %s: demasiados argumentos (el primero es ?%s?)
 %s: lenguaje no soportado ?%s?
 %s: el ID de usuario debe ser un n?mero positivo
 %s: limpiando la base de datos ?%s?
 %s: fall? la limpieza de la base de datos ?%s?:
%s %s: fall? la limpieza de la tabla ?%s? en la base de datos ?%s?:
%s ?Est? seguro? (s/n)  La base de datos ?%s? ser? eliminada permanentemente.
 Ingr?sela nuevamente:  Ingrese el nombre del usuario a agregar:  Ingrese el nombre del usuario a eliminar:  Ingrese la contrase?a para el nuevo usuario:  Nombre Contrase?a:  Las contrase?as ingresadas no coinciden.
 Lenguajes Procedurales ?Debe permit?rsele al usuario la creaci?n de bases de datos? (s/n)  ?Debe permit?rsele al usuario la creaci?n de otros usuario? (s/n)  Los lenguajes soportados son plpgsql, pltcl, pltclu, plperl, plperlu, y plpythonu.
 Confiable? Use ?%s --help? para mayor informaci?n.
 Empleo:
 El usuario ?%s? ser? eliminado permanentemente.
 n no s s? 