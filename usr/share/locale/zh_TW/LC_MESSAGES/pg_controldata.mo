??    (      \  5   ?      p  X   q  C   ?  -     !   <      ^       )   ?  )   ?  )   ?  )     )   7  )   a  )   ?  )   ?  ,   ?  )     )   6  ,   `  )   ?  ,   ?  )   ?  )     )   8  )   b  ,   ?  ,   ?  )   ?  &     ?   7  ?   ?     ?	     ?	     ?	  )   ?	  )   ?	  	   
     
     '
     3
  ,  L
  K   y  4   ?  (   ?     #     C     a  1   p  2   ?  -   ?  /     0   3  .   d  2   ?  1   ?  4   ?  /   -  /   ]  4   ?  /   ?  4   ?  1   '  0   Y  2   ?  2   ?  4   ?  .   %  1   T  '   ?  ?   ?  ?   <  	   ?     ?       /     -   C     q     x     ?     ?               
                                                             !   #                                  &      "             	      (            '            %       $       
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
POT-Creation-Date: 2004-11-01 01:42+0000
PO-Revision-Date: 2004-11-01 13:36+0800
Last-Translator: Zhenbang Wei <forth@zbwei.net>
Language-Team: Zhenbang Wei <forth@zbwei.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
 
如果沒有指定資料目錄(DATADIR)就會使用環境變數PGDATA。

 %s 顯示PostgreSQL資料庫cluster控制資訊。

 %s: 無法開啟檔案"%s"以讀取: %s
 %s: 無法讀取檔案"%s": %s
 %s: 沒有指定資料目錄
 64位元整數 large relation每個區段的區塊數:       %u
 每個WAL區段的位元組數:                %u
 catalog版本號碼:                      %u
 目前的日誌檔ID:                       %u
 資料庫區塊大小:                       %u
 資料庫cluster狀態:                    %s
 資料庫系統識別名稱:                   %s
 日期/時間儲存類型:                    %s
 最新的檢查點位置:                     %X/%X
 最新的檢查點NextOID:                  %u
 最新的檢查點NextXID:                  %u
 最新的檢查點REDO位置:                 %X/%X
 最新的檢查點TimeLineID:               %u
 最新的檢查點UNDO位置:                 %X/%X
 識別字的最大長度:                     %u
 locale名稱的最大長度:                 %u
 函式參數的最大個數:                   %u
 下一個日誌檔案區段:                   %u
 前一個檢查點位置:                     %X/%X
 回報錯誤至<pgsql-bugs@postgresql.org>。
 最新的檢查點時間:                     %s
 執行"%s --help"顯示更多資訊。
 用法：
  %s [OPTION] [DATADIR]

選項：
  --help         顯示說明訊息然後結束
  --version      顯示版本資訊然後結束
 警告：計算出來的CRC校驗值與儲存在檔案中的值不符。
可能是檔案損壞，或是與程式所預期的結構不同，下列
的結果是不可信賴的。

 浮點數 正在運作 正在復原 pg_control最後修改時間:               %s
 pg_control版本號碼:                   %u
 關閉 正在關閉 正在啟動 無法識別的狀態碼 