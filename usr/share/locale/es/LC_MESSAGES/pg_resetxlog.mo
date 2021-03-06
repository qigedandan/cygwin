??    =        S   ?      8  9   9  -   s  ,   ?  8   ?  *     N   2  N   ?     ?  *   ?  +        G  !   c  )   ?  #   ?  &   ?  -   ?  !   (  !   J  +   l  "   ?  (   ?     ?  J   ?     D	     d	  #   ?	  #   ?	  #   ?	  \   ?	      K
  @   l
  D   ?
  &   ?
       )   )  )   S  )   }  )   ?  )   ?  )   ?     %  V   B  )   ?  )   ?  )   ?  )     )   A  )   k  )   ?  )   ?  )   ?  	     ?        ?  &   ?  !   ?  -        J     a  )   v  Z  ?  C   ?  0   ?  9   p  J   ?  8   ?  k   .  n   ?  *   	  8   4  8   m     ?  1   ?  5   ?  .   -  0   \  :   ?  -   ?  ,   ?  0   #  3   T  6   ?     ?  T   ?  (   ,  &   U  *   |  *   ?  *   ?  t   ?  (   r  J   ?  L   ?  /   3     c  2   v  2   ?  2   ?  2     2   B  2   u  !   ?  g   ?  2   2  2   e  2   ?  2   ?  2   ?  2   1  2   d  2   ?  2   ?  
   ?  ?     %   ?  ,   ?      "  4   C     x     ?  2   ?     !   0              1   3   4          *         -                        8   7       6          2   
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
POT-Creation-Date: 2005-09-27 23:02-0400
PO-Revision-Date: 2003-10-03 15:24-0500
Last-Translator: Ivan Hernandez <ivanx@ciencias.unam.mx>
Language-Team: Espa?ol <pgsql-es-ayuda@postgresql.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
 
Si estos valores parecen aceptables, usa -f para forzar reinicio.
 
Reporta errores a <pgsql-bugs@postgresql.org>.
   --help          muestra esta ayuda y sale del programa
   --version       despliega la informaci?n de versi?n y sale del programa
   -f              fuerza que la actualizaci?n sea hecha
   -l TLI,FILE,SEG fuerza una posici?n m?nima de inicio de WAL para una
                  nueva transacci?n
   -n              no actualiza, s?lo muestra los valores de control extra?dos
                  (para prueba)
   -o OID          asigna el siguiente OID
   -x XID          asigna el siguiente ID de transacci?n
 %s reinicia la bit?cora de transacciones de PostgreSQL

 %s: OID (-o) no debe ser cero
 %s: no puede ser ejecutado con el usuario ?root?
 %s: no fue posible crear el archivo pg_control:   %s
 %s: no fue posible borrar el archivo ?%s?: %s
 %s: no fue posible abrir el directorio ?%s?: %s
 %s: no fue posible abrir el archivo ?%s? para lectura: %s
 %s: no fue posible abrir el archivo ?%s?: %s
 %s: no fue posible leer el archivo ?%s?: %s
 %s: no fue posible leer del directorio ?%s?: %s
 %s: no fue posible escribir en el archivo ?%s?: %s
 %s: no fue posible escribir el archivo pg_control: %s
 %s: Error de fsync: %s
 %s: error interno -- sizeof(ControlFileData) es demasiado grande ... corrige xlog.c
 %s: el valor de LC_COLLATE no es v?lido
 %s: el valor de LC_CTYPE no es v?lido
 %s: argumento no v?lido para la opci?n -l
 %s: argumento no v?lido para la opci?n -o
 %s: argumento no v?lido para la opci?n -x
 %s: el archivo candado ?%s? existe
?Hay un servidor corriendo? Si no, borra el archivo candado e int?ntalo de nuevo
 %s: directorio de datos no especificado
 %s: existe pg_control pero tiene un CRC no v?lido, procede con precauci?n
 %s: existe pg_control pero est? roto o se desconoce su versi?n; ignor?ndolo
 %s: el ID de transacci?n (-x) no debe ser cero
 enteros de 64 bits Bloques por segmento de relaci?n grande:       %u
 N?mero de versi?n de cat?logo:                 %u
 ID de archivo bit?cora actual:                 %u
 Tama?o del bloque de la base de datos:         %u
 Identificador de sistema:                      %s
 Tipo de almacenamiento hora/fecha:             %s
 Valores de pg_control asumidos:

 Si est?s seguro que la ruta al directorio de datos es correcta, ejecuta
   touch %s
y prueba de nuevo.
 LC_COLLATE:                                    %s
 LC_CTYPE:                                      %s
 NextOID del punto de control m?s reciente:     %u
 NextXID del punto de control m?s reciente:     %u
 TimeLineID del punto de control m?s reciente:  %u
 Longitud m?xima de identificadores:            %u
 Longitud m?xima de nombre de localizaci?n:     %u
 N?mero m?ximo de argumentos de funci?n:        %u
 Siguiente segmento de archivo bit?cora:        %u
 Opciones:
 El servidor de base de datos no fue terminado limpiamente.
Reiniciar la bit?cora de transacciones puede causar p?rdida de datos.
Si de todas formas quieres proceder, usa -f para forzar su reinicio.
 Bit?cora de transacciones reiniciada
 Prueba con ?%s --help? para m?s informaci?n
 Uso:
   %s [OPCION]... DATADIR

 Debe ejecutar %s con el superusuario de PostgreSQL.
 n?meros de punto flotante Valores de pg_control:

 N?mero de versi?n de pg_control:               %u
 