??    {      ?  ?   ?      h
  K   i
     ?
  ^   ?
  
   *  >   5  =   t  -   ?     ?  #   ?       (   8     a  <   ~  9   ?  6   ?  H   ,  E   u  B   ?  6   ?  9   5  C   o  9   ?  4   ?  H   "  ;   k  E   ?  :   ?  9   (  7   b  4   ?  L   ?  J     3   g  0   ?  ;   ?  3     7   <  2   t  :   ?  5   ?  G     0   `  <   ?  M   ?  J     G   g  4   ?  H   ?  E   -  <   s  6   ?  I   ?  4   1  1   f  ;   ?  8   ?  5     =   C  8   ?  8   ?  9   ?  /   -  <   ]  #   ?  #   ?  ?   ?  #   "     F  3   f  &   ?  5   ?  E   ?  4   =  D   r     ?  *   ?  8      6   9  %   p  (   ?  (   ?  8   ?  #   !      E     f  8   ?  4   ?  $   ?       ,   9  ,   f     ?     ?  #   ?  G   ?  4   '     \  &   {     ?  )   ?  7   ?     !  +   6     b     s     ?     ?     ?  
   ?     ?     ?  9      >   B   P   ?      ?   &   ?      !  '   
!     2!     4!     7!     9!  ?  =!  E   ?"     
#  h   #  	   ?#  >   ?#  =   ?#  .   $     >$  #   W$     {$  %   ?$     ?$  :   ?$  7   %  4   I%  I   ~%  F   ?%  C   &  F   S&  I   ?&  G   ?&  A   ,'  ;   n'  U   ?'  ?    (  P   @(  >   ?(  D   ?(  =   )  =   S)  \   ?)  ^   ?)  +   M*  +   y*  7   ?*  B   ?*  ?    +  <   `+  E   ?+  @   ?+  M   $,  :   r,  C   ?,  J   ?,  G   <-  D   ?-  :   ?-  Z   .  Z   _.  :   ?.  F   ?.  E   </  @   ?/  @   ?/  =   0  ;   B0  7   ~0  G   ?0  A   ?0  :   @1  E   {1  3   ?1  G   ?1  '   =2  (   e2  C   ?2  )   ?2  %   ?2  6   "3  -   Y3  G   ?3  M   ?3  G   4  M   e4  "   ?4  1   ?4  @   5  @   I5  +   ?5  .   ?5  -   ?5  6   6  &   J6  (   q6  (   ?6  <   ?6  =    7  &   >7  #   e7  4   ?7  /   ?7     ?7     8  &   8  H   C8  >   ?8  #   ?8  .   ?8  "   9  ,   A9  ;   n9     ?9  3   ?9     ?9  +   :  )   8:  $   b:     ?:     ?:     ?:     ?:  3   ?:  3   ?:  O   -;  
   };  .   ?;     ?;  ,   ?;     ?;     ?;     ?;     ?;            r   X   j              M   A   K   V   {           "   (   ?       )       =   O   T   ,          v      U               >   &   J   !           g             p   	       7          [           Y   x       Z         ;   /   a       E           B   q   2              D   c   P   t   z       '       w   5       R   4   #   1      n   N   :   y   Q   $   .                 u               3       <          o   W                +   S   G   L   %      ^   ]   9           b   6   s   f   I                   m   _      \   `          -   l           0   h       i   k   H   F       *       
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
POT-Creation-Date: 2005-01-15 12:04-0200
PO-Revision-Date: 2004-11-13 19:30-0300
Last-Translator: Euler Taveira de Oliveira <eulerto@yahoo.com.br>
Language-Team: Brazilian Portuguese <desenvolvimento-postgresql@listas.postgresql.org.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
 
Por padr?o, um banco de dados com o mesmo nome do usu?rio ? criado.
 
Op??es de conex?o:
 
Se nenhuma das op??es -a, -A, -d, -D e USU?RIO for especificada, voc? ser?
perguntado interativamente.
 
Op??es:
 
Leia a descri??o do comando SQL CLUSTER para obter detalhes.
 
Leia a descri??o do comando SQL VACUUM para obter detalhes.
 
Reporte erros a <pgsql-bugs@postgresql.org>.
   %s [OP??O]... NOMEBD]
   %s [OP??O]... LINGUAGEM [NOMEBD]
   %s [OP??O]... [NOMEBD]
   %s [OP??O]... [NOMEBD] [DESCRI??O]
   %s [OP??O]... [USU?RIO]
   --help                          mostra esta ajuda e sai
   --help                       mostra esta ajuda e sai
   --help                    mostra esta ajuda e sai
   --version                       mostra informa??o sobre a vers?o e sai
   --version                    mostra informa??o sobre a vers?o e sai
   --version                 mostra informa??o sobre a vers?o e sai
   -A, --no-adduser          usu?rio n?o pode adicionar novos usu?rios
   -D, --no-createdb         usu?rio n?o pode criar novos bancos de dados
   -D, --tablespace=TABLESPACE  tablespace padr?o para o banco de dados
   -E, --encoding=CODIFICA??O   codifica??o para o banco de dados
   -E, --encrypted           criptografa a senha armazenada
   -L, --pglib=DIRET?RIO     encontra arquivo interpretador da linguagem no DIRET?RIO
   -N, --unencrypted         n?o criptografa a senha armazenada
   -O, --owner=DONO             usu?rio do banco que ser? dono do banco de dados
   -P, --pwprompt            atribui uma senha ao novo usu?rio
   -T, --template=MODELO        modelo de banco de dados para copiar
   -U, --username=USU?RIO    nome do usu?rio para se conectar
   -U, --username=USU?RIO    nome do usu?rio para se conectar
   -U, --username=USU?RIO    nome do usu?rio para se conectar (n?o ? o usu?rio a ser criado)
   -U, --username=USU?RIO    nome do usu?rio para se conectar (n?o ? o usu?rio a ser removido)
   -W, --password            pergunta senha
   -W, --password            pergunta senha
   -W, --password            pergunta senha ao conectar
   -a, --adduser             usu?rio pode adicionar novos usu?rios
   -a, --all                       faxina todos bancos de dados
   -a, --all                 agrupa todos os bancos de dados
   -d, --createdb            usu?rio pode criar novos bancos de dados
   -d, --dbname=NOMEBD             banco de dados a ser faxinado
   -d, --dbname=NOMEBD       banco de dados no qual ser? removido a linguagem
   -d, --dbname=NOMEBD       banco de dados a ser agrupado
   -d, --dbname=NOMEBD       banco de dados para instalar linguagem
   -e, --echo                      mostra os comandos enviados ao servidor
   -e, --echo                   mostra os comandos enviados ao servidor
   -e, --echo                mostra os comandos enviados ao servidor
   -f, --full                      faz uma faxina completa
   -h, --host=M?QUINA        m?quina do servidor de banco de dados ou diret?rio do soquete
   -h, --host=M?QUINA        m?quina do servidor de banco de dados ou diret?rio do soquete
   -i, --interactive         pergunta antes de apagar algo
   -i, --sysid=SYSID         seleciona identificador para novo usu?rio
   -l, --list                mostra a lista das linguagens instaladas
   -p, --port=PORTA          porta do servidor de banco de dados
   -p, --port=PORTA          porta do servidor de banco de dados
   -q, --quiet                     n?o exibe nenhuma mensagem
   -q, --quiet                  n?o mostra nenhuma mensagem
   -q, --quiet               n?o exibe nenhuma mensagem
   -t, --table='TABELA[(COLUNAS)]' faxina somente uma tabela espec?fica
   -t, --table=TABELA        agrupa somente a tabela especificada
   -v, --verbose                   mostra muitas mensagens
   -z, --analyze                   atualiza indicadores do otimizador
 %s faxina e analisa um banco de dados PostgreSQL.

 %s agrupa todas as tabelas agrupadas anteriormente no banco de dados.

 %s cria um banco de dados PostgreSQL.

 %s cria um novo usu?rio do PostgreSQL.

 %s instala uma linguagem procedural no banco de dados PostgreSQL.

 %s remove um banco de dados PostgreSQL.

 %s remove um usu?rio do PostgreSQL.

 %s remove uma linguagem procedural do banco de dados.
 %s: "%s" n?o ? um nome de codifica??o v?lido
 %s: n?o pode agrupar uma tabela espec?fica em todos os bancos de dados
 %s: n?o pode agrupar todos os bancos de dados e um espec?fico ao mesmo tempo
 %s: n?o pode faxinar uma tabela espec?fica em todos os bancos de dados
 %s: n?o pode faxinar todos os bancos de dados e um espec?fico ao mesmo tempo
 %s: agrupando banco de dados "%s"
 %s: agrupamento do banco de dados "%s" falhou: %s %s: agrupamento da tabela "%s" no banco de dados "%s" falhou: %s %s: cria??o de coment?rio falhou (banco de dados foi criado): %s %s: n?o p?de conectar ao banco de dados %s
 %s: n?o p?de conectar ao banco de dados %s: %s %s: n?o p?de obter nome de usu?rio atual: %s
 %s: n?o p?de obter informa??o sobre usu?rio atual: %s
 %s: cria??o de novo usu?rio falhou: %s %s: cria??o do banco de dados falhou: %s %s: remo??o do banco de dados falhou: %s %s: linguagem "%s" j? est? instalada no banco de dados "%s"
 %s: linguagem "%s" n?o est? instalada no banco de dados "%s"
 %s: instala??o de linguagem falhou: %s %s: remo??o da linguagem falhou: %s %s: nome do banco de dados ? um argumento requerido
 %s: nome da linguagem ? um argumento requerido
 %s: consulta falhou: %s %s: consulta foi: %s
 %s: remo??o do usu?rio "%s" falhou: %s %s: fun??es %s declaradas na linguagem "%s"; linguagem n?o foi removida
 %s: muitos argumentos para linha de comando (primeiro ? "%s")
 %s: linguagem "%s" n?o ? suportada
 %s: ID do usu?rio deve ser um n?mero positivo
 %s: faxinando banco de dados "%s"
 %s: faxina no banco de dados "%s" falhou: %s %s: faxina na tabela "%s" no banco de dados "%s" falhou: %s Voc? tem certeza? (s/n)  Banco de dados "%s" ser? permanentemente removido.
 Digite-a novamente:  Digite o nome do usu?rio a ser adicionado:  Digite o nome do usu?rio a ser removido:  Digite a senha para o novo usu?rio:  Nome Senha:  Senhas n?o correspondem.
 Linguagens Procedurais O novo usu?rio poder? criar bancos de dados? (s/n)  O novo usu?rio poder? criar outros usu?rios? (s/n)  Linguagens suportadas s?o plpgsql, pltcl, pltclu, plperl, plperlu e plpythonu.
 Confi?vel? Tente "%s --help" para obter mais informa??o.
 Uso:
 Usu?rio "%s" ser? permanentemente removido.
 n n?o s sim 