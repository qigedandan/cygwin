��    =        S   �      8  9   9  -   s  ,   �  8   �  *     N   2  N   �     �  *   �  +        G  !   c  )   �  #   �  &   �  -   �  !   (  !   J  +   l  "   �  (   �     �  J   �     D	     d	  #   �	  #   �	  #   �	  \   �	      K
  @   l
  D   �
  &   �
       )   )  )   S  )   }  )   �  )   �  )   �     %  V   B  )   �  )   �  )   �  )     )   A  )   k  )   �  )   �  )   �  	     �        �  &   �  !   �  -        J     a  )   v  t  �  I     (   _  ,   �  ,   �      �  H     G   L      �  -   �  ;   �  !     *   A  %   l  "   �  !   �  +   �       !   !  #   C     g  #   �     �  J   �           )     H     e     �  g   �  &     H   .  D   w  )   �     �  )   �  )     )   G  )   q  )   �  )   �     �  q     )     )   �  )   �  )   �  )   '  )   Q  )   {  )   �  )   �     �  �        �     �      �  2        K     T  )   k     !   0              1   3   4          *         -                        8   7       6          2   
       (             "             ;                           9   )   <   .                 /   	          #      :   =   5   &   $                     ,           +      '                      %    
If these values seem acceptable, use -f to force reset.
 
Report bugs to <pgsql-bugs@postgresql.org>.
   --help          show this help, then exit
   --version       output version information, then exit
   -f              force update to be done
   -l FILEID,SEG   force minimum WAL starting location for new transaction log
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
 Project-Id-Version: PostgerSQL 8.0
POT-Creation-Date: 2004-12-16 01:49+0000
PO-Revision-Date: 2004-12-16 12:17+0900
Last-Translator: Ioseph Kim <ioseph@uri.sarang.net>
Language-Team: KOREAN <pgsql-kr@postgresql.or.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: 8bit
X-Poedit-Language: Korean
X-Poedit-Country: KOREA, REPUBLIC OF
 
�� ���������� Ÿ���ϴٰ� �ǴܵǸ�, ������ �����Ϸ���, -f �ɼ��� ������.
 
��������: <pgsql-bugs@postgresql.org>.
   --help          �� ������ �����ְ� ��ħ
   --version       ���� ������ �����ְ� ��ħ
   -f              ������ ������
   -l FILEID,SEG   �� Ʈ����� �α׸� ���� �ּ� WAL ���� ��ġ�� ��������
   -n              �������� ����, ��Ʈ�� ������ �����ֱ⸸ ��(�׽�Ʈ��)
   -o OID          ���� OID ����
   -x XID          ���� XID(Ʈ����� ID) ����
 %s ���α׷��� PostgreSQL Ʈ����� �α׸� �ٽ� �����մϴ�.

 %s: OID (-o) ���� 0�� �ƴϿ�����
 %s: �� ���α׷��� "root"�� ����� �� ����
 %s: pg_control ���� ���� �� ����: %s
 %s: "%s" ���� ���� �� �� ����: %s
 %s: "%s" ���丮 �� �� ����: %s
 %s: "%s" ������ �б� ���� �� �� ����: %s
 %s: "%s" ���� �� �� ����: %s
 %s: "%s" ������ ���� �� ����: %s
 %s: "%s" ���丮 ���� �� ����: %s
 %s: "%s" ���� �� �� ����: %s
 %s: pg_control ���� �� �� ����: %s
 %s: fsync ����: %s
 %s: ���� ���� -- sizeof(ControlFileData) ���� �ʹ� ŭ ... xlog.c ���ľ���
 %s: LC_COLLATE ���� �߸� �Ǿ���
 %s: LC_CTYPE ���� �߸� �Ǿ���
 %s: -l �ɼǰ��� ����ġ ����
 %s: -o �ɼǰ��� ����ġ ����
 %s: -x �ɼǰ��� ����ġ ����
 %s: "%s" ��� ������ �ֽ��ϴ�.
������ �������ΰ���? �׷��� �ʴٸ�, �� ������ ����� �ٽ� �õ��Ͻʽÿ�.
 %s: ������ ���丮�� �������� �ʾ���
 %s: pg_control������ ������, CRC���� �߸��Ǿ����ϴ�; ����� �Բ� ������
 %s: pg_control������ ������, �ջ�Ǿ��ų� ������ �� �� ����; ������
 %s: Ʈ����� ID (-x) ���� 0�� �ƴϿ�����
 64-��Ʈ ���� ���� �����̼��� ���׸�Ʈ�� ���� ����: %u
 īŸ�α� ���� ��ȣ:                   %u
 ���� �α� ���� ID:                    %u
 �����ͺ��̽� ���� ũ��:               %u
 �����ͺ��̽� �ý��� �ĺ���:           %s
 ��¥/�ð��� �ڷ��� ������:          %s
 ������ pg_control ��������:

 ������ ������ ���丮�� �´ٸ�, ���� ������ �����ϰ�, �ٽ� �õ���
���ʽÿ�.
  touch %s
(win32���� ��� �ϳ�?)
 LC_COLLATE:                           %s
 LC_CTYPE:                             %s
 ������ üũ����Ʈ NextOID:            %u
 ������ üũ����Ʈ NextXID:            %u
 ������ üũ����Ʈ TimeLineID:         %u
 �ĺ��� �ִ� ����:                     %u
 ������ �̸��� �ִ� ����:              %u
 �Լ� ������ �ִ� ����:                %u
 ���� �α� ���� ���׸�Ʈ:              %u
 �ɼǵ�:
 �� �����ͺ��̽� ������ ���������� �������� ���߽��ϴ�.
Ʈ����� �α׸� �ٽ� �����ϴ� ���� �ڷ� �ս��� �߱��� �� �ֽ��ϴ�.
�׷����� �ұ��ϰ� �����Ϸ���, -f �ɼ��� ����ؼ� ���� ������ �Ͻʽÿ�.
 Ʈ����� �α� �缳��
 �ڼ��� ������ "%s --help"
 ����:
  %s [�ɼ�]... DATADIR

 PostgreSQL ���������� %s ���α׷��� �����Ͻʽÿ�.
 �ε��Ҽ� pg_control ��������:

 pg_control ���� ��ȣ:                 %u
 