??    c      4  ?   L      p      q     ?  &   ?     ?     ?  -   
	     8	     N	  r   k	     ?	  F   ?	  A   E
     ?
  7   ?
  !   ?
  3   ?
  ?   0  ?   p  H   ?  D   ?  E   >  ?   ?  B   ?  <     ?   D  0   ?  F   ?  8   =  2   v  O   ?  7   ?     1     8  ?   A  !   ?  :   ?  I   /  y   y  =   ?  >   1  ;   p  *   ?  1   ?  %   	  /   /  #   _     ?  3   ?  0   ?  ,     .   3  7   b  1   ?  0   ?  5   ?  "   3     V  $   m  ,   ?  J   ?     
  7   &  0   ^     ?  "   ?  %   ?  $   ?        4   1  %   f  $   ?  "   ?  F   ?  F        b  )   z  s   ?  h     &   ?     ?  &   ?  0   ?  )     "   2      U  (   v     ?  !   ?     ?     ?          &     ;     O     d     x  &   ?  "   ?  ?  ?  %   e     ?  &   ?  !   ?  '   ?  -        ;     X  o   u      ?  J     @   Q     ?  <   ?  "   ?  1     @   @  L   ?  M   ?  E      F   b   G   ?   M   ?   A   ?!  ?   ?!  <   "  K   K"  C   ?"  ;   ?"  \   #  =   t#     ?#     ?#  ?   ?#  )   l$  6   ?$  V   ?$  ?   $%  G   ?%  G   ?%  C   G&  +   ?&  8   ?&  1   ?&  3   "'  *   V'     ?'  7   ?'  5   ?'  ,   (  3   ;(  <   o(  :   ?(  5   ?(  :   )  /   X)     ?)  &   ?)  6   ?)  c   ?)  "   a*  ?   ?*  9   ?*     ?*     +  *   ,+  $   W+  %   |+  <   ?+  '   ?+  +   ,  $   3,  G   X,  F   ?,     ?,  1   -  y   8-  n   ?-  .   !.     P.  .   V.  2   ?.  *   ?.  "   ?.  )   /  (   0/     Y/      u/     ?/     ?/      ?/     ?/     0     0     00  !   C0  "   e0  !   ?0     J       `       )   C      9   Z   2       8      *       V   	   H   7      A          3   E                  c       _                      ]   F   -       ^         #      .          0          P              !   [          U   B   G   X       4       %   N           &   =         ;              @   +       I      ?       a   L   K           6       b   <             Q   >      R       O            Y   1   "      \       :       S   ,   $   (       W   T       5   
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
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2005-05-08 21:42-0300
PO-Revision-Date: 2004-10-27 18:36-0300
Last-Translator: Euler Taveira de Oliveira <eulerto@yahoo.com.br>
Language-Team: Brazilian Portuguese <desenvolvimento-postgresql@listas.postgresql.org.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
 
Sinais permitidos para sinaliza??o:
 
Op??es comuns:
 
Op??es para registro ou desregistro:
 
Op??es para in?cio ou rein?cio:
 
Op??es para desligamento ou rein?cio:
 
Relate erros a <pgsql-bugs@postgresql.org>.
 
Modos de desligamento s?o:
   %s kill    NOME_SINAL PID
   %s register   [-N NOME_SERVI?O] [-U USU?RIO] [-P SENHA] [-D DIRDADOS]
                    [-w] [-o "OP??ES"]
   %s reload  [-D DIRDADOS] [-s]
   %s restart [-w] [-D DIRDADOS] [-s] [-m MODO-DESLIGAMENTO] [-o "OP??ES"]
   %s start   [-w] [-D DIRDADOS] [-s] [-l ARQUIVO] [-o "OP??ES"]
   %s status  [-D DIRDADOS]
   %s stop    [-W] [-D DIRDADOS] [-s] [-m MODO-DESLIGAMENTO]
   %s unregister [-N NOME_SERVI?O]
   --help                 mostra esta ajuda e sai
   --version              mostra informa??o sobre a vers?o e sai
   -D, --pgdata DIRDADOS  local da ?rea de armazenamento dos bancos de dados
   -N NOME_SERVI?O nome do servi?o no qual se registrou o servidor PostgreSQL
   -P SENHA        senha da conta que registrou o servidor PostgreSQL
   -U USU?RIO      nome do usu?rio que registrou o servidor PostgreSQL
   -W                     n?o espera at? que a opera??o seja completada
   -l, --log ARQUIVO      escreve (ou concatena) log do servidor para ARQUIVO
   -m MODO-DESLIGAMENTO   pode ser "smart", "fast" ou "immediate"
   -o OP??ES              op??es de linha de comando passadas para o postmaster
                         (execut?vel do servidor PostgreSQL)
   -p CAMINHO-PARA-POSTMASTER   normalmente n?o ? necess?rio
   -s, --silent           exibe somente erros, nenhuma mensagem informativa
   -w                     espera at? que a opera??o seja completada
   fast        sai diretamente, com desligamento apropriado
   immediate   sai sem desligamento completo; conduzir? a uma recupera??o durante o rein?cio
   smart       sai depois que todos os clientes desconectarem
 feito
 falhou
 %s ? um utilit?rio que inicia, para, reinicia, recarrega arquivos de configura??o,
relata o estado do servidor PostgreSQL ou envia um sinal a um processo do PostgreSQL.

 %s: arquivo contendo PID "%s" n?o existe
 %s: um "postgres" aut?nomo est? executando (PID: %ld)
 %s: outro postmaster pode estar executando; tentando iniciar o postmaster assim mesmo
 %s: n?o pode ser executado como root
Por favor entre (utilizando "su") como um usu?rio (sem privil?gios) que
ser? o dono do processo do servidor.
 %s: n?o pode reiniciar postmaster; postgres est? executando (PID: %ld)
 %s: n?o pode reiniciar postmaster; postgres est? executando (PID: %ld)
 %s: n?o pode parar postmaster; postgres est? executando (PID: %ld)
 %s: n?o p?de encontrar programa execut?vel
 %s: n?o p?de encontrar o programa execut?vel postmaster
 %s: n?o p?de abrir arquivo contendo PID "%s": %s
 %s: n?o p?de abrir servi?o "%s": c?digo de erro %d
 %s: n?o p?de abrir gerenciador de servi?o
 %s: n?o p?de ler arquivo "%s"
 %s: n?o p?de registrar servi?o "%s": c?digo de erro %d
 %s: n?o p?de enviar sinal de rein?cio (PID: %ld): %s
 %s: n?o p?de enviar sinal %d (PID: %ld): %s
 %s: n?o p?de enviar sinal de parada (PID: %ld): %s
 %s: n?o pode iniciar o postmaster
Examine o arquivo de log.
 %s: n?o p?de iniciar o postmaster: c?digo de sa?da foi %d
 %s: n?o p?de iniciar servi?o "%s": c?digo de erro %d
 %s: n?o p?de desregistrar servi?o "%s": c?digo de erro %d
 %s: dado inv?lido no arquivo contendo PID "%s"
 %s: op??o inv?lida %s
 %s: faltando argumento para modo kill
 %s: nem o postmaster e nem o postgres est? executando
 %s: nenhum diret?rio de banco de dados especificado e vari?vel de ambiente PGDATA n?o foi definida
 %s: nenhuma opera??o especificada
 %s: processo postmaster antigo (PID: %ld) parece ter terminado
 %s: arquivo de op??es "%s" deve ter exatamente uma linha
 %s: sem mem?ria
 %s: postmaster n?o desligou
 %s: postmaster est? executando (PID: %ld)
 %s: servi?o "%s" j? est? registrado
 %s: servi?o "%s" n?o est? registrado
 %s: muitos argumentos de linha de comando (primeiro ? "%s")
 %s: modo de opera??o "%s" desconhecido
 %s: modo de desligamento "%s" desconhecido
 %s: nome de sinal "%s" desconhecido
 (O padr?o ? esperar o desligamento, mas n?o para in?cio ou rein?cio).

 Se a op??o -D for omitida, a vari?vel de ambiente PGDATA ? utilizada.
 O postmaster est? executando?
 Por favor finalize o postgres e tente novamente.
 O programa "postmaster" ? requerido por %s mas n?o foi encontrado no
mesmo diret?rio que "%s".
Verifique sua instala??o.
 O programa "postmaster" foi encontrado pelo "%s"
mas n?o tem a mesma vers?o que %s.
Verifique sua instala??o.
 Tente "%s --help" para obter mais informa??o.
 Uso:
 processo filho terminou com c?digo de sa?da %d processo filho terminou com status desconhecido %d processo filho foi terminado pelo sinal %d n?o p?de mudar diret?rio para "%s" n?o p?de encontrar o "%s" para execut?-lo n?o p?de identificar diret?rio atual: %s n?o p?de ler o bin?rio "%s" n?o p?de ler link simb?lico "%s" n?o p?de iniciar o postmaster
 bin?rio "%s" ? inv?lido postmaster est? sendo desligado
 postmaster sinalizado
 postmaster iniciado
 postmaster iniciando
 postmaster parado
 iniciando postmaster mesmo assim
 esperando o postmaster desligar... esperando o postmaster iniciar... 