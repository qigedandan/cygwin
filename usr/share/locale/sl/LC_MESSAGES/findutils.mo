??    a      $  ?   ,      8  !   9  3   [  "   ?  )   ?  ?   ?     e	  s   ?	  q   ?	  $   f
     ?
  "   ?
     ?
  ,   ?
       %   -  ,   S  -   ?      ?  &   ?     ?          +     K  )   k  *   ?     ?     ?  !   ?     ?               7     N  <   d  b   ?  b     c   g  ?   ?     L  5   l  7   ?  ?   ?  ?   ?  ?   |       [   #       1   ?  3   ?  q   ?     l     r     x  ?   z     s     ?     ?  
   ?     ?     ?     ?     ?  !   ?          2     R     j     ?     ?  P   ?  )        1     P  (   g  )   ?     ?  )   ?  %   ?      #  ?   D  	    6        T  )  [     ?     ?  W   ?  I     +   J  q   v  >   ?  L   '  "   t  -   ?  ?   ?  $   ?  ?  ?  +   Z   9   ?   ,   ?   <   ?   z   *!     ?!  ?   ?!  ?   H"  $   ?"     ?"  &   #     :#  +   W#     ?#  #   ?#  +   ?#  ,   ?#      $  "   ?$     b$     $  !   ?$  !   ?$  +   ?$  ,   %     :%     =%     N%     i%     ?%     ?%     ?%     ?%  F   ?%  k   +&  k   ?&  d   '  ?   h'  $   ?'  5   (  ?   N(  ?   ?(  ?   v)  `   S*     ?*  ^   ?*     ,+  ;   C+  :   +  r   ?+     -,     3,     ;,  ?   >,     4-     N-     n-     ?-     ?-  '   ?-     ?-     ?-  "   ?-     ?-  '   .     <.     Y.  $   v.     ?.  ,   ?.  *   ?.  $   /     )/  $   D/  $   i/     ?/  6   ?/  #   ?/     0  ?   %0  V  1  @   ]2     ?2  *  ?2     ?3     ?3  _   ?3  A  W4  *   ?5  d   ?5  J   )6  M   t6  1   ?6  3   ?6  ?   (7     ?7     %   P   ]   _       M       G   `      Z                 O   ,   C       2          S   5   I   /       6   )       E       a          X            ^          	       +   7   K   '      4   R                  1      :   H   [       !   N              B       D   Q   F          Y   J      &      ;   <   ?              9      -       U   0   (       V         3      #   W           @      \   L       $       =   8              "                    .       >   A   T   
                 *    
	%s contain newline characters,  
	and %s contain characters with the high bit set.
 
	of which %s contain whitespace,  
Report bugs to <bug-findutils@gnu.org>.
 
default path is the current directory; default expression is -print
expression may consist of: operators, options, tests, and actions:
 %s terminated by signal %d %s%s changed during execution of %s (old device number %ld, new device number %ld, filesystem type is %s) [ref %ld] %s%s changed during execution of %s (old inode number %ld, new inode number %ld, filesystem type is %s) [ref %ld] %s: exited with status 255; aborting %s: illegal option -- %c
 %s: invalid number for -%c option
 %s: invalid option -- %c
 %s: option `%c%s' doesn't allow an argument
 %s: option `%s' is ambiguous
 %s: option `%s' requires an argument
 %s: option `--%s' doesn't allow an argument
 %s: option `-W %s' doesn't allow an argument
 %s: option `-W %s' is ambiguous
 %s: option requires an argument -- %c
 %s: stopped by signal %d %s: terminated by signal %d %s: unrecognized option `%c%s'
 %s: unrecognized option `--%s'
 %s: value for -%c option should be < %ld
 %s: value for -%c option should be >= %ld
 ' < %s ... %s > ?  Database %s is in the %s format.
 Features enabled:  GNU find version %s
 GNU findutils version %s
 GNU locate version %s
 GNU xargs version %s
 Invalid escape sequence %s in input delimiter specification. Invalid escape sequence %s in input delimiter specification; character values must not exceed %lo. Invalid escape sequence %s in input delimiter specification; character values must not exceed %lx. Invalid escape sequence %s in input delimiter specification; trailing characters %s not recognised. Invalid input delimiter specification %s: the delimiter must be either a single character or an escape sequence starting with \. Locate database size: %s bytes
 Maximum length of command we could actually use: %ld
 Only one instance of {} is supported with -exec%s ... + Report (and track progress on fixing) bugs via the findutils bug-reporting
