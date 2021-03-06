??    ;      ?  O   ?        9   	  -   C  ,   q  8   ?  *   ?  N     N   Q     ?  *   ?  +   ?       )   3  #   ]  &   ?  -   ?  !   ?  !   ?  +     "   F  (   i     ?  J   ?     ?     	  #   0	  #   T	  #   x	  \   ?	      ?	  @   
  D   [
  &   ?
     ?
  )   ?
  )     )   +  )   U  )     )   ?     ?  V   ?  )   G  )   q  )   ?  )   ?  )   ?  )     )   C  )   m  )   ?  	   ?  ?   ?     j  &   ?  !   ?     ?     ?  )   ?  ,     9   M  0   ?  1   ?  1   ?  %     @   B  Q   ?  %   ?  *   ?  $   &     K  "   e     ?     ?  (   ?     ?          1     Q  "   q     ?  F   ?     ?          2     Q     p  j   ?     ?  6     9   L     ?     ?  1   ?  -   ?  /     0   E  2   v  1   ?     ?  X   ?  )   N  )   x  /   ?  /   ?  /     1   2  0   d  2   ?  2   ?     ?  ?        ?  *   ?  -   ?  	   ?       -        -      2   9          "                  !   '   $               4   3       +      	   #      7                                       (   .             *      0          %          ;      &      /   ,         1          :      5              
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
POT-Creation-Date: 2004-07-29 19:16-0300
PO-Revision-Date: 2004-08-01 13:22+0800
Last-Translator: Zhenbang Wei <forth@zbwei.net>
Language-Team: Zhenbang Wei <forth@zbwei.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
 
如果可以接受這些值，請用 -f 強制重設。
 
回報錯誤至 <pgsql-bugs@postgresql.org>。
   --help          顯示這份說明然後結束
   --version       顯示版本資訊然後結束
   -f              強制執行更新
   -l FILEID,SEG   強制新交易日誌的最小WAL開始位置
   -n              不執行更新，只顯示取得的控制資訊(以供測試)
   -o OID          設定下一個OID
   -x XID          設定下一個交易ID
 %s 重設PostgreSQL交易日誌。

 %s: OID (-o) 必須是 0
 %s: 無法建立pg_control檔: %s
 %s: 無法刪除檔案"%s": %s
 %s: 無法開啟目錄"%s": %s
 %s: 無法開啟檔案"%s"以讀取: %s
 %s: 無法開啟檔案"%s": %s
 %s: 無法讀取檔案"%s": %s
 %s: 無法讀取目錄"%s": %s
 %s: 無法寫入檔案"%s": %s
 %s: 無法寫入pg_control檔: %s
 %s: fsync發生錯誤: %s
 %s: 內部錯誤 -- sizeof(ControlFileData)太大 ... 請修正xlog.c
 %s: 無效的LC_COLLATE設定
 %s: 無效的LC_CTYPE設定
 %s: 選項 -l 的參數無效
 %s: 選項 -o 的參數無效
 %s: 選項 -x 的參數無效
 %s: 鎖定檔"%s"已存在
伺服器是否正在執行？如果不是，刪除鎖定檔後再試一次。
 %s: 未指定資料目錄
 %s: pg_control的CRC錯誤，繼續執行會有危險
 %s: pg_control可能損壞或版本錯誤，將它忽略
 %s: 交易 ID (-x) 必須是 0
 64位元整數 large relation每個區段的區塊數:       %u
 catalog版本號碼:                      %u
 目前的日誌檔ID:                       %u
 資料庫區塊大小:                       %u
 資料庫系統識別名稱:                   %s
 日期/時間儲存類型:                    %s
 猜測的pg_control值:

 如果你確定資料目錄的路徑正確，請執行
  touch %s
然後再試一次。
 LC_COLLATE:                           %s
 LC_CTYPE:                             %s
 最新的檢查點NextOID:                  %u
 最新的檢查點NextXID:                  %u
 最新的檢查點TimeLineID:               %u
 識別字的最大長度:                     %u
 locale名稱的最大長度:                 %u
 函式參數的最大個數:                   %u
 下一個日誌檔案區段:                   %u
 選項:
 資料庫伺服器沒有正常關閉，重設交易日誌可能導致
資料遺失，如果你仍要執行，請用 -f 強制重設。
 重設交易日誌
 執行"%s --help"以顯示更多資訊。
 使用方法:
  %s [選項]... 資料目錄

 浮點數 pg_control值:

 pg_control版本號碼:                   %u
 