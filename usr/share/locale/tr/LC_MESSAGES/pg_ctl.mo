??    a      $  ?   ,      8      9     Z  &   l     ?     ?  -   ?      	     	  r   3	     ?	  F   ?	  A   
     O
  7   j
  !   ?
  3   ?
  ?   ?
  ?   8  H   x  D   ?  E     ?   L  B   ?  <   ?  ?     0   ?  F   ?  8     2   >  O   q  7   ?     ?        ?   	  !   ?  :   ?  I   ?  y   A  =   ?  >   ?  ;   8  *   t  1   ?  $   ?  /   ?  #   &     J  3   h  0   ?  ,   ?  .   ?  7   )  1   a  0   ?  5   ?     ?  $     ,   6  J   c     ?  0   ?     ?  "     %   1  $   W      |  4   ?  %   ?  $   ?  "     F   @  F   ?     ?  )   ?  s     h   ?  &   ?       &     0   C  )   t  "   ?      ?  (   ?       !   &     H     d     x     ?     ?     ?     ?     ?  &      "   '  ?  J  )   ?     ?  2     8   ?  8   x  <   ?     ?  *     p   -  '   ?  R   ?  N     "   h  ?   ?  !   ?  7   ?  >   %  ;   d  D   ?  J   ?  Q   0   5   ?   f   ?   @   !  ?   `!  B    "  O   C"  3   ?"  5   ?"  h   ?"  E   f#     ?#     ?#  ?   ?#  "   ?$  3   ?$  g   ?$  ?   X%  G   ?%  C   8&  A   |&  +   ?&  ;   ?&  &   &'  ,   M'  $   z'     ?'  -   ?'  1   ?'  4   (  5   R(  ?   ?(  7   ?(  0    )  .   1)     `)  &   {)  -   ?)  S   ?)      $*  7   E*     }*     ?*  (   ?*  ,   ?*  "   +  7   $+     \+      |+     ?+  g   ?+  X   %,     ~,  0   ?,  ?   ?,  ?   S-  ?   ?-     .  :   $.  ;   _.  9   ?.  /   ?.  '   /  #   -/  '   Q/      y/     ?/     ?/     ?/  '   ?/     0     10     H0  #   _0  %   ?0  &   ?0        B       *   `   ;   J       [            2          I   :   Q   X   ^   &   (       T       C   P         S      W       #      '              V      1          N       .   
         _       5                 Z   R   U   Y                  ?   6   <       9   0       !                      @              %   8   3   K   M   =      /   -   G   ,   F   O       "   )   \      >       $   E   7       L   A      ]          4   H          	                     +          D              a    
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
 %s: could not find own program executable
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
 %s: could not start service "%s": error code %d
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
 child process exited with exit code %d child process exited with unrecognized status %d child process was terminated by signal %d could not change directory to "%s" could not find a "%s" to execute could not identify current directory: %s could not read binary "%s" could not read symbolic link "%s" could not start postmaster
 invalid binary "%s" postmaster shutting down
 postmaster signaled
 postmaster started
 postmaster starting
 postmaster stopped
 starting postmaster anyway
 waiting for postmaster to shut down... waiting for postmaster to start... Project-Id-Version: pg_ctl-tr
POT-Creation-Date: 2005-01-04 19:05+0000
PO-Revision-Date: 2005-01-15 14:03+0200
Last-Translator: Nicolai Tufar <ntufar@tdmsoft.com>
Language-Team: Turkish <pgsql-tr-genel@PostgreSQL.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.9.1
X-Poedit-Language: Turkish
X-Poedit-Country: TURKEY
 
kill için izin verilen sinyal adları:
 
Ortak seçenekler:
 
Kaydetmek ya da kaydı silmek için seçenekler:
 
Başlatmak ya da yeniden başlatmak için seçenekler:
 
Başlatmak ya da yeniden başlatmak için seçenekler:
 
Hataları <pgsql-bugs@postgresql.org> adresine bildiriniz.
 
Kapatma modları:
   %s kill    SİNYAL_ADI SÜREÇ_NUMARASI
   %s register   [-N servis adı] [-U kullanıcı adı] [-P şifre] [-D VERİ_DİZİNİ] [-w] [-o "SEÇENEKLER"]
   %s reload  [-D VERİ_DİZİNİ] [-s]
   %s restart [-w] [-D VERİ_DİZİNİ] [-s] [-m SHUTDOWN-MODE] [-o "SEÇENEKLER"]
   %s start   [-w] [-D VERİ_DİZİNİ] [-s] [-l DOSYA_ADI] [-o "SEÇENEKLER"]
   %s status  [-D VERİ_DİZİNİ]
   %s stop    [-W] [-D VERİ_DİZİNİ] [-s] [-m SHUTDOWN-MODE]
   %s unregister [-N SERVİS_ADI]
   --help                 Bu yardımı göster ve çık
   --version             sürüm numarasını yazar ve çıkar
   -D, --pgdata VERİ_DİZİNİ   verinin tutulacağı alan
   -N SERVICENAME  PostgreSQL sunucusunu kaydedeceğiniz servis adı
   -P PASSWORD     PostgreSQL sunucusunu kaydetmek için hesabın şifresi
   -U USERNAME     PostgreSQL sunucusunu kaydetmek için gerekli kullanıcı adı
   -W                     işlem bitene kadar bekleme
   -l, --log DOSYA_ADI      Sunucu loglarını DOSYA_ADI dosyasına yaz (ya da dosyanın sonuna ekle).
   -m KAPANMA-MODU   "smart", "fast", ya da "immediate" olabilir
   -o SEÇENEKLER             postmaster'a geçilecek komut satırı seçenekleri
                         (PostgreSQL sunucusu çalıştırılabilir dosyası)
   -p POSTMASTER'IN_OLDUĞU_DIZINE_YOL  normalde gerekli değildir
   -s, --silent           sadece hataları yazar, hiç bir bilgi mesajı yazmaz
   -w                     işlem bitene kadar bekle
   fast        düzgünce kapanmadan direk olarak dur
   immediate   tam bir kapanma gerçekleşmeden dur; yeniden başladığında recovery modunda açılır
   smart       tüm istemciler bağlantılarını kestikten sonra dur
  tamam
  başarısız oldu
 %s başlatmak, durdurmak, yeniden başlatmak, yapılandırma dosyalarını yeniden yüklemek