page at http://savannah.gnu.org/ or, if you have no web access, by sending
email to <bug-findutils@gnu.org>. The current directory is included in the PATH environment variable, which is insecure in combination with the %s action of find.  Please remove the current directory from your $PATH (that is, remove "." or leading or trailing colons) The environment variable FIND_BLOCK_SIZE is not supported, the only thing that affects the block size is the POSIXLY_CORRECT environment variable Unknown system error Usage: %s [--version | --help]
or     %s most_common_bigrams < file-list > locate-database
 Valid arguments are: Warning: filesystem %s has recently been mounted. Warning: filesystem %s has recently been unmounted. You may not use {} within the utility name for -execdir and -okdir, because this is a potential security problem. ^[nN] ^[yY] ` actions: -delete -print0 -printf FORMAT -fprintf FILE FORMAT -print 
      -fprint0 FILE -fprint FILE -ls -fls FILE -prune -quit
      -exec COMMAND ; -exec COMMAND {} + -ok COMMAND ;
      -execdir COMMAND ; -execdir COMMAND {} + -okdir COMMAND ;
 ambiguous argument %s for %s argument line too long argument to --limit block size cannot fork cannot get current directory days double environment is too large for exec error waiting for %s error waiting for child process invalid -size type `%c' invalid argument %s for %s invalid argument `%s' to `%s' invalid expression invalid expression; I was expecting to find a ')' somewhere but did not see one. invalid expression; you have too many ')' invalid null argument to -size invalid predicate `%s' level higher in the filesystem hierarchy levels higher in the filesystem hierarchy missing argument to `%s' oops -- invalid default insertion of and! oops -- invalid expression type (%d)! oops -- invalid expression type! operators (decreasing precedence; -and is implicit where no others are given):
      ( EXPR )   ! EXPR   -not EXPR   EXPR1 -a EXPR2   EXPR1 -and EXPR2
      EXPR1 -o EXPR2   EXPR1 -or EXPR2   EXPR1 , EXPR2
 positional options (always true): -daystart -follow -regextype

