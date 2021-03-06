??    {      ?  ?   ?      h
  K   i
     ?
  ^   ?
  
   *  >   5  =   t  -   ?     ?  #   ?       (   8     a  <   ~  9   ?  6   ?  H   ,  E   u  B   ?  6   ?  9   5  C   o  9   ?  4   ?  H   "  ;   k  E   ?  :   ?  9   (  7   b  4   ?  L   ?  J     3   g  0   ?  ;   ?  3     7   <  2   t  :   ?  5   ?  G     0   `  <   ?  M   ?  J     G   g  4   ?  H   ?  E   -  <   s  6   ?  I   ?  4   1  1   f  ;   ?  8   ?  5     =   C  8   ?  8   ?  9   ?  /   -  <   ]  #   ?  #   ?  ?   ?  #   "     F  3   f  &   ?  5   ?  E   ?  4   =  D   r     ?  *   ?  8      6   9  %   p  (   ?  (   ?  8   ?  #   !      E     f  8   ?  4   ?  $   ?       ,   9  ,   f     ?     ?  #   ?  G   ?  4   '     \  &   {     ?  )   ?  7   ?     !  +   6     b     s     ?     ?     ?  
   ?     ?     ?  9      >   B   P   ?      ?   &   ?      !  '   
!     2!     4!     7!     9!  H  =!  R   ?"     ?"  x   ?"     m#  U   |#  J   ?#  C   $  #   a$  .   ?$  %   ?$  -   ?$  &   %  @   /%  =   p%  :   ?%  E   ?%  B   /&  ?   r&  F   ?&  H   ?&  I   B'  @   ?'  =   ?'  K   (  <   W(  ]   ?(  ?   ?(  @   2)  D   s)  A   ?)  W   ?)  g   R*  9   ?*  8   ?*  8   -+  H   f+  B   ?+  @   ?+  H   3,  D   |,  L   ?,  G   -  M   V-  F   ?-  G   ?-  D   3.  ;   x.  N   ?.  K   /  J   O/  E   ?/  A   ?/  8   "0  :   [0  6   ?0  4   ?0  1   1  G   41  H   |1  5   ?1  B   ?1  ;   >2  [   z2  )   ?2  1    3  :   23  %   m3  ,   ?3  .   ?3  ,   ?3  @   4  M   ]4  =   ?4  H   ?4  &   25  >   Y5  P   ?5  I   ?5  &   36  )   Z6  .   ?6  9   ?6  :   ?6  -   (7  3   V7  >   ?7  1   ?7  &   ?7  +   "8  -   N8  -   |8     ?8     ?8  ;   ?8  M   9  7   k9  #   ?9  4   ?9  #   ?9  <    :  S   ]:     ?:  /   ?:     ?:  $   ;  +   *;  '   V;     ~;     ?;     ?;     ?;  4   ?;  C   ?;  N   -<     |<  7   ?<     ?<  2   ?<     =     =     =     =            r   X   j              M   A   K   V   {           "   (   ?       )       =   O   T   ,          v      U               >   &   J   !           g             p   	       7          [           Y   x       Z         ;   /   a       E           B   q   2              D   c   P   t   z       '       w   5       R   4   #   1      n   N   :   y   Q   $   .                 u               3       <          o   W                +   S   G   L   %      ^   ]   9           b   6   s   f   I                   m   _      \   `          -   l           0   h       i   k   H   F       *       
   C      @   e         d   8           
By default, a database with the same name as the current user is created.
 
Connection options:
 
If one of -a, -A, -d, -D, and USERNAME is not specified, you will
be prompted interactively.
 
Options:
 
Read the description of the SQL command CLUSTER for details.
 
Read the description of the SQL command VACUUM for details.
 
Report bugs to <pgsql-bugs@postgresql.org>.
   %s [OPTION]... DBNAME
   %s [OPTION]... LANGNAME [DBNAME]
   %s [OPTION]... [DBNAME]
   %s [OPTION]... [DBNAME] [DESCRIPTION]
   %s [OPTION]... [USERNAME]
   --help                          show this help, then exit
   --help                       show this help, then exit
   --help                    show this help, then exit
   --version                       output version information, then exit
   --version                    output version information, then exit
   --version                 output version information, then exit
   -A, --no-adduser          user cannot add new users
   -D, --no-createdb         user cannot create databases
   -D, --tablespace=TABLESPACE  default tablespace for the database
   -E, --encoding=ENCODING      encoding for the database
   -E, --encrypted           encrypt stored password
   -L, --pglib=DIRECTORY     find language interpreter file in DIRECTORY
   -N, --unencrypted         do not encrypt stored password
   -O, --owner=OWNER            database user to own the new database
   -P, --pwprompt            assign a password to new user
   -T, --template=TEMPLATE      template database to copy
   -U, --username=USERNAME      user name to connect as
   -U, --username=USERNAME   user name to connect as
   -U, --username=USERNAME   user name to connect as (not the one to create)
   -U, --username=USERNAME   user name to connect as (not the one to drop)
   -W, --password               prompt for password
   -W, --password            prompt for password
   -W, --password            prompt for password to connect
   -a, --adduser             user can add new users
   -a, --all                       vacuum all databases
   -a, --all                 cluster all databases
   -d, --createdb            user can create new databases
   -d, --dbname=DBNAME             database to vacuum
   -d, --dbname=DBNAME       database from which to remove the language
   -d, --dbname=DBNAME       database to cluster
   -d, --dbname=DBNAME       database to install language in
   -e, --echo                      show the commands being sent to the server
   -e, --echo                   show the commands being sent to the server
   -e, --echo                show the commands being sent to the server
   -f, --full                      do full vacuuming
   -h, --host=HOSTNAME          database server host or socket directory
   -h, --host=HOSTNAME       database server host or socket directory
   -i, --interactive         prompt before deleting anything
   -i, --sysid=SYSID         select sysid for new user
   -l, --list                show a list of currently installed languages
   -p, --port=PORT              database server port
   -p, --port=PORT           database server port
   -q, --quiet                     don't write any messages
   -q, --quiet                  don't write any messages
   -q, --quiet               don't write any messages
   -t, --table='TABLE[(COLUMNS)]'  vacuum specific table only
   -t, --table=TABLE         cluster specific table only
   -v, --verbose                   write a lot of output
   -z, --analyze                   update optimizer hints
 %s cleans and analyzes a PostgreSQL database.

 %s clusters all previously clustered tables in a database.

 %s creates a PostgreSQL database.

 %s creates a new PostgreSQL user.

 %s installs a procedural language into a PostgreSQL database.

 %s removes a PostgreSQL database.

 %s removes a PostgreSQL user.

 %s removes a procedural language from a database.

 %s: "%s" is not a valid encoding name
 %s: cannot cluster a specific table in all databases
 %s: cannot cluster all databases and a specific one at the same time
 %s: cannot vacuum a specific table in all databases
 %s: cannot vacuum all databases and a specific one at the same time
 %s: clustering database "%s"
 %s: clustering of database "%s" failed: %s %s: clustering of table "%s" in database "%s" failed: %s %s: comment creation failed (database was created): %s %s: could not connect to database %s
 %s: could not connect to database %s: %s %s: could not get current user name: %s
 %s: could not obtain information about current user: %s
 %s: creation of new user failed: %s %s: database creation failed: %s %s: database removal failed: %s %s: language "%s" is already installed in database "%s"
 %s: language "%s" is not installed in database "%s"
 %s: language installation failed: %s %s: language removal failed: %s %s: missing required argument database name
 %s: missing required argument language name
 %s: query failed: %s %s: query was: %s
 %s: removal of user "%s" failed: %s %s: still %s functions declared in language "%s"; language not removed
 %s: too many command-line arguments (first is "%s")
 %s: unsupported language "%s"
 %s: user ID must be a positive number
 %s: vacuuming database "%s"
 %s: vacuuming of database "%s" failed: %s %s: vacuuming of table "%s" in database "%s" failed: %s Are you sure? (y/n)  Database "%s" will be permanently removed.
 Enter it again:  Enter name of user to add:  Enter name of user to drop:  Enter password for new user:  Name Password:  Passwords didn't match.
 Procedural Languages Shall the new user be allowed to create databases? (y/n)  Shall the new user be allowed to create more new users? (y/n)  Supported languages are plpgsql, pltcl, pltclu, plperl, plperlu, and plpythonu.
 Trusted? Try "%s --help" for more information.
 Usage:
 User "%s" will be permanently removed.
 n no y yes Project-Id-Version: pgscripts-tr
POT-Creation-Date: 2004-12-14 19:09+0000
PO-Revision-Date: 2005-03-25 08:48+0200
Last-Translator: 
Language-Team:  <en@li.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.9.1
X-Poedit-Language: Turkish
X-Poedit-Country: TURKEY
 
Öntanımlı olarak , mevcut kullanıcı ile aynı adda veritabanı yaratılır.
 
Bağlantı seçenekleri:
 
Eğer-a, -A, -d, -D, ve USERNAME 'den en az birisi belirtilmezse, 
bu bilgiler size etkileşimli olarak sorulacaktır.
 
Seçenekler:
 
Ayrıntılar için bir SQL komutu olan CLUSTER'in açıklamasını okuyabilirsiniz.
 
Ayrıntılar için, bir SQL komutu olan VACUUM'un tanımlarını okuyun.
 
Hataları <pgsql-bugs@postgresql.org> adresine bildirebilirsiniz.
   %s [SEÇENEK]... VERİTABANI_ADI
   %s [SEÇENEK]... DİL_ADI [VERİTABANI_ADI]
   %s [SEÇENEK]... [VERİTABANI_ADI]
   %s [SEÇENEK]... [VERİTABANI_ADI] [TANIM]
   %s [SEÇENEKLER]... [KULLANICI_ADI]
   --help                          bu yardımı göster ve çık
   --help                       bu yardımı göster ve çık
   --help                    bu yardımı göster ve çık
   --version                       sürüm bilgisini göster ve çık
   --version                    sürüm bilgisini göster ve çık
   --version                 sürüm bilgisini göster ve çık
   -A, --no-adduser          kullanıcı yeni kullanıcılar ekleyemez
   -D, --no-createdb         eklenecek kullanıcı veritabanı yaratamaz
   -D, --tablespace=TABLESPACE  veritabanı için öntanımlı tablespace
   -E, --encoding=ENCODING      veritabanı için dil kodlaması
   -E, --encrypted           saklanan şifreleri encrypt eder
   -L, --pglib=DİZİN     DİZİN dizini içindeki dil interpreterini bul.
   -N, --unencrypted         saklanmış şifreyi kriptolama
   -O, --owner=OWNER            Yeni veritabanının sahibi olacak veritabanı kullanıcısı
   -P, --pwprompt            yeni kullanıcıya bir şifre atar
   -T, --template=TEMPLATE      kopyalanacak şablon veritabanı
   -U, --username=KULLANICI_ADI      bağlanılacak kullanıcı adı
   -U, --username=KULLANICI_ADI   bağlanılacak kullanıcı adı
   -U, --username=KULLANICI_ADI   bağlanılacak kullanıcı adı (yaratılacak değil)
   -U, --username=KULLANICI _ADI   bağlanırken kullanılacak kullanıcı adı (silinecek olan değil)
   -W, --password               şifre sormasını sağla
   -W, --password            şifre sorulmasını sağla
   -W, --password            bağlanmak için şifre sor
   -a, --adduser             kullanıcı yeni kullanıcılar ekleyebilir
   -a, --all                       tüm veritabanlarını vakumlar
   -a, --all                 tüm veritabanlarını cluster eder
   -d, --createdb            kullanıcı yeni veritabanları ekleyebilir
   -d, --dbname=VERİTABANI_ADI             vakumlanacak veritabanı
   -d, --dbname=VERİTABANI_ADI       dilin sileneceği veritabanının adı
   -d, --dbname=VERİTABANI_ADI       cluster edilecek veritabanı adı
   -d, --dbname=VERİTABANI_ADI       dilin kurulacağı veritabanının adı
   -e, --echo                      sunucuya gönderilen komutları yaz
   -e, --echo                   sunucuya gönderilen komutları göster
   -e, --echo                sunucuya gönderilen komutları göster
   -f, --full                      tam (FULL) vakumlama yap
   -h, --host=HOSTNAME          veritabanı sunucusu adresi ya da soket dizini
   -h, --host=HOSTNAME       veritabanı sunucusu adresi ya da soket dizini
   -i, --interactive         herhangi birşeyi silmeden önce uyarı verir
   -i, --sysid=SYSID         yeni kullanıcı için sysid'yi belirler
   -l, --list                Şu anda kurulu olan dilleri göster
   -p, --port=PORT              veritabanı sunucu portu
   -p, --port=PORT           veritabanı sunucusunun portu
   -q, --quiet                     hiçbir mesaj yazma
   -q, --quiet                  Hiç bir mesaj yazma
   -q, --quiet               hiçbir ileti yazmaz
   -t, --table='TABLO[(KOLONLAR)]'  sadece belirli bir tabloyu vakumlar
   -t, --table=TABLO_ADI         sadece belirli bir tabloyu cluster eder
   -v, --verbose                   bolca çıktı yaz
   -z, --analyze                   optimizer bilgilerini güncelle
 %s bir PostgreSQL veritabanını temizler ve analiz eder.

 %s Konutu bir veritabanında daha önceden cluster edilmiş tüm tabloları cluster eder.

 %s bir PostgreSQL veritabanı yaratır.

 %s yeni bir PostgreSQL kullanıcısı yaratır.

 %s Bir PostgreSQL veritabanına yordamsal bir dil kurar.

 %s PostgreSQL veritabanını siler.

 %s bir PostgreSQL kullanıcısını siler.

 %s veritabanından yordamsal bir dili siler.

 %s: "%s" geçerli bir dil kodlaması değil
 %s: tüm veritabanlarındaki belirli tablolar cluster edilemez.
 %s: Aynı anda tüm veritabanları ve de belirli bir tanesi cluster edilemez
 %s: Tüm veritabanlarındaki belirli bir tablo vakumlanamaz.
 %s:Aynı anda tüm veritabanları ve de belirli bir tanesi vakumlanamaz
 %s: "%s" veritabanı cluster ediliyor
 %s: "%s" veritabanının cluster işlemi başarısız oldu: %s %s: "%s"tablosunun ("%s" veritabanındaki) cluster işlemi başarısız oldu: %s %s: yorum yaratma işlemi başarısız oldu (veritabanı yaratıldı): %s %s: %s veritabanına bağlanılamadı
 %s: %s veritabanına bağlanılamadı: %s %s: geçerli kullanıcı adı alınamadı: %s
 %s: geçerli kullanıcı hakkında bilgi alınamadı: %s
 %s: yeni kullanıcı yaratma işlemi başarısız oldu: %s %s: veritabanı yaratma başarısız oldu: %s %s: veritabanı silme işlemi başarısız oldu: %s %s: "%s" dili daha önceden veritabanına yüklenmiştir "%s"
 %s: "%s" dili "%s" veritabanında kurulu değil 
 %s: Dil kurulumu başarısız oldu: %s %s: dil silme işlemi başarısız oldu: %s %s: Gerekli argüman eksik: Veritabanı adı
 %s: Gerekli bir argüman olan dil adı eksik
 %s: sorgu başarısız oldu: %s %s: sorgu şu idi: %s
 %s: "%s" kullanıcısının silinmesi başarısız oldu: %s %s: %s fonksiyon, "%s" dilinde tanımlanmış durumda;  dil kaldırılamadı
 %s: Çok sayıda komut satırı argümanı (ilki "%s")
 %s: "%s" dili desteklenmemektedir.
 %s: kullanıcı ID'si pozitif bir sayı olmalıdır
 %s: "%s" veritabanı vakumlanıyor
 %s: "%s" veritabanının vakumlanması başarısız oldu: %s %s: "%s" tablosunun ("%s" veritabanındaki) vakumlama işlemi başarısız oldu: %s Emin misiniz? (y/n) "%s" veritabanı kalıcı olarak silinecektir.
 Yeniden girin:  Eklenecek kullanıcı adını girin: Silinecek kullanıcının adını giriniz:  Yeni kullanıcı için şifreyi girin:  Adı Şifre:  Şifreler uyuşmadı.
 Yordamsal Diller Yeni kullanıcı veritabanı yaratabilsin mi? (y/n)  Yeni kullanıcı daha fazla yeni kullanıcı yaratabilsin mi? (y/n) Desteklenen diller plpgsql, pltcl, pltclu, plperl, plperlu, ve plpythonu'dur.
 Güvenilir mi? Daha fazla bilgi için "%s --help" komutunu deneyiniz.
 Kullanımı:
 "%s" kullanıcısı kalıcı olarak silinecektir.
 n hayır y evet 