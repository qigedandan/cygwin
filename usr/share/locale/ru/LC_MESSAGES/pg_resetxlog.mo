??    =        S   ?      8  9   9  -   s  ,   ?  8   ?  *     N   2  N   ?     ?  *   ?  +        G  !   c  )   ?  #   ?  &   ?  -   ?  !   (  !   J  +   l  "   ?  (   ?     ?  J   ?     D	     d	  #   ?	  #   ?	  #   ?	  \   ?	      K
  @   l
  D   ?
  &   ?
       )   )  )   S  )   }  )   ?  )   ?  )   ?     %  V   B  )   ?  )   ?  )   ?  )     )   A  )   k  )   ?  )   ?  )   ?  	     ?        ?  &   ?  !   ?  -        J     a  )   v  @  ?  U   ?  4   7  1   l  *   ?  7   ?  d     f   f  )   ?  1   ?  *   )     T  "   s  +   ?  %   ?  +   ?  0     %   E  %   k  .   ?  &   ?  .   ?       Y   ,  "   ?      ?  $   ?  $   ?  '     `   <  !   ?  ]   ?  P     (   n     ?  .   ?  )   ?  )      )   *  )   T  )   ~      ?  b   ?  )   ,  )   V  )   ?  )   ?  )   ?  )   ?  )   (  0   R  )   ?     ?  ?   ?     y  5   ?  )   ?  5   ?     '     9  )   P     !   0              1   3   4          *         -                        8   7       6          2   
       (                          ;                "          9   )   <   .                  /   	          #      :   =   5   &   $                     ,           +      '                      %    
If these values seem acceptable, use -f to force reset.
 
Report bugs to <pgsql-bugs@postgresql.org>.
   --help          show this help, then exit
   --version       output version information, then exit
   -f              force update to be done
   -l TLI,FILE,SEG force minimum WAL starting location for new transaction log
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
 Project-Id-Version: PostgreSQL 8.0
POT-Creation-Date: 2005-01-17 19:06+0000
PO-Revision-Date: 2005-01-17 16:01-0500
Last-Translator: Serguei A. Mokhov <mokhov@cs.concordia.ca>
Language-Team: pgsql-rus <pgsql-rus@yahoogroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
 
???? ??? ???????? ???????? ???????????, ??????????? -f ??? ???????????????  ??????.
 
????????? ?? ???????: <pgsql-bugs@postgresql.org>.
   --help          ???????? ??? ????????? ? ?????
   --version       ???????? ?????? ? ?????
   -f              ?????????????? ?????????? ??????????
   -l TLI,FILE,SEG ????????? ??????????? ????????? ????????? ???????? WAL ??? ?????? ???? ??????????
   -n              ??? ??????????, ?????? ???????? ??????????? ??????????? ???????? (??? ????????????)
   -o OID          ?????? ??????????? OID
   -x XID          ?????? ID ????????? ??????????
 %s ?????????? ??? ?????????? PostgreSQL.

 %s: OID (-o) ?? ?????? ???? 0
 %s: ?? ????? ??????????? "root"??
 %s: ?? ??????? ??????? ???? pg_control: %s
 %s: ?? ??????? ??????? ???? "%s": %s
 %s: ?? ??????? ??????? ?????????? "%s": %s
 %s: ?? ??????? ??????? ???? "%s" ??? ??????: %s
 %s: ?? ??????? ??????? ???? "%s": %s
 %s: ?? ??????? ??????? ???? "%s": %s
 %s: ?? ??????? ??????? ?? ?????????? "%s": %s
 %s: ?? ??????? ???????? ???? "%s": %s
 %s: ?? ??????? ???????? ? ???? pg_control: %s
 %s: ?????? fsync: %s
 %s: ?????????? ?????? -- sizeof(ControlFileData) ??????? ????? ... ???? ????????? xlog.c
 %s: ????????? ???????? LC_COLLATE
 %s: ????????? ???????? LC_CTYPE
 %s: ????????? ???????? ??? ????? -l
 %s: ????????? ???????? ??? ????? -o
 %s: ???????????? ???????? ??? ????? -x
 %s: ????????? lock-???? "%s"
??????? ?? ??????? ???? ???, ??????? ???? ???? ? ?????????? ?????.
 %s: ?? ??????? ?????????? ??????
 %s: pg_control ??????????, ?? ??? ??????????? ????? CRC ???????; ??????????? ? ?????????????
 %s: pg_control ??????????, ?? ??????ģ? ??? ??????????? ??????; ????????????...
 %s: ID ?????????? (-x) ?? ?????? ???? 0
 64-?????? ????? ?????? ?? ??????? ???????? ?????????:      %u
 ????? ?????? ????????:                %u
 ??????? ID ????? ???????:             %u
 ?????? ????? ????:                    %u
 ????????????? ??????? ??? ??????:     %s
 ??? ???????? ????/???????:            %s
 ????????? ???????? pg_control:

 ???? ?? ???????, ??? ???? ? ?????????? ?????? ??????????, ????????
  touch %s
? ?????????? ?????.
 LC_COLLATE:                           %s
 LC_CTYPE:                             %s
 NextOID ????????? checkpoint:         %u
 NextXID ????????? checkpoint:         %u
 TimeLineID ????????? checkpoint:      %u
 ???????????? ????? ???????????????:   %u
 ???????????? ????? ????? ??????:      %u
 ???????????? ????? ?????????? ???????:       %u
 ????????? ??????? ????? ???????:      %u
 ?????:
 ?????? ??? ?????? ?? ??? ????????? ??????????.
????? ???? ?????????? ????? ???????? ? ?????? ??????.
???? ?? ?ӣ ?? ?????? ?????????? ?? ?????? ?? ???, ??????????? -f ??? ??????????????? ??????.
 ??? ?????????? ???????
 ???????? "%s --help" ??? ????? ????????? ??????????.
 ?????????????:
  %s [OPTION]... DATADIR

 ?? ?????? ????????? %s ??? ????????????? PostgreSQL.
 ????????? ??????? ???????? pg_control:

 ????? ?????? pg_control:              %u
 