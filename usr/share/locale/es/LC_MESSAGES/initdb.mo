??    c      4  ?   L      p  R   q     ?  
   ?  -   ?  ?   	  ?   ?	     H
    d
  J   ?  5   ?  J     6   P  P   ?  C   ?  :     4   W  B   ?  H   ?  >     9   W  3   ?  ?   ?  /     -   5  E   c  y   ?  (   #  7   L  (   ?  3   ?  '   ?  5   	  -   ?  -   m  /   ?  "   ?  6   ?  ?   %  0   ?  $     ?   *  ~   ?  1   5     g  J   ?  ?   ?     ?  D   ?  -   ?  !     4   @  ,   u     ?     ?     ?     ?          )  ;   A  9   }  ?   ?  >   H  0  ?  u   ?  q   .  f   ?  &        .     6  &   E  0   l  )   ?  #   ?  "   ?        (   /     X  !   s  %   ?  !   ?     ?     ?           0     Q  -   l  2   ?  0   ?     ?          6     J     f  &   j  %   ?     ?  +   ?  !   ?  ]    V   y      ?      ?   0   ?   ?   &!  ?   ?!     f"  6  ?"  H   ?#  5   $  O   8$  7   ?$  v   ?$  P   7%  D   ?%  @   ?%  C   &  L   R&  >   ?&  :   ?&  7   '  J   Q'  7   ?'  0   ?'  O   (  ?   U(  .   ?(  <   +)  ,   h)  @   ?)  ,   ?)  V   *  6   Z*  8   ?*  7   ?*  ,   +  A   /+  ?   q+  =   /,  /   m,  ?   ?,  ?   +-  C   ?-  4   ?-  T   ..  ?   ?.     :/  e   O/  0   ?/  +   ?/  C   0  0   V0  *   ?0     ?0  .   ?0     ?0     1  "   61  ;   Y1  9   ?1  ?   ?1  @   g2  ^  ?2  ?   4  x   ?4  q   5  0   v5     ?5     ?5  /   ?5  3   ?5  .   /6  #   ^6  '   ?6  *   ?6  /   ?6     7  (   %7  (   N7  &   w7     ?7     ?7     ?7  &   ?7  "   8  1   >8  D   p8  7   ?8     ?8     
9     '9     A9     ^9  0   b9  /   ?9     ?9  6   ?9  1   :         <       D   :       1   0       8   7   2   Y      /      &   a                        U   W       	   R           ^   V           P   `   ;   c       K          "   ,             Z   %   (   )   A       T      F   \      9      J       N      +             C          5   3       #   '   Q   
                  -   *       $       .              X   b   6   [      @   E   >   !                           =               _       S   H         L   ]   M   I       ?   4                 G       B         O        
If the data directory is not specified, the environment variable PGDATA
is used.
 
Less commonly used options:
 
Options:
 
Report bugs to <pgsql-bugs@postgresql.org>.
 
Success. You can now start the database server using:

    %s%s%s%spostmaster -D %s%s%s
or
    %s%s%s%spg_ctl -D %s%s%s -l logfile start

 
WARNING: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the -A option the
next time you run initdb.
   %s [OPTION]... [DATADIR]
   --lc-collate, --lc-ctype, --lc-messages=LOCALE
  --lc-monetary, --lc-numeric, --lc-time=LOCALE
                            initialize database cluster with given locale
                            in the respective category (default taken from
                            environment)
   --locale=LOCALE           initialize database cluster with given locale
   --no-locale               equivalent to --locale=C
   --pwfile=FILE             read password for the new superuser from file
   -?, --help                show this help, then exit
   -A, --auth=METHOD         default authentication method for local connections
   -E, --encoding=ENCODING   set default encoding for new databases
   -L DIRECTORY              where to find the input files
   -U, --username=NAME       database superuser name
   -V, --version             output version information, then exit
   -W, --pwprompt            prompt for a password for the new superuser
   -d, --debug               generate lots of debugging output
   -n, --noclean             do not clean up after errors
   -s, --show                show internal settings
  [-D, --pgdata=]DATADIR     location for this database cluster
 %s initializes a PostgreSQL database cluster.

 %s: "%s" is not a valid server encoding name
 %s: The password file was not generated. Please report this problem.
 %s: cannot be run as root
Please log in (using, e.g., "su") as the (unprivileged) user that will
own the server process.
 %s: could not access directory "%s": %s
 %s: could not change permissions of directory "%s": %s
 %s: could not create directory "%s": %s
 %s: could not determine valid short version string
 %s: could not execute command "%s": %s
 %s: could not find suitable encoding for locale "%s"
 %s: could not open file "%s" for reading: %s
 %s: could not open file "%s" for writing: %s
 %s: could not read password from file "%s": %s
 %s: could not write file "%s": %s
 %s: data directory "%s" not removed at user's request
 %s: directory "%s" exists but is not empty
If you want to create a new database system, either remove or empty
the directory "%s" or run %s
with an argument other than "%s".
 %s: failed to remove contents of data directory
 %s: failed to remove data directory
 %s: file "%s" does not exist
This means you have a corrupted installation or identified
the wrong directory with the invocation option -L.
 %s: input file "%s" does not belong to PostgreSQL %s
Check your installation or specify the correct path using the option -L.
 %s: input file location must be an absolute path
 %s: invalid locale name "%s"
 %s: must specify a password for the superuser to enable %s authentication
 %s: no data directory specified
You must identify the directory where the data for this database system
will reside.  Do this with either the invocation option -D or the
environment variable PGDATA.
 %s: out of memory
 %s: password prompt and password file may not be specified together
 %s: removing contents of data directory "%s"
 %s: removing data directory "%s"
 %s: too many command-line arguments (first is "%s")
 %s: unrecognized authentication method "%s"
 %s: warning: encoding mismatch
 Enter it again:  Enter new superuser password:  Passwords didn't match.
 Rerun %s with the -E option.
 Running in debug mode.
 Running in noclean mode.  Mistakes will not be cleaned up.
 The database cluster will be initialized with locale %s.
 The database cluster will be initialized with locales
  COLLATE:  %s
  CTYPE:    %s
  MESSAGES: %s
  MONETARY: %s
  NUMERIC:  %s
  TIME:     %s
 The default database encoding has accordingly been set to %s.
 The encoding you selected (%s) and the encoding that the selected
locale uses (%s) are not known to match.  This may lead to
misbehavior in various character string processing functions.  To fix
this situation, rerun %s and either do not specify an encoding
explicitly, or choose a matching combination.
 The files belonging to this database system will be owned by user "%s".
This user must also own the server process.

 The program "postgres" is needed by %s but was not found in the
same directory as "%s".
Check your installation.
 The program "postgres" was found by "%s"
but was not the same version as %s.
Check your installation.
 Try "%s --help" for more information.
 Usage:
 caught signal
 child process exited with exit code %d child process exited with unrecognized status %d child process was terminated by signal %d copying template1 to template0 ...  could not change directory to "%s" could not find a "%s" to execute could not identify current directory: %s could not read binary "%s" could not read symbolic link "%s" could not write to child process: %s
 creating configuration files ...  creating conversions ...  creating directory %s ...  creating directory %s/%s ...  creating information schema ...  creating system views ...  creating template1 database in %s/base/1 ...  enabling unlimited row size for system tables ...  fixing permissions on existing directory %s ...  initializing pg_depend ...  initializing pg_shadow ...  invalid binary "%s" loading pg_description ...  ok
 selecting default max_connections ...  selecting default shared_buffers ...  setting password ...  setting privileges on built-in objects ...  vacuuming database template1 ...  Project-Id-Version: initdb 8.0
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2005-09-27 23:01-0400
PO-Revision-Date: 2004-09-06 16:17-0400
Last-Translator: ?lvaro Herrera <alvherre@dcc.uchile.cl>
Language-Team: PgSQL-es-Ayuda <pgsql-es-ayuda@postgresql.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
 
Si el directorio de datos no es especificado, se usa la variable de
ambiente PGDATA.
 
Opciones menos usadas:
 
Opciones:
 
Reporte errores a <pgsql-bugs@postgresql.org>.
 
Completado. Puede iniciar el servidor de bases de datos usando:

    %s%s%s%spostmaster -D %s%s%s
o
    %s%s%s%spg_ctl -D %s%s%s -l logfile start

 
ATENCI?N: activando autentificaci?n ?trust? para conexiones locales.
Puede cambiar esto editando pg_hba.conf o usando el par?metro -A
la pr?xima vez que ejecute initdb.
   %s [OPCI?N]... [DATADIR]
   --lc-collate, --lc-ctype, --lc-messages=LOCALE
  --lc-monetary, --lc-numeric, --lc-time=LOCALE
                            inicializar usando esta configuraci?n local
                            en la categor?a respectiva (el valor por omisi?n
                            es tomado de variables de ambiente)
   --locale=LOCALE           inicializar usando esta configuraci?n local
   --no-locale               equivalente a --locale=C
   --pwfile=ARCHIVO          leer contrase?a del nuevo superusuario del archivo
   -?, --help                mostrar esta ayuda y salir
   -A, --auth=METODO         m?todo de autentificaci?n por omisi?n para
                            conexiones locales
   -E, --encoding=CODIFIC    codificaci?n por omisi?n para nuevas bases de datos
   -L DIRECTORIO             donde encontrar los archivos de entrada
   -U, --username=USUARIO    nombre del superusuario del cluster
   -V, --version             mostrar informaci?n de version y salir
   -W, --pwprompt            pedir una contrase?a para el nuevo superusuario
   -d, --debug               genera mucha salida de depuraci?n
   -n, --noclean             no limpiar despu?s de errores
   -s, --show                muestra variables internas
  [-D, --pgdata=]DATADIR     ubicaci?n para este cluster de bases de datos
 %s inicializa un cluster de base de datos PostgreSQL.

 %s: ?%s? no es un nombre v?lido de codificaci?n
 %s: El archivo de contrase?a no fue generado.
Por favor reporte este problema.
 %s: no se puede ejecutar como ?root?
Por favor con?ctese (usando, por ejemplo, ?su?) como un usuario sin
privilegios especiales, quien ejecutar? el proceso servidor.
 %s: no se pudo acceder al directorio ?%s?: %s
 %s: no se pudo cambiar los permisos del directorio ?%s?: %s
 %s: no se pudo crear el directorio ?%s?: %s
 %s: no se pudo determinar una cadena corta de n?mero de versi?n
 %s: no se pudo ejecutar el comando ?%s?: %s
 %s: no se pudo encontrar una codificaci?n apropiada para
la configuraci?n local ?%s?.
 %s: no se pudo abrir el archivo ?%s? para lectura: %s
 %s: no se pudo abrir el archivo ?%s? para escritura: %s
 %s: no se pudo leer la contrase?a del archivo ?%s?: %s
 %s: no se pudo escribir el archivo ?%s?: %s
 %s: directorio de datos ?%s? no eliminado a petici?n del usuario
 %s: el directorio ?%s? ya existe pero no est? vac?o.
Si quiere crear un nuevo cluster de bases de datos, elimine o vac?e
el directorio ?%s?, o ejecute %s
con un argumento distinto de ?%s?.
 %s: no se pudo eliminar el contenido del directorio de datos
 %s: no se pudo eliminar el directorio de datos
 %s: el archivo ?%s? no existe
Esto significa que tiene una instalaci?n corrupta o ha
identificado el directorio equivocado con la opci?n -L.
 %s: el archivo de entrada ?%s? no pertenece a PostgreSQL %s
Verifique su instalaci?n o especifique la ruta correcta usando la opci?n -L.
 %s: la ubicaci?n de archivos de entrada debe ser una ruta absoluta
 %s: nombre de configuraci?n local ?%s? no es v?lido
 %s: debe especificar una contrase?a al superusuario para activar
autentificaci?n %s
 %s: no se especific? un directorio de datos.
Debe especificar el directorio donde residir?n los datos para este cluster.
H?galo usando la opci?n -D o la variable de ambiente PGDATA.
 %s: memoria agotada
 %s: la petici?n de contrase?a y el archivo de contrase?a no pueden
ser especificados simult?neamente
 %s: eliminando el contenido del directorio ?%s?
 %s: eliminando el directorio de datos ?%s?
 %s: demasiados argumentos de l?nea de ?rdenes (el primero es ?%s?)
 %s: m?todo de autentificaci?n desconocido: ?%s?
 %s: atenci?n: codificaciones no coinciden
 Ingr?sela nuevamente:  Ingrese la nueva contrase?a del superusuario:  Las constrase?as no coinciden.
 Ejecute %s con la opci?n -E.
 Ejecutando en modo de depuraci?n.
 Ejecutando en modo sucio.  Los errores no ser?n limpiados.
 El cluster ser? inicializado con configuraci?n local %s.
 El cluster ser? inicializado con las configuraciones locales
  COLLATE:  %s
  CTYPE:    %s
  MESSAGES: %s
  MONETARY: %s
  NUMERIC:  %s
  TIME:     %s
 La codificaci?n por omisi?n ha sido por lo tanto definida a %s.
 La codificaci?n que seleccion? (%s) y la codificaci?n que usa la
configuraci?n local seleccionada (%s) no coinciden.  Esto puede llevar
a comportamientos err?ticos en ciertas funciones de procesamiento de
cadenas de caracteres.  Para corregir esta situaci?n, ejecute %s y
no especifique una codificaci?n, o bien especifique una combinaci?n
adecuada.
 Los archivos de este cluster ser?n de propiedad del usuario ?%s?.
Este usuario tambi?n debe ser quien ejecute el proceso servidor.
 %s necesita el programa ?postgres?, pero no pudo encontrarlo en el mismo
directorio que ?%s?.
Verifique su instalaci?n.
 El programa ?postgres? fue encontrado por %s, pero no es
de la misma versi?n que ?%s?.
Verifique su instalaci?n.
 Use ?%s --help? para obtener mayor informaci?n.
 Empleo:
 se ha capturado una se?al
 el proceso hijo termin? con c?digo de salida %d el proceso hijo termin? con c?digo no reconocido %d el proceso hijo fue terminado por una se?al %d copiando template1 a template0 ...  no se pudo cambiar el directorio a ?%s? no se pudo encontrar un ?%s? para ejecutar no se pudo identificar el directorio actual: %s no se pudo leer el binario ?%s? no se pudo leer el enlace simb?lico ?%s? no se pudo escribir al proceso hijo: %s
 creando archivos de configuracion ...  creando conversiones ...  creando el directorio %s ...  creando directorio %s/%s ...  creando el esquema de informaci?n ...  creando las vistas de sistema ...  creando base de datos template1 en %s/base/1 ...  habilitando tama?o de registro ilimitado para tablas de sistema ...  corrigiendo permisos en el directorio existente %s ...  inicializando pg_depend ...  inicializando pg_shadow ...  binario ?%s? no es v?lido cargando pg_description ...  ok
 seleccionando el valor para max_connections ...  seleccionando el valor para shared_buffers ...  estableciendo contrase?a ...  estableciendo privilegios en objetos predefinidos ...  haciendo vacuum a la base de datos template1 ...  