??    c      4  ?   L      p      q     ?  &   ?     ?     ?  -   
	     8	     N	  r   k	     ?	  F   ?	  A   E
     ?
  7   ?
  !   ?
  3   ?
  ?   0  ?   p  H   ?  D   ?  E   >  ?   ?  B   ?  <     ?   D  0   ?  F   ?  8   =  2   v  O   ?  7   ?     1     8  ?   A  !   ?  :   ?  I   /  y   y  =   ?  >   1  ;   p  *   ?  1   ?  %   	  /   /  #   _     ?  3   ?  0   ?  ,     .   3  7   b  1   ?  0   ?  5   ?  "   3     V  $   m  ,   ?  J   ?     
  7   &  0   ^     ?  "   ?  %   ?  $   ?        4   1  %   f  $   ?  "   ?  F   ?  F        b  )   z  s   ?  h     &   ?     ?  &   ?  0   ?  )     "   2      U  (   v     ?  !   ?     ?     ?          &     ;     O     d     x  &   ?  "   ?  W  ?  *   6     a  (   u  "   ?  %   ?  0   ?       (   2  o   [     ?  H   ?  A   4     v  8   ?     ?  4   ?  C     G   b  r   ?  w      ~   ?   N   !  F   c!  A   ?!  ?   ?!  5   {"  J   ?"  K   ?"  8   H#  h   ?#  I   ?#     4$     <$  ?   D$  %   ?$  I   %  V   g%  ?   ?%  K   S&  L   ?&  J   ?&  .   7'  5   f'  0   ?'  :   ?'  ,   (  $   5(  >   Z(  -   ?(  1   ?(  /   ?(  F   ))  ?   p)  <   ?)  @   ?)  ,   .*     [*  -   z*  /   ?*  O   ?*     (+  K   H+  >   ?+     ?+     ?+  ,   ,  (   3,  +   \,  D   ?,  )   ?,  '   ?,  '   -  O   G-  C   ?-     ?-  1   ?-  s   -.  n   ?.  .   /     ?/  /   H/  3   x/  .   ?/  '   ?/  *   0  /   .0     ^0  (   ~0     ?0     ?0     ?0  %   ?0      1     51     M1  &   b1  &   ?1  %   ?1     J       `       )   C      9   Z   2       8      *       V   	   H   7      A          3   E                  c       _                      ]   F   -       ^         #      .          0          P              !   [          U   B   G   X       4       %   N           &   =         ;              @   +       I      ?       a   L   K           6       b   <             Q   >      R       O            Y   1   "      \       :       S   ,   $   (       W   T       5   
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
 waiting for postmaster to shut down... waiting for postmaster to start... Project-Id-Version: pg_ctl 8.0
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2005-09-27 23:02-0400
PO-Revision-Date: 2004-11-02 23:45-0400
Last-Translator: alvherre <alvherre@dcc.uchile.cl>
Language-Team: PgSQL-es-Ayuda <pgsql-es-ayuda@postgresql.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
 
Nombres de se?ales permitidos para kill:
 
Opciones comunes:
 
Opciones para registrar y dar de baja:
 
Opciones para inicio y reinicio:
 
Opciones para detenci?n y reinicio:
 
Reporte errores a <pgsql-bugs@postgresql.org>.
 
Modos de detenci?n son:
   %s kill    NOMBRE-SE?AL ID-DE-PROCESO
   %s register   [-N SERVICIO] [-U USUARIO] [-P PASSWORD] [-D DATADIR]
                    [-w] [-o ?OPCIONES?]
   %s reload  [-D DATADIR] [-s]
   %s restart [-w] [-D DATADIR] [-s] [-m MODO-DETENCI?N] [-o ?OPCIONES?]
   %s start   [-w] [-D DATADIR] [-s] [-l ARCHIVO] [-o ?OPCIONES?]
   %s status  [-D DATADIR]
   %s stop    [-W] [-D DATADIR] [-s] [-m MODO-DETENCI?N]
   %s unregister [-N SERVICIO]
   --help                 mostrar este texto y salir
   --version              mostrar informaci?n sobre versi?n y salir
   -D, --pgdata DATADIR   ubicaci?n del ?rea de almacenamiento de datos
   -N SERVICIO            nombre de servicio con el cual registrar
                         el servidor PostgreSQL
   -P CONTRASE?A          contrase?a de la cuenta con la cual registrar
                         el servidor PostgreSQL
   -U USUARIO             nombre de usuario de la cuenta con la cual
                         registrar el servidor PostgreSQL
   -W                     no esperar hasta que la operaci?n se haya completado
   -l  --log ARCHIVO      guardar el registro del servidor en ARCHIVO.
   -m MODO-DE-DETENCI?N   puede ser ?smart?, ?fast? o ?immediate?
   -o OPCIONES            par?metros de l?nea de ?rdenes a pasar a postmaster
                         (ejecutable del servidor de PostgreSQL)
   -p RUTA-A-POSTMASTER   normalmente no es necesario
   -s, --silent           mostrar s?lo errores, no mensajes de informaci?n
   -w                     esperar hasta que la operaci?n se haya completado
   fast        salir directamente, con apagado apropiado
   immediate   salir sin apagado completo; se ejecutar? recuperaci?n
              en el pr?ximo inicio

   smart       salir despu?s que todos los clientes se hayan desconectado
  listo
  fall?
 %s es un programa para iniciar, detener, reiniciar, recargar archivos de
configuraci?n, reportar el estado de un servidor PostgreSQL o enviar una
se?al a un proceso PostgreSQL.

 %s: el archivo de PID ?%s? no existe
 %s: un proceso servidor aut?nomo ?postgres? est? en ejecuci?n (PID: %ld)
 %s: otro postmaster puede estar en ejecuci?n;
tratando de ejecutarlo de todas formas.
 %s: no puede ser ejecutado como root
Por favor con?ctese (por ej. usando ?su?) con un usuario no privilegiado,
quien ejecutar? el proceso servidor.
 %s: no se puede recargar postmaster; postgres est? en ejecuci?n (PID: %ld)
 %s: no se puede reiniciar postmaster, postgres est? en ejecuci?n (PID: %ld)
 %s: no se puede detener postmaster, postgres est? en ejecuci?n (PID: %ld)
 %s: no se pudo encontrar el propio ejecutable
 %s: no se pudo encontrar el ejecutable de postmaster
 %s: no se pudo abrir el archivo de PID ?%s?: %s
 %s: no se pudo abrir el servicio ?%s?: c?digo de error %d
 %s: no se pudo abrir el gestor de servicios
 %s: no se pudo leer el archivo ?%s?
 %s: no se pudo registrar el servicio ?%s?: c?digo de error %d
 %s: la se?al de recarga fall? (PID: %ld): %s
 %s: no se pudo enviar la se?al %d (PID: %ld): %s
 %s: fall? la se?al de detenci?n (PID: %ld): %s
 %s: no se pudo ejecutar postmaster.
Examine el registro del servidor.
 %s: no se pudo iniciar postmaster: el c?digo de retorno fue %d
 %s: no se pudo iniciar el servicio ?%s?: c?digo de error %d
 %s: no se pudo dar de baja el servicio ?%s?: c?digo de error %d
 %s: datos no v?lidos en archivo de PID ?%s?
 %s: la opci?n %s no es v?lida
 %s: argumentos faltantes para env?o de se?al
 %s: postmaster o postgres no est? en ejecuci?n
 %s: no se especific? directorio de datos y la variable PGDATA no est? definida
 %s: no se especific? operaci?n
 %s: el anterior proceso de postmaster (PID: %ld) parece haber desaparecido
 %s: archivo de opciones ?%s? debe tener exactamente una l?nea
 %s: memoria agotada
 %s: postmaster no se detiene
 %s: postmaster est? en ejecuci?n (PID: %ld)
 %s: el servicio ?%s? ya est? registrado
 %s: el servicio ?%s? no ha sido registrado
 %s: demasiados argumentos de l?nea de comandos (el primero es ?%s?)
 %s: modo de operaci?n ?%s? no reconocido
 %s: modo de apagado ?%s? no reconocido
 %s: nombre de se?al ?%s? no reconocido
 (Por omisi?n se espera para las detenciones, pero no los inicios o reinicios)

 Si la opci?n -D es omitida, se usa la variable de ambiente PGDATA.
 ?Est? postmaster en ejecuci?n?
 Por favor termine postgres e intente nuevamente.
 %s necesita el programa ?postmaster?, pero no se encontr?
en el mismo directorio que %s.
Verifique su instalaci?n.
 %s encontr? el programa ?postmaster? pero no corresponde
a la misma versi?n que %s.
Verifique su instalaci?n.
 Use ?%s --help? para obtener m?s informaci?n.
 Empleo:
 el proceso hijo termin? con c?digo de salida %d el proceso hijo termin? con c?digo no reconocido %d el proceso hijo fue terminado por una se?al %d no se pudo cambiar el directorio a ?%s? no se pudo encontrar un ?%s? para ejecutar no se pudo identificar el directorio actual: %s no se pudo leer el binario ?%s? no se pudo leer el enlace simb?lico ?%s? no se pudo iniciar postmaster
 el binario %s no es v?lida postmaster deteni?ndose
 se ha enviado una se?al a postmaster
 postmaster iniciado
 postmaster inici?ndose
 postmaster detenido
 iniciando postmaster de todas maneras
 esperando que postmaster se detenga... esperando que postmaster se inicie... 