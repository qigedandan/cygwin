??    \      ?     ?      ?  !   ?  3   ?  "   /  )   R  ?   |     	  s    	  q   ?	  $   
     +
  "   E
     h
  ,   ?
     ?
  %   ?
  ,   ?
  -          N  &   o     ?     ?     ?     ?  )     *   5     `     b  !   s     ?     ?     ?     ?     ?       5   $  7   Z  ?   ?  ?   J  ?   4     ?  [   ?     7  1   L  3   ~  q   ?     $     *     0  ?   2     +     H     _  
   s     ~     ?     ?     ?  !   ?     ?     ?     
     "     =     [  P   n  )   ?     ?       (     )   H     r  )   ?  %   ?      ?  ?   ?  	  ?  6   ?       )       =     X  W   `  I  ?  +     q   .  >   ?  L   ?  "   ,  -   O  ?   }  $   c  ?  ?  "   .  /   Q  "   ?  /   ?  ?   ?     a  ?   z  ?      $   ?      ?   &   ?      ?   +   !     B!  '   b!  +   ?!  ,   ?!  "   ?!  (   "     /"     H"  !   d"  !   ?"  8   ?"  9   ?"     #     #  %   .#     T#     l#     ?#     ?#     ?#  *   ?#  C   ?#  >   ?$  ?   ~$  ?   ^%  ?   G&     ?&  m   ?&     c'  =   z'  ?   ?'  ?   ?'     ?(     ?(     ?(     ?(     ?)     ?)     ?)     ?)     ?)     *     &*     +*  /   1*     a*  %   |*     ?*     ?*  !   ?*     ?*  I   +  '   U+  "   }+     ?+  1   ?+  3   ?+     ,  +   7,  "   c,     ?,  ?   ?,    x-  C   ?.     ?.  2  ?.     0  
   30  ?   >0  O  ?0  +   2  ?   <2  I   ?2  _   3  &   p3  2   ?3  ?   ?3  $   ?4        H   @                          ,       J   #   B       6   /      3   S             ;       ?          8   !   &       W                     :      Y   C       *   '                                 5   O   "         I   4       =   E           R   0      (              K   Z      V         L      \       .      [   M   F   P       )       $   
   Q   1   <                    -       +   	   A   N       U   9   7           T   %   X   G   D               2   >           
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
 Locate database size: %s bytes
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
 with a cumulative length of %s bytes Project-Id-Version: findutils 4.2.24
Report-Msgid-Bugs-To: bug-findutils@gnu.org
POT-Creation-Date: 2007-06-09 18:49+0100
PO-Revision-Date: 2005-08-01 12:00-0500
Last-Translator: Laurentiu Buzdugan <lbuz@rolix.org>
Language-Team: Romanian <translation-team-ro@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Plural-Forms: nplurals=2; plural=(n != 1);
 
	%s con?in caractele linie-nou?,  
	?i %s con?in caractere cu bitul ?nalt setat.
 
	din care %s con?in spa?ii albe,  
Raporta?i bug-uri la <bug-findutils@gnu.org>.
 
calea implicit? este directorul curent; expresia implicit? este -print
expresia poate fi compus? din: operatori op?iuni, teste ?i ac?iuni:
 %s terminat de semnal %d %s%s s-a schimbat ?n timpul execu?iei lui %s (vechiul nr. dispozitiv %ld, noul nr. dispozitiv %ld, tipul sistemului de fi?iere este %s) [ref %ld] %s%s s-a schimbat ?n timpul execu?iei lui %s (vechiul nr. inode %ld, noul nr. inode %ld, tipul sistemului de fi?iere este %s) [ref %ld] %s: a terminat cu starea 255; renun? %s: op?iune ilegal? -- %c
 %s: num?r invalid pentru op?iunea -%c
 %s: op?iune ilegal? -- %c
 %s: op?iunea `%c%s' nu permite un argument
 %s: op?iunea `%s' este ambigu?
 %s: op?iunea `%s' necesit? un argument
 %s: op?iunea `--%s' nu permite un argument
 %s: op?iunea `-W %s' nu permite un argument
 %s: op?iunea `-W %s' este ambigu?
 %s: op?iunea necesit? un argument -- %c
 %s: oprit de semnalul %d %s: terminat de semnalul %d %s: op?iune nerecunoscut? `%c%s'
 %s: op?iune nerecunoscut? `--%s'
 %s: valoarea pentru op?iunea -%c ar trebui s? fie < %ld
 %s: valoarea pentru op?iunea -%c ar trebui s? fie >= %ld
 ' < %s ... %s > ?  Baza de date %s este ?n formatul %s.
 Capabilit??i activate:  GNU find versiunea %s
 GNU findutils versiunea %s
 GNU locate versiunea %s
 GNU xargs versiunea %s
 Dimensiune baza de date locate: %s octe?i
 Lungimea mazim? a unei comenzi pe care o putem ?n fapt folosi: %ld
 Numai o singur? instan?? de {} este suportat? cu -exec%s ... + Raporta?i (?i urm?ri?i progresul repar?rii) bug-urilor folosind pagina de
