��    ;      �  O   �        9   	  -   C  ,   q  8   �  *   �  N     N   Q     �  *   �  +   �       )   3  #   ]  &   �  -   �  !   �  !   �  +     "   F  (   i     �  J   �     �     	  #   0	  #   T	  #   x	  \   �	      �	  @   
  D   [
  &   �
     �
  )   �
  )     )   +  )   U  )     )   �     �  V   �  )   G  )   q  )   �  )   �  )   �  )     )   C  )   m  )   �  	   �  �   �     j  &   �  !   �     �     �  )   �  P     #   q  )   �  -   �  +   �       :   7  :   r  #   �  &   �     �       !   .     P     k  #   �     �     �     �                9  =   M     �     �     �     �     �  W        g  ;   }  4   �     �     	  )     )   <  )   f  )   �  )   �  )   �       >   &  )   e  )   �  )   �  )   �  )     )   7  )   a  )   �  )   �     �  \   �     C  !   Q  #   s     �     �  )   �     -      2   9          "                  !   '   $               4   3       +      	   #      7                                       (   .             *      0          %          ;      &      /   ,         1          :      5              
              8       )             6    
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

 floating-point numbers pg_control values:

 pg_control version number:            %u
 Project-Id-Version: PostgreSQL 8.0
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2004-12-02 09:58+0000
PO-Revision-Date: 2004-01-10 13:47+0800
Last-Translator: Bao Wei <weibao@qmail.zhengmai.net.cn>
Language-Team: Weiping He <laser@zhengmai.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
 
�����Щֵ�ɽ���, �� -f ǿ������.
 
��������� <pgsql-bugs@postgresql.org>.
   --help            ��ʾ�˰�����Ϣ, Ȼ���˳�
   --version         ����汾��Ϣ, Ȼ���˳�
   -f                ǿ�Ƹ���
   -l FILEID,SEG     ���µ�������־��ǿ����С WAL ��ʼλ��
   -n                δ����, ֻ��ʾ��ȡ�Ŀ���ֵ (������;)
   -o OID            ������һ�� OID
   -x XID            ������һ������ ID
 %s ���� PostgreSQL ������־.

 %s: OID (-o) ����Ϊ 0
 %s: �޷����� pg_control �ļ�: %s
 %s: �޷�ɾ���ļ� "%s": %s
 %s: �޷���Ŀ¼ "%s": %s
 %s: �޷����ļ� "%s" ��ȡ��Ϣ: %s
 %s: �޷����ļ� "%s": %s
 %s: �޷���ȡ�ļ� "%s": %s
 %s: �޷���Ŀ¼ "%s" �ж�ȡ: %s
 %s: �޷�д�ļ� "%s": %s
 %s: �޷�д pg_control �ļ�: %s
 %s: fsync ����: %s
 %s: �ڲ����� -- sizeof(ControlFileData) ̫�� ... �޸� xlog.c
 %s: ��Ч�� LC_COLLATE ����
 %s: ��Ч�� LC_CTYPE ����
 %s: Ϊ -l ѡ�����Ч����
 %s: Ϊ -o ѡ�����Ч����
 %s: Ϊ -x ѡ�����Ч����
 %s: ���ļ� "%s" �Ѿ�����
�Ƿ���һ��������������? ���û��, ɾ���Ǹ����ļ�Ȼ������һ��.
 %s: û��ָ������Ŀ¼
 %s: pg_control �Ѿ�����, ������Ч��CRC; ���о���ļ�������
 %s: pg_control �Ѿ�����, �����ƻ�����Ч�汾; ������
 %s: ���� ID (-x) ����Ϊ 0
 64λ���� ���ϵ��ÿ�ο���:                     %u
 Catalog �汾:                         %u
 ��ǰ��־�ļ�ID:                       %u
 ���ݿ���С:                         %u
 ���ݿ�ϵͳ��ʶ��:                     %s
 ����/ʱ�����ʹ洢:                    %s
 �²�� pg_control ֵ:

 �����ȷ������Ŀ¼·������ȷ��, ����
  touch %s
Ȼ������һ��.
 LC_COLLATE:                           %s
 LC_CTYPE:                             %s
 ���¼���� NextOID:                 %u
 ���¼���� NextXID:                 %u
 ���¼���� TimeLineID:              %u
 ��ʾ������󳤶�:                     %u
 �������ֵ���󳤶�:                   %u
 ����������������:                   %u
 ��һ����־�ļ���:                     %u
 ѡ��:
 ���ݿ������û�г��׹ر�.
����������־�п��ܻ�����ʧ����.
������������, �� -f ǿ������.
 ������־����
 ���� "%s --help" ��ȡ�������Ϣ.
 ʹ�÷���:
  %s [ѡ��]... ����Ŀ¼

 ������ pg_control ֵ:

 pg_control �汾:                      %u
 