PostgreSQL sunucusunun durumunu bildirmek, ya da PostgreSQL sürecini öldürmek için bir yardımcı programdır

 %s: "%s" PID dosyası bulunamadı
 %s: standalone "postgres" çalışıyor (PID: %ld)
 %s: Başka bir postmaster çalışıyor olabilir; postmaster yine de başlatılmaya çalışılıyor..
 %s: root olarak çalıştırılamaz
Lütfen  (yani "su" kullanarak) sunucu sürecine sahip olacak (yetkisiz) kullanıcı
ile sisteme giriş yapınız.
 %s: postmaster yeniden yüklenemedi, postgres çalışıyor (PID: %ld)
 %s: postmaster başlatılamadı; postgres çalışıyor (PID: %ld)
 %s: postmaster durdurulamadı; postgres çalışıyor (PID: %ld)
 %s:Çalıştırılabilir dosya bulunamadı
 %s: çalıştırılabilir postmaster programı bulunamadı
 %s: "%s" PID dosyası açılamadı: %s %s: "%s" servisi açılamadı: Hata kodu %d
 %s: servis yöneticisi açılamadı
 %s: "%s" dosyası okunamadı
 %s: "%s" servisi kaydedilemedi: Hata kodu %d
 %s: reload sinyali gönderilemedi (PID: %ld): %s
 %s: %d reload sinyali gönderilemedi (PID: %ld): %s
 %s:durdurma sinyali başarısız oldu (PID: %ld): %s
 %s: postmaster başlatılamadı
Kayıt dosyasını inceleyiniz
 %s: postmaster başlatılamadı: Çıkış kodu %d idi
 %s: "%s" servisi başlatılamadı: Hata kodu %d
 %s:  "%s" servisi kaydedilemedi: Hata kodu %d
 %s: geçersiz seçenek %s
 %s: kill modu için eksik argümanlar
 %s: postmaster ya da postgres çalışmıyor
 %s: Hiçbir veritabanı dizini belirtilmemiş ve PGDATA çevresel değişkeni boş
 %s: hiçbir işlem belirtilmedi
 %s: "%s" seçenek dosyası sadece 1 satır olmalıdır
 %s: yetersiz bellek
 %s: postmaster kapanmaz
 %s: postmaster çalışıyor (PID: %ld)
 %s: "%s" servisi daha önce kaydedilmiştir
 %s: "%s" servisi kayıtlı değil
 %s: çok fazla komut satırı argümanı (ilki : "%s")
 %s: geçersiz işlem modu "%s"
 %s: geçersiz kapanma modu "%s"
 %s: geçersiz sinyal adı "%s"
 (Ön tanımlı işlem kapanmak için beklemektir; ancak başlamak ya da yeniden başlamak değildir.)

 Eğer -D seçeneği gözardı edilirse, PGDATA çevresel değişkeni kullanılacaktır.
 postmaster çalışıyor mu?
 Lütfen postgres'i durdurun ve yeniden deneyin.
 "postmaster" programına %s tarafından gereksinim duyuluyor ancak 
"%s" ile aynı dizinde bulunamadı.
Kurulumunuzu kontrol ediniz.
 "postmaster" programı %s tarafından bulundu ancak "%s" ile aynı sürüm
numarasına sahip değil.
Kurulumunuzu kontrol ediniz.
 Daha fazla bilgi için "%s --help" komutunu kullanabilirsiniz.
 Kullanımı:
 alt süreç %d çıkış koduyla sonuçlandırılmıştır alt süreç %d bilinmeyen durumu ile sonlandırılmıştır alt süreç %d sinyali tarafından sonlandırılmıştır çalışma dizini "%s" olarak değiştirilemedi "%s"  çalıştırmak için bulunamadı geçerli dizin tespit edilemedi: %s "%s" ikili (binary) dosyası okunamadı symbolic link "%s" okuma hatası postmaster başlatılamadı
 geçersiz ikili (binary) "%s" postmaster kapatılıyor
 postmastera istenen sinyal gönderildi
 postmaster başlatıldı
 postmaster başlıyor
 postmaster durduruldu
 postmaster yine de başlatılıyor
 postmasterin kapanması bekleniyor... postmasterin başlaması bekleniyor... 