normal options (always true, specified before other expressions):
      -depth --help -maxdepth LEVELS -mindepth LEVELS -mount -noleaf
      --version -xdev -ignore_readdir_race -noignore_readdir_race
 sanity check of the fnmatch() library function failed. single tests (N can be +N or -N or N): -amin N -anewer FILE -atime N -cmin N
      -cnewer FILE -ctime N -empty -false -fstype TYPE -gid N -group NAME
      -ilname PATTERN -iname PATTERN -inum N -iwholename PATTERN -iregex PATTERN
      -links N -lname PATTERN -mmin N -mtime N -name PATTERN -newer FILE unexpected extra predicate unknown unmatched %s quote; by default quotes are special to xargs unless you use the -0 option warning: Unix filenames usually don't contain slashes (though pathnames do).  That means that '%s %s' will probably evaluate to false all the time on this system.  You might find the '-wholename' test more useful, or perhaps '-samefile'.  Alternatively, if you are using GNU grep, you could use 'find ... -print0 | grep -FzZ %s'. warning: not following the symbolic link %s warning: the -d option is deprecated; please use -depth instead, because the latter is a POSIX-compliant feature. warning: the locate database can only be read from stdin once. warning: the predicate -ipath is deprecated; please use -iwholename instead. warning: unrecognized escape `\%c' warning: unrecognized format directive `%%%c' warning: you have specified the %s option after a non-option argument %s, but options are not positional (%s affects tests specified before it as well as those specified after it).  Please specify options before other arguments.
 with a cumulative length of %s bytes Project-Id-Version: findutils 4.2.27
Report-Msgid-Bugs-To: bug-findutils@gnu.org
POT-Creation-Date: 2007-06-09 18:49+0100
PO-Revision-Date: 2006-09-28 13:49+0200
Last-Translator: Primož Peterlin <primoz.peterlin@biofiz.mf.uni-lj.si>
Language-Team: Slovenian <translation-team-sl@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
 
        %s vsebuje znake za novo vrstico,  
        in %s vsebuje znake s postavljenim osmim bitom.
 
        med katerimi %s vsebuje presledke,  
Morebitne napake javite na naslov <bug-findutils@gnu.org>.
 
privzeta pot je trenutni imenik; privzeti izraz je -print
izraz lahko sestavljajo: operatorji, izbire, testi in dejanja:
 %s zaključen s signalom %d %s%s se je spremenila med izvajanjem %s (stara številka enote %ld, nova številka enote %ld, vrsta datotečnega sistema %s) [ref %ld] %s%s se je spremenila med izvajanjem %s (stara številka inoda %ld, nova številka inoda %ld, vrsta datotečnega sistema %s) [ref %ld]< %s: izhod s statusom 255; prekinjamo %s: nedovoljena izbira -- %c
 %s: neveljavno število za izbiro -%c
 %s: neveljavna izbira -- %c
 %s: izbira »%c%s« ne dovoljuje argumenta
 %s: izbira »%s« je dvoumna
 %s: izbira »%s« zahteva argument
 %s: izbira »--%s« ne dovoljuje argumenta
 %s: izbira »-W %s« ne dovoljuje argumenta
 %s: izbira »-W %s« je dvoumna
 %s: izbira zahteva argument -- %c
 %s: ustavljeno s signalom %d %s: zaključeno s signalom %d %s: neprepoznana izbira »%c%s«
 %s: neprepoznana izbira »--%s«
 %s: vrednost za izbiro -%c mora biti < %ld
 %s: vrednost za izbiro -%c mora biti >= %ld
 « < %s ... %s > ?  Zbirka %s je v %s obliki.
 Omogočene možnosti:  GNU find, različica %s
 GNU findutils, različica %s
 GNU locate, izdaja %s
 GNU xargs, izdaja %s
 Neveljavno ubežno zaporedje %s v specifikaciji vhodnega razmejilnika. Neveljavno ubežno zaporedje %s v specifikaciji vhodnega razmejilnika; vrednost znaka ne sme presegati %lo. Neveljavno ubežno zaporedje %s v specifikaciji vhodnega razmejilnika; vrednost znaka ne sme presegati %lx. Neveljavno ubežno zaporedje %s v specifikaciji vhodnega razmejilnika; neprepoznan sledilni znak %s. Neveljavno specifikacija vhodnega razmejilnika %s: razmejilnim mora biti bodisi en sam znak, bodisi ubežno zaporedje, ki se začenja z \. Velikost datoteke locate: %s bajtov
 Največja dolžina ukaza, ki ga lahko uporabimo: %ld
 Podprta je le enkratna navedba {} v kombinaciji z -exec%s ... + Napake lahko sporočate (in sledite napredek pri popravljanju) na spletni strani
za prijavljanje napak findutils, http://savannah.gnu.org/, ali, če nimate
dostopa do spleta, po elektronski pošti na naslov <bug-findutils@gnu.org>. Trenutni imenik je naveden v spremenljivki PATH, kar je nevarno v kombinaciji z dejanjem %s programa find. Prosim, odstranite trenutni imenik iz spremenljivke $PATH - odstranite ».« ter uvodna ali zaključna dvopičja. Spremenljivka FIND_BLOCK_SIZE ni podprta; na velikost bloka vpliva spremenljivka POSIXLY_CORRECT Neznana sistemska napaka Uporaba: %s [--version | --help]
ali      %s najpogostejši_bigrami < seznam > kodiran_seznam
 Veljavni argumenti so: Opozorilo: datotečni sistem %s je bil nedavno priklopljen. Opozorilo: datotečni sistem %s je bil nedavno odklopljen. Raba {} znotraj imena pomožnega programa za -execdir in -okdir zaradi mogočih varnostnih problemov ni dovoljena. ^[Nn] ^[DdJj] » actions: -delete -print0 -printf FORMAT -fprintf DATOTEKA FORMAT -print
      -fprint0 DATOTEKA -fprint DATOTEKA -ls -fls DATOTEKA -prune -quit
      -exec UKAZ ; -exec UKAZ {} + -ok UKAZ ;
      -execdir UKAZ ; -execdir UKAZ {} + -okdir UKAZ ;
 dvoumen argument %s za %s vrstica z argumenti je predolga argument za --limit velikost bloka vejitev ni mogoča trenutnega imenika ni mogoče ugotoviti dni dvojni okolje je preobsežno za klic exec napaka pri čakanju na %s napaka pri čakanju na proces naslednik neveljaven tip -size: »%c« neveljaven argument %s za %s neveljaven argument »%s« za »%s« neveljaven izraz neveljaven izraz: manjkajoč zaklepaj »)«. neveljaven izraz; preveč zaklepajev »)« neveljaven prazni argument pri -size neveljaven predikat »%s« raven višje v datotečni hierarhiji ravni višje v datotečni hierarhiji manjkajoč argument k »%s« opla - neveljavno privzeto vstavljanje logičnega ALI! opla -- neveljaven tip izraza (%d)! opla -- neveljaven tip izraza! operatorji (po padajoči prednosti; če ni podano nič drugega, se privzame -and):
      ( IZRAZ )   ! IZRAZ   -not IZRAZ   IZRAZ1 -a IZRAZ2   IZRAZ1 -and -IZRAZ2
      IZRAZ1 -o IZRAZ2   IZRAZ1 -or IZRAZ2   IZRAZ1 , IZRAZ2
 pozicijske izbire (vedno resnične): -daystart -follow -regextype

navadne izbire (vedno resnične, navedene pred drugimi izrazi):  
      -depth  --help -maxdepth RAVNI -mindepth RAVNI -mount -noleaf 
      --version -xdev -ignore_readdir_race -noignore_readdir_race
testi (N can be +N or -N or N): -amin N -anewer DATOTEKA -atime N -cmin N
 preizkus koherentnosti knjižnične funkcije fnmatch() ni uspel. enojni testi (N je lakko +N, -N ali N): -amin N -anewer FILE -atime N -cmin N
      -cnewer DATOTEKA -ctime N -empty -false -fstype TIP -gid N -group IME
      -ilname VZOREC -iname VZOREC -inum N -iwholename VZOREC -iregex VZOREC
      -links N -lname VZOREC -mmin N -mtime N -name VZOREC -newer DATOTEKA nepričakovan dodatni predikat neznano %s narekovaj brez para; privzeto so narekovaji za xargs posebni, razen če vključite izbiro -O opozorilo: Imena datotek v Unixu navadno ne vsebujejo poševnic (poti pa jih). To pomeni, da se bo »%s %s« na tem sistemu najverjetneje vedno ovrednotilo kot neresnično. Testa »-wholename« ali »-samefile« bosta morda uporabnejša. Če uporabljate GNU grep, lahko uporabite tudi »find ... -print0 | grep -FzZ %s«. opozorilo: simbolni povezavi %s ne sledimo opozorilo: raba izbire -d je odsvetovana; zaradi skladnosti s POSIX namesto nje priporočamo -depth. opozorilo: datoteko locate lahko preberemo s standardnega vhoda le enkrat. opozorilo: predikat -ipath odsvetujemo; priporočamo zamenjavo z -iwholename. opozorilo: neprepoznano ubežno zaporedje »\%c« opozorilo: neprepoznano formatno določilo »%%%c» opozorilo: izbiro %s ste navedli za neizbirnim argumentom %s, vendar izbire niso pozicijske (%s vpliva na teste, navadene pred njo in za njo). Prosimo, navedite izbire pred drugimi argumenti.
 s skupno dolžino %s bajtov 