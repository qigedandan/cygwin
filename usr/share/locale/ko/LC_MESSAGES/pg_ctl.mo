��    \      �     �      �      �     �  &        3     S  -   r     �     �  r   �     F	  F   f	  A   �	     �	  7   

  !   B
  3   d
  ?   �
  ?   �
  H     D   a  E   �  ?   �  B   ,  <   o  �   �  0   -  F   ^  8   �  2   �  O     7   a     �     �  �   �  !   :  :   \  I   �  y   �  =   [  >   �  ;   �  1     $   F  /   k  #   �     �  3   �  0     ,   B  .   o  7   �  1   �  5        >  $   U  ,   z  J   �     �  0        ?  "   R  %   u  $   �      �  4   �  %     $   <  "   a  F   �  F   �       )   *  s   T  h   �  &   1     X  &   `  0   �  )   �  "   �  (     !   .     P     l     �     �     �     �     �  &   �  "     t  >  .   �     �     �  *     *   9  (   d     �     �  p   �     ,  B   L  B   �     �  2   �         0   A  3   r  C   �  >   �  7   )  1   a  :   �  6   �  :     v   @  >   �  F   �  3   =   A   q   J   �   ;   �      :!     A!  �   H!     �!  2   "  R   8"  �   �"  F   2#  G   y#  8   �#  3   �#  "   .$  +   Q$     }$     �$  /   �$  0   �$  ,   %  .   I%  ;   x%  .   �%  ;   �%     &  )   3&  0   ]&  @   �&  &   �&  3   �&     *'     ;'  &   ['  &   �'  %   �'  (   �'     �'     (     2(  G   O(  7   �(     �(  .   �(  �   )  u   �)  !   *     >*  (   G*  -   p*  %   �*     �*     �*     +     #+     A+  $   X+     }+     �+     �+     �+  '   �+  )   ,     7          2               >      J   8   9   0   &   K   P               +   1   O                              A          G      6       ,   *       Y   U   @       :   Z      ;              R   4                          3   F   5       E   X       L   T                      B       '   /         C      M      #                -              N   $   D   "   <   !       Q   [      I           .      W   	   
   =   H   (   )                   %   S   \   V      ?        
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
 %s: could not find postmaster program executable
 %s: could not open PID file "%s": %s %s: could not open service "%s": error code %d
 %s: could not open service manager
 %s: could not read file "%s"
 %s: could not register service "%s": error code %d
 %s: could not send reload signal (PID: %ld): %s
 %s: could not send signal %d (PID: %ld): %s
 %s: could not send stop signal (PID: %ld): %s
 %s: could not start postmaster
Examine the log output.
 %s: could not start postmaster: exit code was %d
 %s: could not unregister service "%s": error code %d
 %s: invalid option %s
 %s: missing arguments for kill mode
 %s: neither postmaster nor postgres running
 %s: no database directory specified and environment variable PGDATA unset
 %s: no operation specified
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
 child process exited with exit code %d child process exited with unrecognized status %d child process was terminated by signal %d could not change directory to "%s" could not identify current directory: %s could not read symbolic link "%s" could not start postmaster
 postmaster shutting down
 postmaster signaled
 postmaster started
 postmaster starting
 postmaster stopped
 starting postmaster anyway
 waiting for postmaster to shut down... waiting for postmaster to start... Project-Id-Version: PostgreSQL 8.0
POT-Creation-Date: 2004-12-15 07:07+0000
PO-Revision-Date: 2004-12-16 11:30+0900
Last-Translator: Ioseph Kim <ioseph@uri.sarang.net>
Language-Team: KOREAN <pgsql-kr@postgresql.or.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: 8bit
X-Poedit-Language: Korean
X-Poedit-Country: KOREA, REPUBLIC OF
 
����� �� �ִ� ������(for kill) �ñ׳� �̸�:
 
�Ϲ� �ɼǵ�:
 
���� ���/���ſ� �ɼǵ�:
 
start, restart �� ����� �� �ִ� �ɼǵ�:
 
stop, restart �� ��� �� �� �ִ� �ɼǵ�:
 
��������: <pgsql-bugs@postgresql.org>.
 
������� ����:
   %s kill    �ñ׳��̸� PID
   %s register   [-N �����̸�] [-U �����] [-P ��й�ȣ] [-D DATADIR]
                    [-w] [-o "�����ɼ�"]
   %s reload  [-D DATADIR] [-s]
   %s restart [-w] [-D DATADIR] [-s] [-m �������] [-o "�����ɼ�"]
   %s start   [-w] [-D DATADIR] [-s] [-l �α�����] [-o "�����ɼ�"]
   %s status  [-D DATADIR]
   %s stop    [-W] [-D DATADIR] [-s] [-m �������]
   %s unregister [-N �����̸�]
   --help                 ������ �����ְ� ��ħ
   --version              ���� ������ �����ְ� ��ħ
   -D, --pgdata DATADIR   �����ͺ��̽� �ڷᰡ ����Ǿ��ִ� ���丮
   -N SERVICENAME  ���� ��Ͽ� ��ϵ� PostgreSQL ���� �̸�
   -P PASSWORD     �� ���񽺸� ������ ������� ��й�ȣ
   -U USERNAME     �� ���񽺸� ������ ����� �̸�
   -W                     �۾��� ���� ������ ��ٸ��� ����
   -l, --log �����̸�     ���� �α׸� �� ���Ͽ� �����
   -m �������        "smart", "fast", "immediate" �� �ϳ�
   -o �ɼǵ�              PostgreSQL �������α׷��� postmaster ������ ��
                         ����� ������ �ɼǵ�
   -p PATH-TO-POSTMASTER  postmaster ��� (������ �ʿ�ġ ����)
   -s, --silent           �Ϲ����� �޽����� ������ �ʰ�, ������ ������
   -w                     �۾��� ���� ������ ��ٸ�
   fast        Ŭ���̾�Ʈ�� ������ ������ ���� ���������� ���� ��
   immediate   �׳� ������ ������; �ٽ� ������ �� ���� �۾��� �� ���� ����
   smart       ��� Ŭ���̾�Ʈ�� ������ ����� �Ǹ� ���� ��
  �Ϸ�
  ����
 %s ���α׷��� PostgreSQL ���񽺸� ����, ����, �����, ȯ�漳�� ������,
���� ���� ����, �Ǵ� PostgreSQL ���μ����� Ư�� �ñ׳��� ���� �� �ִ�
���α׷��Դϴ�.

 %s: "%s" PID ������ �����ϴ�
 %s: ���� �鿣�� "postgres"�� ���� ���� (PID: %ld)
 %s: �ٸ� postmaster ���μ����� ���� ���� �� ����; ��°�� postmaster ������ �õ���
 %s: root�� �� ���α׷��� �������� ���ʽÿ�
�ý��۰����� ������ ����, �������μ����� �����ְ� �� �Ϲ� ����ڷ�
�α��� �ؼ�("su", "runas" ���� ���� �̿�) �����Ͻʽÿ�.
 %s: postmaster�� �ٽ� �ҷ��� �� ����; postgres�� ���� ���� (PID: %ld)
 %s: postmaster�� �ٽ� ���� �� �� ����; postgres�� ���� ���� (PID: %ld)
 %s: postmaster ���� ����; postgres�� ���� �� (PID: %ld)
 %s: ���� ������ postmaster ���α׷��� ã�� �� ����
 %s: "%s" PID ������ �� �� ����: %s %s: "%s" ���񽺸� �� �� ����: ���� �ڵ� %d
 %s: ���� �����ڸ� �� �� ����
 %s: "%s" ������ ���� �� ����
 %s: "%s" ���񽺸� ����� �� ����: ���� �ڵ� %d
 %s: reload �ñ׳��� ���� �� ���� (PID: %ld): %s
 %s: %d �ñ׳��� ���� �� ���� (PID: %ld): %s
 %s: stop �ñ׳��� ���� �� ���� (PID: %ld): %s
 %s: postmaster�� ���� �� �� ����
�α� ����� ���캸�ʽÿ�.
 %s: postmaster�� ������ �� ����: ���� �ڵ� %d
 %s: "%s" ���񽺸� ���� ��Ͽ��� �� �� ����: ���� �ڵ� %d
 %s: �߸��� �ɼ� %s
 %s: kill �۾��� �ʿ��� ���ڰ� �������ϴ�
 %s: postmaster�� postgres ��� ���� ������ ����
 %s: -D �ɼǵ� ����, PGDATA ȯ�溯������ �����Ǿ� ���� �ʽ��ϴ�.
 %s: ������ �۾��� �������� �ʾҽ��ϴ�
 %s: "%s" ȯ�漳�������� �ݵ�� �� ���� �������Ѵ�?
 %s: �޸� ����
 %s: postmaster�� ������ ������
 %s: postmaster�� ���� ���� (PID: %ld)
 %s: "%s" ���񽺰� �̹� ��� �Ǿ� ����
 %s: "%s" ���񽺰� ��ϵǾ� ���� ����
 %s: �ʹ� ���� ������ ���ڵ� (���� "%s")
 %s: �� �� ���� �۾� ��� "%s"
 %s: �߸��� ���� ��� "%s"
 %s: �߸��� �ñ׳� �̸� "%s"
 (�⺻ ������ ���� �� ���� ��ٸ���, �����̳� ������� ���� �� ��ٸ�.)
 -D �ɼ��� ������� ������, PGDATA ȯ�溯������ �����.
 postmaster�� ���� ���Դϱ�?
 postgres ���μ����� ������ �ٽ� �õ��Ͻʽÿ�.
 %s ���α׷��� "postgres" ���α׷��� �ʿ�� �մϴ�. �׷���, �� ������
"%s" ������ �ִ� ���丮�ȿ� �����ϴ�.
��ġ ���¸� Ȯ���� �ֽʽÿ�.
 "%s" ���α׷��� "postgres" ���α׷��� ã������ �� ������
%s ���α׷��� ������ Ʋ���ϴ�.
��ġ ���¸� Ȯ���� �ֽʽÿ�.
 ���� �ڼ��� ������ "%s --help"
 ����:
 ���� ���μ����� ����Ǿ���, ���� �ڵ� %d ���� ���μ����� ����Ǿ���, �˼� ���� ���� %d ���� ���μ����� ����Ǿ���, �ñ׳� %d "%s" ���丮�� �̵� �� �� ���� ���� ���丮�� �� �� ����: %s "%s" �ɹ��� ��ũ�� ���� �� ���� postmaster�� ���� �� �� ����
 postmaster�� ����ϴ�
 postmaster�� �ý��� �ñ׳��� �޾���
 postmaster ���۵�
 postmaster�� �����մϴ�
 postmaster ���߾���
 ��°�� postmaster�� �����մϴ�
 postmaster�� ���߱� ���� ��ٸ��� ��... postmaster�� �����ϱ� ���� ��ٸ��� ��... 