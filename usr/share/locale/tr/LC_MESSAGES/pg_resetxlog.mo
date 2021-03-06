??    =        S   ?      8  9   9  -   s  ,   ?  8   ?  *     N   2  N   ?     ?  *   ?  +        G  !   c  )   ?  #   ?  &   ?  -   ?  !   (  !   J  +   l  "   ?  (   ?     ?  J   ?     D	     d	  #   ?	  #   ?	  #   ?	  \   ?	      K
  @   l
  D   ?
  &   ?
       )   )  )   S  )   }  )   ?  )   ?  )   ?     %  V   B  )   ?  )   ?  )   ?  )     )   A  )   k  )   ?  )   ?  )   ?  	     ?        ?  &   ?  !   ?  -        J     a  )   v  K  ?  h   ?  <   U  0   ?  5   ?  7   ?  b   1  j   ?  )   ?  7   )  :   a     ?  +   ?  +   ?  "     "   .  1   Q  #   ?  !   ?      ?  %   ?  +        <  X   S      ?     ?  +   ?  +     +   D  ~   p     ?  O     X   ]  !   ?     ?  6   ?  ,   "  <   O  5   ?  3   ?  /   ?  &   &  g   M  )   ?  )   ?  0   	  0   :  3   k  1   ?  4   ?  /     7   6     n  ?   |  *   b  ?   ?  1   ?  B   ?     B     W  ,   p     !   0              2       4          *         -                        8   7       6          3   
       (                          ;                "          9   )   <   .              1   /   	          #      :   =   5   &   $                     ,           +      '                      %    
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
 Maximum columns in an index:          %u
 Maximum length of identifiers:        %u
 Maximum length of locale name:        %u
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
 Project-Id-Version: pg_resetxlog-tr
POT-Creation-Date: 2005-04-02 07:13+0100
PO-Revision-Date: 2005-04-02 19:17+0300
Last-Translator: 
Language-Team:  <en@li.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.9.1
X-Poedit-Language: Turkish
X-Poedit-Country: TURKEY
 
Eğer bu değerler kabul edilebilir görünüyorsa, reset işlemini zorlamak için -f yi kullanınız.
 
Hataları <pgsql-bugs@postgresql.org> adresine bildiriniz.
   --help          bu yardımı göster ve çık
   --version       sürüm bilgisini göster ve çık
   -f              güncellemenin yapılmasını sağla
   -l TLI,FILE,SEG   Yeni transaction kayıt dosyası için en düşük WAL başlama yerini belirt
   -n              güncelleme yapma, sadece extract edilmiş kontrol değerlerini göster (denemek için)
   -o OID          sıradaki OID'i ayarla
   -x XID          sıradaki transaction ID'sini ayarla
 %s PostgreSQL transaction kayıt dosyasını sıfırlar.

 %s: OID (-o) 0 olamaz
 %s: "root" tarafından çalıştırılamaz
 %s: pg_control dosyası yaratılamadı: %s
 %s:  "%s" dosyası silinemedi: %s
 %s:  "%s" dizini açılamadı: %s
 %s: "%s" dosyası okunmak için açılamadı: %s
 %s: "%s" dosyası açılamadı: %s
 %s: "%s" dosyası okunamadı: %s
 %s:  "%s" dizini okunamadı: %s
 %s: "%s" dosyasına yazılamadı: %s
 %s: pg_control dosyasına yazılamadı: %s
 %s: fsync hatası: %s
 %s: iç hata -- sizeof(ControlFileData) çok büyük ... xlog.c dosyasını düzeltiniz
 %s: Geçersiz LC_COLLATE ayarı
 %s: geçersiz LC_CTYPE ayarı
 %s: -l seçeneği için geçersiz argüman
 %s: -o seçeneği için geçersiz argüman
 %s: -x seçeneği için geçersiz argüman
 %s: "%s" lock dosyası mevcut
Bir sunucu çalışıyor mu? Eğer çalışmıyorsa, lock dosyasını silin ve yeniden deneyin.
 %s: veri dizini belirtilmedi
 %s: pg_control mevcut ancak geçersiz CRC'ye sahip, dikkat ederek devam ediniz
 %s: pg_control mevcut ama bozuk ya da bilinmeyen bir sürüme sahip; gözardı ediliyor
 %s: transaction ID (-x) 0 olamaz
 64-bit tamsayılar büyük nesnenin bölümü başına blok sayısı: %u
 Katalog sürüm numarası:               %u
 Mevcut kayıt dosyası dosya numarası:                  %u
 Veritabanı blok büyüklüğü:                  %u
 Veritabanı sistem tanımlayıcısı:           %s
 Tarih/zaman tipi saklanması:               %s
 Tahmin edilen pg_control değerleri:

 Eğer veri dizininin doğru olduğuna eminseniz
  touch %s
komutunu çalıştırın ve tekrar deneyin.
 LC_COLLATE:                           %s
 LC_CTYPE:                             %s
 Son checkpoint''in NextOID değeri:          %u
 Son checkpoint''in NextXID değeri:          %u
 Son checkpoint''in TimeLineID değeri:          %u
 Bir indexteki en fazla kolon sayısı:        %u
 Tanımlayıcıların en yüksek sayısı:        %u
 Yerel adının en büyük uzunluğu:        %u
 Sıradaki kayıt dosyası bölümü:                %u
 Seçenekler:
 Veritabanı sunucusu düzgün olarak kapatılmadı.
Transaction kayıt dosyasını sıfırlamak veri kaybına neden olabilir.
Yine de devam etmek istiyorsanız, sıfırlama işlemini zorlamak için -f parametresini kullanınız.
 Transaction kayıt dosyası sıfırlandı
 Daha fazla bilgi için "%s --help" parametresini kullanınız.
 Kullanımı:
  %s [SEÇENEK]... VERİ_DİZİNİ

 %s komutunu PostgreSQL superuser olarak çalıştırmalısınız.
 kayan nokta sayılar pg_control değerleri:

 pg_control sürüm numarası:            %u
 