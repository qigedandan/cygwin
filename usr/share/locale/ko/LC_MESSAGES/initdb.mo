��    a      $  �   ,      8  R   9     �  
   �  -   �  �   �  �   o	     
    ,
  J   L  5   �  J   �  6     P   O  C   �  :   �  4     B   T  H   �  >   �  9     3   Y  ?   �  /   �  -   �  E   +  y   q  (   �  7     (   L  3   u  '   �  5   �  -     -   5  /   c  "   �  6   �  �   �  0   �  $   �  �   �  ~   ~  1   �     /  J   M  �   �     `  D   s  -   �  !   �  4     ,   =     j     �     �     �     �     �  ;   	  9   E  �     >     0  O  u   �  q   �  f   h  &   �     �     �  &     0   4  )   e  #   �  "   �  (   �  !   �  %   !  !   G     i     �     �      �     �  -   �  2   &  0   Y     �     �     �     �     �  &   �  %        >  +   T  !   �  t  �  E          ]   	   ~   (   �   �   �   �   G!     "  �   !"  B   �"  3   >#  L   r#  6   �#  7   �#  :   .$  7   i$  7   �$  6   �$  =   %  A   N%  =   �%  3   �%  E   &  =   H&  9   �&  L   �&  �   '  (   �'  5   �'  #   (  C   7(  #   {(  <   �(  (   �(  *   )  7   0)     h)  B   �)  �   �)  1   �*  ,   �*  �    +  p   �+  0   �+     $,  K   A,  �   �,     L-  ]   ]-  6   �-  ,   �-  6   .     V.  &   u.     �.  $   �.     �.      �.     /  =   $/  8   b/  �   �/  0   00  .  a0  �   �1  �   2  u   �2  ;   3     W3  "   `3  (   �3  -   �3  %   �3  =    4     >4     ^4     }4     �4     �4  -   �4     	5     #5      A5     b5  5   5  A   �5  1   �5     )6     A6     Y6     y6     6  (   �6  '   �6     �6  %   �6  )   7            ?   U      W          V   &           
   R       Y   =   C       F   .   Q      \   <   ,   "      2   K               M      	             [   6   )       H                        $   `   :       G      ^      L              -      ]   7           S   /           3       (            5              a   D       X   +              9   P   #   E   >   N           A   T   J      %   8   ;           B   _                  @   Z   I                  O   *       1   4   0   !      '    
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
 child process exited with exit code %d child process exited with unrecognized status %d child process was terminated by signal %d copying template1 to template0 ...  could not change directory to "%s" could not identify current directory: %s could not read symbolic link "%s" could not write to child process: %s
 creating configuration files ...  creating conversions ...  creating directory %s ...  creating directory %s/%s ...  creating information schema ...  creating system views ...  creating template1 database in %s/base/1 ...  enabling unlimited row size for system tables ...  fixing permissions on existing directory %s ...  initializing pg_depend ...  initializing pg_shadow ...  loading pg_description ...  ok
 out of memory
 selecting default max_connections ...  selecting default shared_buffers ...  setting password ...  setting privileges on built-in objects ...  vacuuming database template1 ...  Project-Id-Version: PostgreSQL 8.0
POT-Creation-Date: 2004-12-15 07:06+0000
PO-Revision-Date: 2004-12-16 11:23+0900
Last-Translator: Ioseph Kim <ioseph@uri.sarang.net>
Language-Team: KOREAN <pgsql-kr@postgresql.or.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: 8bit
X-Poedit-Language: Korean
X-Poedit-Country: KOREA, REPUBLIC OF
 
������ ���丮�� �������� ������, PGDATA ȯ�� �������� ����մϴ�.
 
�� �Ϲ������� ���Ǵ� �ɼǵ�:
 
�ɼǵ�:
 
��������: <pgsql-bugs@postgresql.org>.
 
�۾��Ϸ�. ���� ���� ������ �̿��ؼ� ������ ���� �� �� �ֽ��ϴ�:

    %s%s%s%spostmaster -D %s%s%s
or
    %s%s%s%spg_ctl -D %s%s%s -l logfile start

 
���: ���� ������ ���� ����� "trust" ����� �����߽��ϴ�.
�� ���� �ٲٷ���, pg_hba.conf ������ �����ϵ���,
������ initdb ������ ����� ��, -A �ɼ��� ����ؼ� ��������� ������ �� �ֽ��ϴ�.
   %s [�ɼ�]... [DATADIR]
   --lc-collate, --lc-ctype, --lc-messages=LOCALE
  --lc-monetary, --lc-numeric, --lc-time=LOCALE
                            ���������� ���� ������
                            (�ʱⰪ�� ���� �ý��� �������� �����)
   --locale=LOCALE           �����ͺ��̽� Ŭ������ �ʱ�ȭ�� ������
   --no-locale               --locale=C �ɼǰ� ����
   --pwfile=FILE             �� ���������� ��й�ȣ�� ������ FILE���� ������
   -?, --help                �� ������ �����ְ� ��ħ
   -A, --auth=METHOD         ���� ������ �⺻ ���� ���
   -E, --encoding=ENCODING   �� �����ͺ��̽��� �⺻ ���ڵ�
   -L DIRECTORY              �Է����ϵ��� �ִ� ���丮
   -U, --username=NAME       �����ͺ��̽� �������� �̸�
   -V, --version             ���� ������ �����ְ� ��ħ
   -W, --pwprompt            �� �������� ��й�ȣ�� �Է� ����
   -d, --debug               ����뿡 �ʿ��� �����鵵 �Բ� �����
   -n, --noclean             ������ �߻��Ǿ��� ��� �״�� ��
   -s, --show                ���� ���������� ������
  [-D, --pgdata=]DATADIR     �� �����ͺ��̽� Ŭ�����͸� ���� ���丮
 %s PostgreSQL �����ͺ��̽� Ŭ�����͸� �ʱ�ȭ �ϴ� ���α׷�.

 %s: "%s" ���ڵ��� ���� ���ڵ� �̸��� ����� �� �����ϴ�.
 %s: ��й�ȣ ������ �������� ���߽��ϴ�. �� ������ ���������� �˷��ֽʽÿ�.
 %s: root�� �� ���α׷��� �������� ���ʽÿ�
�ý��۰����� ������ ����, �������μ����� �����ְ� �� �Ϲ� ����ڷ�
�α��� �ؼ�("su", "runas" ���� ���� �̿�) �����Ͻʽÿ�.
 %s: "%s" ���丮�� ���� �� �� ����: %s
 %s: "%s" ���丮�� ���� ������ �ٲ� �� �����ϴ�: %s
 %s: "%s" ���丮 ���� �� ����: %s
 %s: �˸��� ���� ���� ���ڿ�(short version string)�� ������ �� ����
 %s: "%s" ������ ������ �� ����: %s
 %s: "%s" �����Ͽ��� ����� ������ ���ڵ��� ã�� ���߽��ϴ�.
 %s: "%s" ���� �б� ���� ���� ����: %s
 %s: "%s" ������ ���� ���� ���� ����: %s
 %s: file "%s" ���Ͽ��� ��й�ȣ�� ���� �� �����ϴ�: %s
 %s: "%s" ���� ���� ����: %s
 %s: "%s" ������ ���丮�� ������� ��û���� �������� �ʾҽ��ϴ�.
 %s: "%s" ���丮�� �̹� ������, ������� �ʽ��ϴ�.
�� ���丮�� �� �����ͺ��̽� Ŭ�����͸� �������,
"%s" ���丮�� ����ų� ���� ����� �ϵ���,
%s ���α׷����� �ٸ� ���丮�� �����ؼ� ����ϼ���, "%s" ��ſ�.
 %s: ������ ���丮 ������ ����µ� �����߽��ϴ�
 %s: ������ ���丮�� ����µ� �����߽��ϴ�
 %s: "%s" ������ �����ϴ�.
�� ������ ���������� ��ġ���� �ʾҰų�,
-L �ɼ����� ������ ��ΰ� �߸��Ǿ��� ����Դϴ�. Ȯ���غ�����.
 %s: "%s" �Է� ������ PostgreSQL %s ���� �ƴմϴ�.
��ġ���¸� Ȯ���� ����, -L �ɼ����� �ٸ� ��θ� �����Ͻʽÿ�.
 %s: �Է� ���� ��ġ�� �ݵ�� �����ο����մϴ�.
 %s: ������ ������ �̸� "%s"
 %s: %s ��������� ����Ϸ���, �ݵ�� ���������� ��й�ȣ�� �����ؾ��մϴ�.
 %s: ������ ���丮�� �������� �ʾҽ��ϴ�
�� �۾��� �����Ϸ���, �ݵ�� �� ������ ���丮�� ������ �־���մϴ�.
�����ϴ� ����� -D �ɼ��� ���̳�, PGDATA ȯ�� ���������� ������ �ָ� �˴ϴ�.
 %s: �޸� ����
 %s: ��й�ȣ�� �Է¹޴� �ɼǰ� ��й�ȣ�� ���Ͽ��� �������� �ɼ��� ���ÿ� ���� �� �����ϴ�
 %s: "%s" ������ ���丮 ���� ������ ����� �ֽ��ϴ�.
 %s: "%s" ������ ���丮�� ����� �ֽ��ϴ�.
 %s: �ʹ� ���� ������ ���ڸ� �����߽��ϴ�. (ó�� "%s")
 %s: �� �� ���� ���� ��� "%s"
 %s: ���: ���ڵ��� ���� ���� �ʽ��ϴ�
 ��й�ȣ Ȯ��: �� �������� ��й�ȣ�� �Է��Ͻʽÿ�: ��й�ȣ�� ���� Ʋ���ϴ�.
 -E �ɼ����� %s ������ �ֽʽÿ�.
 ����� ���� ���� ��.
 ������ ���� ���� ��.  ������ �߻��Ǿ �������� ���մϴ�.
 �����ͺ��̽� Ŭ�����ʹ� %s �����Ϸ� �ʱ�ȭ �� ���Դϴ�.
 �����ͺ��̽� Ŭ�����ʹ� ���� �����Ϸ� �ʱ�ȭ �� ���Դϴ�.
  COLLATE:  %s
  CTYPE:    %s
  MESSAGES: %s
  MONETARY: %s
  NUMERIC:  %s
  TIME:     %s
 �⺻ �����ͺ��̽��� %s ���ڵ��� �����Ǿ����ϴ�.
 ����ڰ� ������ ���ڵ� (%s)�� ���� �ý��� �����Ͽ��� ����ϴ� ���ڵ�(%s)��
���� �ٸ��ϴ�. �̷��� �Ǹ� ��� ���ڿ��� ó���ϴ� �Լ����� ��������
����ų ���� �ֽ��ϴ�. �� ������ �ذ��Ϸ���,
%s ���α׷��� �ٽ� �����ϸ鼭 ����ڰ� ������ ���ڵ��� �������� �ʰų�
�ý��� �����ϰ� �´� ���ڵ��� �����Ͻʽÿ�.
 �� �����ͺ��̽� �ý��ۿ��� ��������� ���ϵ��� �� �����ְ� "%s" id��
������ ���Դϴ�. ���� �� ����ڴ� ���� ���μ����� �����ְ� �˴ϴ�.

 %s ���α׷��� "postgres" ���α׷��� �ʿ�� �մϴ�. �׷���, �� ������
"%s" ������ �ִ� ���丮�ȿ� �����ϴ�.
��ġ ���¸� Ȯ���� �ֽʽÿ�.
 "%s" ���α׷��� "postgres" ���α׷��� ã������ �� ������
%s ���α׷��� ������ Ʋ���ϴ�.
��ġ ���¸� Ȯ���� �ֽʽÿ�.
 ���� �ڼ��� ������ ������ "%s --help" �ɼ��� ����Ͻʽÿ�.
 ����:
 �ý����� ���� ��ȣ(signal) �޾���
 ���� ���μ����� ����Ǿ���, ���� �ڵ� %d ���� ���μ����� ����Ǿ���, �˼� ���� ���� %d ���� ���μ����� ����Ǿ���, �ñ׳� %d template1 �����ͺ��̽��� template0 �����ͺ��̽��� ���� �� ... "%s" ���丮�� �̵� �� �� ���� ���� ���丮�� �� �� ����: %s "%s" �ɹ��� ��ũ�� ���� �� ���� ���� ���μ����� �� �� ����: %s
 ȯ�漳�� ������ ����� �� ... ���ڵ� ��ȯ��Ģ(conversion)���� ����� �� ... %s ���丮 ����� �� ... %s/%s ���丮 ����� �� ...  information schema ����� �� ... �ý��� ����� ����� �� ...  %s/base/1 �ȿ� template1 �����ͺ��̽��� ����� �� ... �ý��� ���̺����� ���� ���� ���� �ο� ũ�⸦ Ȱ��ȭ �ϰ� ���� ... �̹� �ִ� %s ���丮�� ���� ������ ��ġ�� �� ... pg_depend �ʱ�ȭ �� ... pg_shadow �ʱ�ȭ �� ... pg_description �ڷ� �Է� �� ... �Ϸ�
 �޸� ����
 max_connections �ʱⰪ�� �����ϴ� �� ... shared_buffers �ʱⰪ�� �����ϴ� �� ... ��й�ȣ ���� �� ... ���尴ü���� ���� ������ ���� �� ...  template1 �����ͺ��̽� vacuum �۾� �� ... 