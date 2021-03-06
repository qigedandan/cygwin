??    A      $  Y   ,      ?  9   ?  -   ?  ,   ?  8   &  *   _  N   ?  0   ?  N   
     Y  *   y  +   ?     ?  !   ?  )     #   8  &   \  -   ?  !   ?  !   ?  +   ?  "   !	  (   D	     m	  J   ?	     ?	     ?	  #   
  #   /
  #   S
  #   w
  \   ?
  ,   ?
      %  @   F  D   ?  &   ?     ?  )     )   -  )   W  )   ?  )   ?  )   ?     ?  V     )   s  )   ?  )   ?  )   ?  )     )   E  )   o  )   ?  )   ?  )   ?  	     ?   !     ?  &   ?  !   ?  -         N     e  )   z  ?  ?  I   +  -   u  ,   ?  ;   ?  &     S   3  9   ?  _   ?  '   !  3   I  /   }     ?  '   ?  *   ?  %     &   C  1   j  $   ?  "   ?  $   ?  *   	  0   4     e  Q   ?  %   ?  #   ?  %   !  %   G  %   m  %   ?  x   ?  .   2  +   a  A   ?  Q   ?  (   !     J  ,   ^  )   ?  )   ?  )   ?  1   	  3   ;  !   o  l   ?  )   ?  )   (  0   R  0   ?  0   ?  3   ?  1     -   K  0   y  )   ?     ?  ?   ?     ?  .   ?     ?  ;   ?     1     L  )   e                  	   1      5   9           *   0      /   (   -         ;             ?   4   %              =      "          !          >          2   6              '      8   7      3               .       )   @   <       ,       +       #          A                 
                                       :       $   &    
If these values seem acceptable, use -f to force reset.
 
Report bugs to <pgsql-bugs@postgresql.org>.
   --help          show this help, then exit
   --version       output version information, then exit
   -f              force update to be done
   -l TLI,FILE,SEG force minimum WAL starting location for new transaction log
   -m multiXID     set next multi transaction ID
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
 %s: invalid argument for option -m
 %s: invalid argument for option -o
 %s: invalid argument for option -x
 %s: lock file "%s" exists
Is a server running?  If not, delete the lock file and try again.
 %s: multi transaction ID (-m) must not be 0
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
 Latest checkpoint's NextMultiXactId:  %u
 Latest checkpoint's NextOID:          %u
 Latest checkpoint's NextXID:          %u
 Latest checkpoint's TimeLineID:       %u
 Maximum columns in an index:          %u
 Maximum length of identifiers:        %u
 Maximum length of locale name:        %u
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
POT-Creation-Date: 2005-05-08 21:42-0300
PO-Revision-Date: 2004-10-27 18:36-0300
Last-Translator: Euler Taveira de Oliveira <eulerto@yahoo.com.br>
Language-Team: Brazilian Portuguese <desenvolvimento-postgresql@listas.postgresql.org.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
 
Se estes valores lhe parecem aceit?veis, use -f para for?ar o rein?cio.
 
Relate erros a <pgsql-bugs@postgresql.org>.
   --help            mostra esta ajuda e sai
   --version         mostra informa??o sobre a vers?o e sai
   -f                for?a atualiza??o
   -l TLI,FILE,SEG     for?a local inicial m?nimo do WAL para novo log de transa??o
   -m multiXID       define pr?ximo ID de multi-transa??o
   -n                sem atualiza??o, mostra somente valores de controle extra?dos (para teste)
   -o OID            define pr?ximo OID
   -x XID            define pr?ximo ID de transa??o
 %s reinicia o log de transa??o do PostgreSQL.

 %s: OID (-o) n?o deve ser 0
 %s: n?o pode ser executado pelo "root"
 %s: n?o p?de criar arquivo pg_control: %s
 %s: n?o p?de apagar arquivo "%s": %s
 %s: n?o p?de abrir diret?rio "%s": %s
 %s: n?o p?de abrir arquivo "%s" para leitura: %s
 %s: n?o p?de abrir arquivo "%s": %s
 %s: n?o p?de ler arquivo "%s": %s
 %s: n?o p?de ler diret?rio "%s": %s
 %s: n?o p?de escrever no arquivo "%s": %s
 %s: n?o p?de escrever no arquivo pg_control: %s
 %s: erro ao executar fsync: %s
 %s: erro interno -- sizeof(ControlFileData) ? muito grande ... conserte o xlog.c
 %s: defini??o do LC_COLLATE inv?lido
 %s: defini??o do LC_CTYPE inv?lido
 %s: argumento inv?lido para op??o -l
 %s: argumento inv?lido para op??o -m
 %s: argumento inv?lido para op??o -o
 %s: argumento inv?lido para op??o -x
 %s: arquivo de bloqueio "%s" existe
O servidor est? executando? Se n?o, apague o arquivo de bloqueio e tente novamente.
 %s: ID de multi-transa??o (-m) n?o deve ser 0
 %s: nenhum diret?rio de dados especificado
 %s: pg_control existe mas tem CRC inv?lido: prossiga com cuidado
 %s: pg_control existe mas n?o funciona ou sua vers?o ? desconhecida; ignorando-o
 %s: ID de transa??o (-x) n?o deve ser 0
 inteiros de 64 bits Blocos por segmento da rela??o grande:   %u
 N?mero da vers?o do cat?logo:         %u
 ID do arquivo de log atual:           %u
 Tamanho do bloco do banco de dados:   %u
 Identificador do sistema de banco de dados:   %s
 Tipo de data/hora do reposit?rio:               %s
 Valores supostos do pg_control:

 Se voc? tem certeza que o caminho do diret?rio de dados est? correto, execute
  touch %s
e tente novamente.
 LC_COLLATE:                           %s
 LC_CTYPE:                             %s
 ?ltimo NextMultiXactId do ponto de controle: %u
 ?ltimo NextOID do ponto de controle:         %u
 ?ltimo NextXID do ponto de controle:         %u
 ?ltimo TimeLineID do ponto de controle:         %u
 N?mero m?ximo de colunas em um ?ndice:        %u
 Tamanho m?ximo de identificadores:        %u
 Tamanho m?ximo do nome da localidade:        %u
 Pr?ximo segmento do arquivo de log:   %u
 Op??es:
 O servidor de banco de dados n?o foi desligado corretamente.
Reiniciar o log de transa??o pode causar perdas de dados.
Se voc? quer continuar, use -f para for?ar o rein?cio.
 Log de transa??o reiniciado
 Tente "%s --help" para obter mais informa??o.
 Uso:
  %s [OP??O] DIRDADOS

 Voc? deve executar %s como um super-usu?rio do PostgreSQL.
 n?meros de ponto flutuante valores do pg_control:

 n?mero da vers?o do pg_control:       %u
 