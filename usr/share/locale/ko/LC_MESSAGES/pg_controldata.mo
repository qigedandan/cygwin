��    *      l  ;   �      �  X   �  C     -   F  !   t      �     �  )   �  )   �  )     )   E  )   o  )   �  )   �  )   �  )     )   A  ,   k  )   �  )   �  ,   �  )     ,   C  )   p  )   �  )   �  )   �  ,     ,   E  )   r  &   �  �   �  �   O	     
     -
     ;
  )   G
  )   q
  	   �
     �
     �
     �
  t  �
  P   M  E   �  /   �  %     *   :     e  )   r  )   �  )   �  )   �  )     )   D  )   n  )   �  )   �  )   �  ,     )   C  )   m  ,   �  )   �  ,   �  )     )   E  )   o  )   �  ,   �  '   �  )        B  }   b  �   �     �  
   �     �  )   �  )   �                     (                                                          !                         )   	          
   *             "   &         #         (   '      %       $                                                 
If no data directory (DATADIR) is specified, the environment variable PGDATA
is used.

 %s displays control information of a PostgreSQL database cluster.

 %s: could not open file "%s" for reading: %s
 %s: could not read file "%s": %s
 %s: no data directory specified
 64-bit integers Blocks per segment of large relation: %u
 Bytes per WAL segment:                %u
 Catalog version number:               %u
 Current log file ID:                  %u
 Database block size:                  %u
 Database cluster state:               %s
 Database system identifier:           %s
 Date/time type storage:               %s
 LC_COLLATE:                           %s
 LC_CTYPE:                             %s
 Latest checkpoint location:           %X/%X
 Latest checkpoint's NextOID:          %u
 Latest checkpoint's NextXID:          %u
 Latest checkpoint's REDO location:    %X/%X
 Latest checkpoint's TimeLineID:       %u
 Latest checkpoint's UNDO location:    %X/%X
 Maximum length of identifiers:        %u
 Maximum length of locale name:        %u
 Maximum number of function arguments: %u
 Next log file segment:                %u
 Prior checkpoint location:            %X/%X
 Report bugs to <pgsql-bugs@postgresql.org>.
 Time of latest checkpoint:            %s
 Try "%s --help" for more information.
 Usage:
  %s [OPTION] [DATADIR]

Options:
  --help         show this help, then exit
  --version      output version information, then exit
 WARNING: Calculated CRC checksum does not match value stored in file.
Either the file is corrupt, or it has a different layout than this program
is expecting.  The results below are untrustworthy.

 floating-point numbers in production in recovery pg_control last modified:             %s
 pg_control version number:            %u
 shut down shutting down starting up unrecognized status code Project-Id-Version: PostgreSQL 8.0
POT-Creation-Date: 2004-12-15 07:06+0000
PO-Revision-Date: 2004-12-16 11:37+0900
Last-Translator: Ioseph Kim <ioseph@uri.sarang.net>
Language-Team: KOREAN <pgsql-kr@postgresql.or.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: 8bit
X-Poedit-Language: Korean
X-Poedit-Country: KOREA, REPUBLIC OF
 
DATADIR�� ������ ���丮�� �������� ������, PGDATA ȯ�� ��������
����մϴ�.

 %s ���α׷��� PostgreSQL �����ͺ��̽� Ŭ�������� ���������� ������.

 %s: "%s" ������ �б� ���� �� �� �����ϴ�: %s
 %s: "%s" ������ ���� �� �����ϴ�: %s
 %s: ������ ���丮�� �������� �ʾҽ��ϴ�
 64-��Ʈ ���� ���� �����̼��� ���׸�Ʈ�� ���� ����: %u
 WAL ���׸�Ʈ�� ũ��(byte):            %u
 īŸ�α� ���� ��ȣ:                   %u
 ���� �α� ���� ID:                    %u
 �����ͺ��̽� ���� ũ��:               %u
 �����ͺ��̽� Ŭ������ ����:           %s
 �����ͺ��̽� �ý��� �ĺ���:           %s
 ��¥/�ð��� �ڷ��� ������:          %s
 LC_COLLATE:                           %s
 LC_CTYPE:                             %s
 ������ üũ����Ʈ ��ġ:               %X/%X
 ������ üũ����Ʈ NextOID:            %u
 ������ üũ����Ʈ NextXID:            %u
 ������ üũ����Ʈ REDO ��ġ:          %X/%X
 ������ üũ����Ʈ TimeLineID:         %u
 ������ üũ����Ʈ UNDO ��ġ:          %X/%X
 �ĺ��� �ִ� ����:                     %u
 ������ �̸��� �ִ� ����:              %u
 �Լ� ������ �ִ� ����:                %u
 ���� �α� ���� ���׸�Ʈ:              %u
 ���� üũ����Ʈ ��ġ:                 %X/%X
 ��������: <pgsql-bugs@postgresql.org>.
 ������ üũ����Ʈ �ð�:               %s
 ���� �ڼ��� ������ "%s --help"
 ����:
  %s [�ɼ�] [DATADIR]

�ɼǵ�:
  --help         �� ������ �����ְ� ��ħ
  --version      ���� ������ �����ְ� ��ħ
 ���: ���� CRC üũ������ ���Ͽ� �ִ� ���� Ʋ���ϴ�.
�� ���� ������ �ջ�Ǿ��ų�, �� ���α׷��� ��Ʈ�� ������ ������ Ʋ��
����Դϴ�. ��������� ���� ���� ������ ��µ� �� �ֽ��ϴ�.

 �ε��Ҽ� ���󰡵��� ���� �۾� �� pg_control ������ ����ð�:           %s
 pg_control ���� ��ȣ:                 %u
 ������ ���� �� ���� �� �˼� ���� ���� �ڵ� 