??    a      $  ?   ,      8  !   9  3   [  "   ?  )   ?  ?   ?     e	  s   ?	  q   ?	  $   f
     ?
  "   ?
     ?
  ,   ?
       %   -  ,   S  -   ?      ?  &   ?     ?          +     K  )   k  *   ?     ?     ?  !   ?     ?               7     N  <   d  b   ?  b     c   g  ?   ?     L  5   l  7   ?  ?   ?  ?   ?  ?   |       [   #       1   ?  3   ?  q   ?     l     r     x  ?   z     s     ?     ?  
   ?     ?     ?     ?     ?  !   ?          2     R     j     ?     ?  P   ?  )        1     P  (   g  )   ?     ?  )   ?  %   ?      #  ?   D  	    6        T  )  [     ?     ?  W   ?  I     +   J  q   v  >   ?  L   '  "   t  -   ?  ?   ?  $   ?  ?  ?  %   ?   G   ?   %   ?   7   !  ?   V!     ?!  ?   "  ?   ?"  *   3#     ^#  +   ~#  "   ?#  5   ?#  )   $  2   -$  5   `$  3   ?$  )   ?$  0   ?$  (   %%  +   N%  %   z%  %   ?%  /   ?%  0   ?%     '&     )&  #   :&  !   ^&     ?&     ?&     ?&     ?&  X   ?&  ?   5'  ?   ?'  ?   ](  ?   ?(  &   ?)  <   ?)  >   ?)  ?   $*  ?   ?*  ?   ?+     2,  a   J,  *   ?,  C   ?,  D   -  ~   `-     ?-     ?-     ?-    ?-  =   ?.     6/     T/     j/  !   v/  .   ?/     ?/     ?/  "   ?/  ,   ?/  2   #0  $   V0  8   {0  8   ?0     ?0  Q   1  8   X1  3   ?1     ?1  /   ?1  /   2     E2  <   e2  .   ?2  )   ?2  ?   ?2    ?3  ;   ?4  	   5    5     36  
   O6  ?   Z6  ?  ?6  B   ?8  {   ?8  U   J9  [   ?9  )   ?9  7   &:    ^:     g;     %   P   ]   _       M       G   `      Z                 O   ,   C       2          S   5   I   /       6   )       E       a          X            ^          	       +   7   K   '      4   R                  1      :   H   [       !   N              B       D   Q   F          Y   J      &      ;   <   ?              9      -       U   0   (       V         3      #   W           @      \   L       $       =   8              "                    .       >   A   T   
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
PO-Revision-Date: 2006-09-11 13:14+0100
Last-Translator: Emese Kovacs <emese@instantweb.hu>
Language-Team: Hungarian <translation-team-hu@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.10.2
Plural-Forms: nplurals=2; plural=(n!=1);
 
	%s tartalmaz új sor karaktereket,  
	és %s tartalmaz beállított magas bittel rendelkező karaktereket.
 
	amelyből %s tartalmaz üreshely-,  
A hibákat a <bug-findutils@gnu.org> címen jelentsd.
 
az alapértelmezett útvonal az aktuális könyvtár; az alapértelmezett kifejezés -print, kifejezés lehet:
operátorok, kapcsolók, tesztek és tevékenységek:
 %s leállítva %d szignállal A(z) %s%s megváltozott a(z) %s végrehajtása során (régi eszközszám: %ld, új eszközszám: %ld, a fájlrendszer típusa: %s) [ref %ld] A(z) %s%s megváltozott a(z) %s végrehajtása során (régi inode szám: %ld, új inode szám: %ld, fájlrendszer típusa: %s) [ref %ld] %s: kilépési értéke 255; megszakítás %s: illegális kapcsoló -- %c
 %s: érvénytelen szám a -%c kapcsolóhoz
 %s: érvénytelen kapcsoló -- %c
 %s: a(z) "%c%s" kapcsoló nem enged meg argumentumot
 %s: a(z) "%s" kapcsoló nem egyértelmű
 %s: a(z) "%s" kapcsolóhoz argumentum szükséges
 %s: a(z) "--%s" kapcsoló nem enged meg argumentumot
 %s: a "-W %s" kapcsoló nem enged meg argumentumot
 %s: a "-W %s" kapcsoló nem egyértelmű
 %s: a kapcsoló egy argumentumot igényel -- %c
 %s: %d szignállal leállítva (stopped) %s: %d szignállal leállítva (terminated) %s: a(z) "%c%s" kapcsoló ismeretlen
 %s: a(z) "--%s" kapcsoló ismeretlen
 %s: a -%c kapcsoló értéke < %ld kell legyen
 %s: a -%c kapcsoló értéke >= %ld kell legyen
 " < %s ... %s > ?  A(z) %s adatbázis %s formátumú.
 Engedélyezett szolgáltatások:  GNU find %s verzió
 GNU findutils %s verzió
 GNU locate %s verzió
 GNU xargs %s verzió
 A(z) "%s" escape sorozat érvénytelen a bemenet elhatárolójának meghatározásában. A(z) "%s" escape sorozat érvénytelen a bemenet elhatárolójának meghatározásában; a karakterértékek nem léphetik túl a(z) %lo értéket. A(z) "%s" escape sorozat érvénytelen a bemenet elhatárolójának meghatározásában; a karakterértékek nem léphetik túl a(z) %lx értéket. A(z) "%s" escape sorozat érvénytelen a bemenet elhatárolójának meghatározásában ;a(z) %s záró karaktereket a program nem ismerte fel. A bemenet elhatárolójának "%s" meghatározása érvénytelen: az elhatároló vagy egy karakter, vagy egy \ kezdetű escape sorozat kell legyen. A locate adatbázis mérete: %s bájt
 A ténylegesen használható parancs maximális hossza: %ld
 Csak egyetlen {} példány támogatott a -exec%s ... + esetén A hibákat a findutils hibajelentő oldalán jelentheted be a
http://savannah.gnu.org/ címen, vagy e-mailben a <bug-findutils@gnu.org> címen. Az aktuális könyvtárat tartalmazza a PATH környezeti változó, amely nem biztonságos kombináció a find %s műveletével. Távolítsd el az aktuális könyvtárat a $PATH változóból (azaz a pontot vagy a kezdő/záró pontosvesszőt). A FIND_BLOCK_SIZE környezeti változó nem támogatott, egyedül a POSIXLY_CORRECT környezeti változó befolyásolja a blokkméretet. Ismeretlen rendszerhiba Használat: %s [--version | --help]
vagy %s most_common_bigrams < fájllista > locate-adatbázis
 Az érvényes argumentumok a következők: Figyelmeztetés: a(z) %s fájlrendszer nemrég csatlakoztatva lett. Figyelmeztetés: a(z) "%s" fájlrendszer nemrég le lett választva. A {} jel nem használható a -execdir és -okdir segédprogramjának nevében, mivel ez egy lehetséges biztonsági probléma. ^[nN] ^[iIyY] " tevékenységek: -delete -print0 -printf FORMÁTUM -fprintf FÁJL FORMÁTUM -print
      -fprint0 FÁJL -fprint FÁJL -ls -fls FÁJL -prune -quit
      -exec PARANCS; -exec PARANCS {} + -ok PARANCS ;
      -execdir PARANCS ; -execdir PARANCS {} + -okdir PARANCS ;
 a(z) "%s" argumentum nem egyértelmű a következőhöz: "%s" az argumentumsor túl hosszú a --limit argumentuma blokkméret fork() rendszerhívás sikertelen az aktuális könyvtár beolvasása sikertelen nap kettős a környezet túl nagy az exec-hez hiba a következőre várakozás közben: %s hiba a gyermekfolyamatra való várakozás közben a -size típusa ("%c") érvénytelen a(z) "%s" argumentum érvénytelen a következőhöz: %s A(z) "%s" argumentum érvénytelen a következőhöz: %s érvénytelen kifejezés érvénytelen kifejezés; a program egy ) jelre számított, de nem találta meg. érvénytelen kifejezés; túl sok ) karaktert tartalmaz érvénytelen null argumentum a -size kapcsolónál érvénytelen predikátum: "%s" szinttel feljebb a fájlrendszer-hierarchiában szinttel feljebb a fájlrendszer-hierarchiában A(z) "%s" argumentuma hiányzik hoppá -- az and alapértelmezett beszúrása érvénytelen! hoppá -- érvénytelen kifejezéstípus (%d)! hoppá -- érvénytelen kifejezéstípus! operátorok (csökkenő precedencia; alapértelmezett -and, ha nincs más megadva):
      ( KIF ) ! KIF -not KIF KIF1 -a KIF2 KIF1 -and KIF2
      KIF1 -o KIF2 KIF1 -or KIF2 KIF1 , KIF2
 helyzetérzékeny kapcsolók: (mindig igaz) -daystart -follow -regextype

normál kapcsolók (mindig igaz, más kifejezések előtt adandó meg):
      -depth --help -maxdepth SZINTEK -mindepth SZINTEK -mount -noleaf
      --version -xdev -ignore_readdir_race -noignore_readdir_race
 az fnmatch() könyvtári függvény vizsgálata sikertelen. egyszeres Tesztek (Az N +N, -N vagy N lehet): -amin N -anewer FILE -atime N -cmin N
-cnewer FÁJL -ctime N -empty -false -fstype TÍPUS -gid N -group NÉV
      -ilname MINTA -iname MINTA -inum N -ipath MINTA -iregex MINTA
      -links N -lname MINTA -mmin N -mtime N -name MINTA -newer FÁJL váratlan extra predikátum ismeretlen pár nélküli %s idézőjel; alapértelmezésben az idézőjelek speciálisak az xargs számára, hacsak nem használja a -0 kapcsolót figyelmeztetés: a Unix fájlnevek általában nem tartalmaznak / jeleket (noha az útvonalnevek igen). Ez azt jelenti, hogy a(z) "%s %s" értéke valószínűleg mindig hamis lesz ezen a rendszeren. Lehet, hogy a "-wholename" vagy a "-samefile" tesztet sokkal hasznosabbnak találnád. Ennek alternatívájaként, ha a GNU grep-et használod, akkor használhatod a következő parancsot: "find ... -print0 | grep -FzZ %s". figyelmeztetés: a(z) %s szimbolikus linket a rendszer nem követi figyelmeztetés: a -d kapcsoló elavult; helyette a -depth kapcsoló használandó, mivel az utóbbi felel meg a POSIX-nak. figyelmeztetés: a locate adatbázis csak egyszer olvasható a szabvány bemenetről. figyelmeztetés: a -ipath predikátum elavult; helyette használd a -iwholename kapcsolót. figyelmeztetés: ismeretlen escape: "\%c" figyelmeztetés: ismeretlen formátumelőírás: "%%%c" figyelmeztetés: a(z) %s kapcsolót a(z) %s nem kapcsoló argumentum után adtad meg, de a kapcsolók nem helyzetérzékenyek (a(z) %s hatással van mind az előtte, mind az utána található tesztekre). A kapcsolókat az egyéb argumentumok előtt kell megadni.
 összesített hossz: %s bájt 