raportare a bug-urilor din findutils de la http://savannah.gnu.org/ sau,
dac? nu ave?i acces la internet, trimi??nd email la <bug-findutils@gnu.org>. Directorul curent este inclus ?n variabila de mediu PATH, ceea ce este periculos (insecure) ?n combina?ie cu ac?iune %s a lui find.  V? rug?m ?ndep?rta?i directorul curent din $PATH (adic? ?ndep?rta?i "." sau primul sau ultimul ":") Variabila de mediu FIND_BLOCK_SIZE nu este suportat?, singurul lucru care afecteaz? dimensiunea blocului esre variabila de mediu POSIXLY_CORRECT Eroare de sistem necunoscut? Folosire: %s [--version | --help]
sau       %s cele_mai_comune_bigrame < list?-fisiere > baza-de-date-locate
 Argumente valide sunt: Avertisment: sistemul de fi?iere %s de fost montat de cur?nd. Avertisment: sistemul de fi?iere %s de fost demontat de cur?nd. Nu pute?i folosi {} ?n cadrul numelui utilitarului pentru -execdir ?i -okdir, pentru c? aceasta este o poten?ial? problem? de securitate. ^[nN] ^[yY] ` ac?iuni: -delete -print0 -printf FORMAT -fprintf FORMAT FI?IER -print 
      -fprint0 FI?IER -fprint FI?IER -ls -fls FI?IER -prune -quit
      -exec COMAND? ; -exec COMAND? {} + -ok COMAND? ;
      -execdir COMAND? ; -execdir COMAND? {} + -okdir COMAND? ;
 argument ambiguu %s pentru %s linie argumente prea lung? argument pentru --limit dimensiune bloc nu pot executa fork nu pot ob?ine directorul curent zile dublu mediul (environment) este prea larg pentru exec eroare a?tept?nd pentru %s eroare a?tept?nd pentru procese copil tip -size invalid `%c' argument invalid %s pentru %s argument invalid `%s' pentru `%s' expresie invalid? expresie invalid?; a?teptam s? g?sesc o ')' pe undeva, dar nu am g?sit-o. expresie invalid?; ave?i prea multe ')' argument null invalid pentru -size predicat invalid `%s' nivel mai ?nalt ?n ierarhia sistemului de fi?iere nivele mai ?nalte ?n ierarhia sistemului de fi?iere argument lips? pentru `%s' hopa -- inserare implicit? invalid? de and! hopa -- tip expresie invalid (%d)! hopa -- tip expresie invalid! operatori (preceden?a ?n sc?dere; -and este implicit c?nd al?ii nu sunt preciza?i):
      ( EXPR )   ! EXPR   -not EXPR   EXPR1 -a EXPR2   EXPR1 -and EXPR2
      EXPR1 -o EXPR2   EXPR1 -or EXPR2   EXPR1 , EXPR2
 op?iuni pozi?ionale (?ntotdeauna adev?rat): -daystart -follow -regextype

op?iuni normale (?ntotdeauna adev?rat, specificate ?naintea altor expresii):
      -depth --help -maxdepth LEVELS -mindepth LEVELS -mount -noleaf
      --version -xdev -ignore_readdir_race -noignore_readdir_race
 verificarea corectitudinii func?ie de bibliotec? fnmatch() a e?uat. singur teste (N poate fi +N sau -N sau N): -amin N -anewer FI?IER -atime N -cmin N
      -cnewer FI?IER -ctime N -empty -false -fstype TIP -gid N -group NUME
      -ilname PATTERN -iname PATTERN -inum N -iwholename PATTERN -iregex PATTERN
      -links N -lname PATTERN -mmin N -mtime N -name PATTERN -newer FI?IER predicat adi?ional nea?teptat necunoscut ghilimele %s f?r? pereche; ?n mod implicit ghilimelele sunt speciale pentru xargs, ?n afar? de cazul ?n care folosi?i op?iunea -0 avertisment: de obicei, numele de fi?iere ?n Unix nu con?in shash-uri (dar numele de c?i da).  Aceasta ?nseamn? c? '%s %s' va fi evaluat ca fals tot timpul pe acest sistem.  A?i putea g?si testul '-wholename' mai folositor, sau probabil '-samefile'.  Alternativ, dac? folosi?i GNU grep, pute?i folosi 'find ... -print0 | grep -FzZ %s'. avertisment: nu urmez leg?tura simbolic? %s avertisment: op?iunea -d nu mai este valid?; v? rug?m folosi?i -depth ?n locul lui, pentru c? aceasta din urm? respect? standardul POSIX. avertisment: baza de date locate poate fi doar citit? de la stdin o dat?. avertisment: predicatul -ipath nu mai este valid; v? rug? s? folosi?i -iwholename ?n locul lui. avertisment: escape nerecunoscut `\%c' avertisment: directiv? format nerecunoscut? `%%%c' avertisment: a?i specificat op?iunea %s dup? un argument non-op?iune %s, dar op?iunile nu sunt pozi?ionale (%s afecteaz? testele specificate ?nainte de el ca ?i cele specificate dup? el).  V? rug?m specifica?i op?iunile ?nainte de alte argumente.
 cu o lungime cumulativ? de %s octe?i 