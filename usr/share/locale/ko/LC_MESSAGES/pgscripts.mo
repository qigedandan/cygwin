��    {      �  �   �      h
  K   i
     �
  ^   �
  
   *  >   5  =   t  -   �     �  #   �       (   8     a  <   ~  9   �  6   �  H   ,  E   u  B   �  6   �  9   5  C   o  9   �  4   �  H   "  ;   k  E   �  :   �  9   (  7   b  4   �  L   �  J     3   g  0   �  ;   �  3     7   <  2   t  :   �  5   �  G     0   `  <   �  M   �  J     G   g  4   �  H   �  E   -  <   s  6   �  I   �  4   1  1   f  ;   �  8   �  5     =   C  8   �  8   �  9   �  /   -  <   ]  #   �  #   �  ?   �  #   "     F  3   f  &   �  5   �  E   �  4   =  D   r     �  *   �  8      6   9  %   p  (   �  (   �  8   �  #   !      E     f  8   �  4   �  $   �       ,   9  ,   f     �     �  #   �  G   �  4   '     \  &   {     �  )   �  7   �     !  +   6     b     s     �     �     �  
   �     �     �  9      >   B   P   �      �   &   �      !  '   
!     2!     4!     7!     9!  t  =!  ^   �"     #  ~    #  	   �#  >   �#  =   �#  (   &$     O$  !   f$     �$     �$     �$  <   �$  9   %  6   U%  <   �%  9   �%  6   &  8   :&  ;   s&  G   �&  3   �&  =   +'  ;   i'  1   �'  3   �'  *   (  :   6(  -   q(  .   �(  m   �(  @   <)  =   })  :   �)  E   �)  8   <*  9   u*  9   �*  ;   �*  ;   %+  7   a+  /   �+  1   �+  @   �+  B   <,  =   ,  )   �,  H   �,  H   0-  8   y-  -   �-  ?   �-  6    .  3   W.  @   �.  ;   �.  :   /  <   C/  5   �/  9   �/  B   �/  \   30  [   �0  3   �0  -    1  G   N1  5   �1  /   �1  >   �1  1   ;2  =   m2  9   �2  @   �2  P   &3  '   w3  '   �3  4   �3  8   �3  &   54  )   \4  (   �4  (   �4     �4      �4     5  <   65  ;   s5     �5     �5  /   �5  6   6     D6     V6     k6  d   �6  (   �6     7  (   47      ]7  '   ~7  1   �7     �7  -   �7     8     .8     E8     d8     {8  	   �8     �8     �8  ?   �8  <   �8  C   09     t9  !   |9     �9  &   �9     �9     �9     �9     �9            r   X   j              M   A   K   V   {           "   (   ?       )       =   O   T   ,          v      U               >   &   J   !           g             p   	       7          [           Y   x       Z         ;   /   a       E           B   q   2              D   c   P   t   z       '       w   5       R   4   #   1      n   N   :   y   Q   $   .                 u               3       <          o   W                +   S   G   L   %      ^   ]   9           b   6   s   f   I                   m   _      \   `          -   l           0   h       i   k   H   F       *       
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
POT-Creation-Date: 2004-12-15 07:09+0000
PO-Revision-Date: 2004-12-16 02:11+0900
Last-Translator: Ioseph Kim <ioseph@uri.sarang.net>
Language-Team: KOREAN <pgsql-kr@postgresql.or.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: 8bit
X-Poedit-Language: Korean
X-Poedit-Country: KOREA, REPUBLIC OF
 
�ʱⰪ����, DB�̸��� �������� ������, ���� ������� �̸��� ���� �����ͺ��̽��� ��������ϴ�.
 
���� �ɼǵ�:
 
-a, -A, -d, -D, ������̸� ���ڵ� �� ��� �ϳ��� ������
���α׷��� �� ���� ���� ������Ʈ�� ����, ��ȭ������ ó���� ���Դϴ�.
 
�ɼǵ�:
 
���� �ڼ��� ������ CLUSTER SQL ���ɾ� �������� �����Ͻʽÿ�.
 
���� �ڼ��� ������ VACUUM SQL ���ɾ� �������� �����Ͻʽÿ�.
 
��������: <pgsql-bugs@postgresql.org>.
   %s [�ɼ�]... DB�̸�
   %s [�ɼ�]... ����̸� [DB�̸�]
   %s [�ɼ�]... [DB�̸�]
   %s [�ɼ�]... [DB�̸�] [����]
   %s [�ɼ�]... [������̸�]
   --help                          �� ������ �����ְ� ��ħ
   --help                       �� ������ �����ְ� ��ħ
   --help                    �� ������ �����ְ� ��ħ
   --version                       ���� ������ �����ְ� ��ħ
   --version                    ���� ������ �����ְ� ��ħ
   --version                 ���� ������ �����ְ� ��ħ
   -A, --no-adduser          �� ����ڸ� �߰� �� �� ����
   -D, --no-createdb         �� �����ͺ��̽��� ���� �� ����
   -D, --tablespace=TABLESPACE  �����ͺ��̽��� ���� �⺻ ���̺������̽�
   -E, --encoding=ENCODING      �����ͺ��̽� ���ڵ�
   -E, --encrypted           �̹� ��ȣȭ �Ǿ��� ��й�ȣ ����
   -L, --pglib=DIRECTORY     ��� ����� �ִ� ���丮 ����
   -N, --unencrypted         ��ȣȭ �ȵ� ��й�ȣ
   -O, --owner=OWNER            �����ͺ��̽� ������
   -P, --pwprompt            ��й�ȣ ����
   -T, --template=TEMPLATE      ������ ���ø� �����ͺ��̽�
   -U, --username=USERNAME      ������ �����
   -U, --username=USERNAME   ������ ������̸�
   -U, --username=USERNAME   ������ ������ �����
                            (����ڸ���� �۾��� �� �����)
   -U, --username=USERNAME   �� �۾��� ������ DB�� ������ �����
   -W, --password               ��й�ȣ �Է��� ���� ������Ʈ
   -W, --password            ��й�ȣ �Է��� ���� ������Ʈ
   -W, --password            �����۾��� �ʿ��� ��й�ȣ �Է� ������Ʈ
   -a, --adduser             �� ����ڸ� �߰� �� �� ����
   -a, --all                       ��� �����ͺ��̽� û��
   -a, --all                 ��� �����ͺ��̽��� �������
   -d, --createdb            �� �����ͺ��̽��� ���� �� ����
   -d, --dbname=DBNAME             DBNAME �����ͺ��̽� û��
   -d, --dbname=DBNAME       �� ������ �����ͺ��̽�
   -d, --dbname=DBNAME       Ŭ������ �۾��� DB
   -d, --dbname=DBNAME       �� ��ġ�� DB�̸�
   -e, --echo                      ������ ������ ���ɵ��� ������
   -e, --echo                   ������ ������ �۾� ���ɵ��� ������
   -e, --echo                ������ ������ �۾� ������ ������
   -f, --full                      ��û��
   -h, --host=HOSTNAME          �����ͺ��̽� ���� ȣ��Ʈ�� ���� ���丮
   -h, --host=HOSTNAME       �����ͺ��̽� ���� ȣ��Ʈ �Ǵ� ���� ���丮
   -i, --interactive         ����� ���� �� �� �� ���
   -i, --sysid=SYSID         ����� ID�� ����
   -l, --list                ���� ��ġ �Ǿ��ִ� ������ ������
   -p, --port=PORT              �����ͺ��̽� ���� ��Ʈ
   -p, --port=PORT           �����ͺ��̽� ���� ��Ʈ
   -q, --quiet                     ��� �޽����� �������� ����
   -q, --quiet                  ��� �޽����� ������ ����
   -q, --quiet               ��� �޽����� �������� ����
   -t, --table='TABLE[(COLUMNS)]'  ������ Ư�� ���̺��� û��
   -t, --table=TABLE         ������ ���̺��� Ŭ������
   -v, --verbose                   �۾������� �ڼ��� ���
   -z, --analyze                   ��������ȭ�� ��Ʈ �ڷḦ ������
 %s ���α׷��� PostgreSQL �����ͺ��̽� �ڷ� ���� ��
���� ����ȭ���� ���� �ڷḦ �����մϴ�.

 %s ���α׷��� DB �ȿ��� ������ Ŭ�����͵� ��� ���̺��� ã��
�ٽ� Ŭ������ �۾��� �մϴ�.

 %s ���α׷��� PostgreSQL �����ͺ��̽��� ����ϴ�.

 %s ���α׷��� PostgreSQL ����ڸ� ����ϴ�.

 %s ���α׷��� PostgreSQL �����ͺ��̽��� ���ν���� �� ��ġ�մϴ�.

 %s ���α׷��� PostgreSQL �����ͺ��̽��� �����մϴ�.

 %s ���α׷��� PostgreSQL ����ڸ� �����մϴ�.

 %s ���α׷��� �����ͺ��̽����� ���ν���� �� �����մϴ�.

 %s: "%s" ���ڵ��� ��� ������ ���ڵ� �̸��� �ƴ�
 %s: ��� DB�� ������� Ư�� ���̺��� Ŭ�������� �� �����ϴ�.
 %s: ��� DB �۾��� Ư�� DB �۾��� ���ÿ� �� �� �����ϴ�.
 %s: ��� �����ͺ��̽��� ������� Ư�� ���̺��� û���� ���� ����
 %s: -a �ɼ��� ���� ���� �� �����ͺ��̽��� ������� �۾��� ������ �� �����ϴ�.
 %s: "%s" �����ͺ��̽� Ŭ������ �۾� ��
 %s: "%s" �����ͺ��̽� Ŭ������ ����: %s %s: "%s" ���̺�(�ش�DB: "%s") Ŭ������ �۾� ����: %s %s: �ڸ�Ʈ �߰��ϱ� ���� (�����ͺ��̽��� ���������): %s %s: %s �����ͺ��̽��� ���� �� �� ����
 %s: %s �����ͺ��̽��� ���� �� �� ����: %s %s: ���� ����� �̸��� ���� �� ����: %s
 %s: ���� ����� ������ ���� �� ����: %s
 %s: �� ����� ����� ����: %s %s: �����ͺ��̽� ����� ����: %s %s: �����ͺ��̽� ���� ����: %s %s: "%s" ���� �̹� "%s" �����ͺ��̽��� ��ġ�Ǿ� �ֽ��ϴ�.
 %s: "%s" ���� "%s" �����ͺ��̽��� ��ġ �Ǿ����� �ʽ��ϴ�
 %s: ��� ��ġ ����: %s %s: ��� ���� ����: %s %s: �ʼ� �׸��� �����ͺ��̽� �̸��� �������ϴ�
 %s: �ʼ� �׸���, ��� �̸��� ������ ���ڰ� �������ϴ�
 %s: ���� ����: %s %s: ���� ����: %s
 %s: "%s" ����� ���� ����: %s %s: ���� %s���� �Լ��� "%s" ��� ������� �ۼ��Ǿ� ���ǰ� �ֽ��ϴ�; �� ���� ������ �� �����ϴ�.
 %s: �ʹ� ���� ������ ���ڵ� (���� "%s")
 %s: �������� ���� ��� "%s"
 %s: ����� ID ���� ��� ���������մϴ�.
 %s: "%s" �����ͺ��̽��� û�� ��
 %s: "%s" �����ͺ��̽� û���ϱ� ����: %s %s: "%s" ���̺� (�ش� DB: "%s") û���ϱ� ����: %s ��� �����ұ��? (y/n)  "%s" �����ͺ��̽��� ������ ���� �� ���Դϴ�.
 ��й�ȣ Ȯ��:  �߰��� �� ������̸�:  ������ ����ڸ� �Է��Ͻʽÿ�:  �� ������� ��й�ȣ:  �̸� ��й�ȣ: ��й�ȣ�� ���� Ʋ��.
 ���ν���� ���� �� ����ڿ��� �����ͺ��̽��� ���� �� �ִ� ������ �ٱ��? (y/n)  �� ����ڿ��� �� ����ڸ� ���� �� �ִ� ������ �ٱ��? (y/n)  �����ϴ� ���: plpgsql, pltcl, pltclu, plperl, plperlu, plpythonu.
 �ŷڵ�? ���� �ڼ��� ������ "%s --help"
 ����:
 "%s" ����ڴ� ������ ������ ���Դϴ�.
 n �ƴϿ� y �� 