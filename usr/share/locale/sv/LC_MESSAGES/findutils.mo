��    a      $  �   ,      8  !   9  3   [  "   �  )   �  �   �     e	  s   �	  q   �	  $   f
     �
  "   �
     �
  ,   �
       %   -  ,   S  -   �      �  &   �     �          +     K  )   k  *   �     �     �  !   �     �               7     N  <   d  b   �  b     c   g  �   �     L  5   l  7   �  �   �  �   �  �   |       [   #       1   �  3   �  q   �     l     r     x  �   z     s     �     �  
   �     �     �     �     �  !   �          2     R     j     �     �  P   �  )        1     P  (   g  )   �     �  )   �  %   �      #  �   D  	    6        T  )  [     �     �  W   �  I     +   J  q   v  >   �  L   '  "   t  -   �  �   �  $   �  h  �     9   4   X   %   �   `   �   ~   !     �!  w   �!  u   &"  '   �"     �"  !   �"     #  &   #     C#  %   a#  &   �#  ,   �#      �#  &   �#     #$     >$     Z$     s$  )   �$  *   �$     �$     �$     �$     %     ,%     A%     [%     r%  ?   �%  d   �%  d   -&  c   �&  �   �&  %   �'  ;   �'  /   �'  .  (  �   A)  q   *     �*  a   �*     �*  .   +  0   >+  x   o+     �+     �+     �+  �   �+     �,     -     +-     A-     N-  !   ]-     -     �-     �-     �-     �-     �-     �-      .     8.  _   I.  &   �.  !   �.     �.      	/  "   */     M/  /   g/  $   �/     �/  �   �/  	  �0  A   �1     �1  (  2     *3     A3  p   G3  U  �3  -   5  a   <5  D   �5  E   �5  $   )6  $   N6  �   s6  "   W7     %   P   ]   _       M       G   `      Z                 O   ,   C       2          S   5   I   /       6   )       E       a          X            ^          	       +   7   K   '      4   R                  1      :   H   [       !   N              B       D   Q   F          Y   J      &      ;   <   ?              9      -       U   0   (       V         3      #   W           @      \   L       $       =   8              "                    .       >   A   T   
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
PO-Revision-Date: 2006-05-23 22:33+0100
Last-Translator: Daniel Nylander <po@danielnylander.se>
Language-Team: Swedish <tp-sv@listor.tp-sv.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
 
	%s inneh�ller nyradstecken,  
	och %s inneh�ller tecken med den h�ga biten satt.
 
	av vilken %s inneh�ller blanksteg,  
Rapportera fel till <bug-findutils@gnu.org>
och synpunkter p� �vers�ttningen till <sv@li.org>.
 
standards�kv�g �r aktuell katalog; standarduttryck �r -print
uttryck kan best� av: operatorer, flaggor, tester och �tg�rder:
 %s avslutades av signal %d %s%s �ndrades under exekvering av %s (gammalt enhetsnummer %ld, nytt enhetsnummer %ld, filsystemstypen �r %s) [ref %ld] %s%s �ndrades under exekvering av %s (gammalt inodsnummer %ld, nytt inodsnummer %ld, filsystemstypen �r %s) [ref %ld] %s: avslutades med status 255; avbryter %s: otill�ten flagga -- %c
 %s: ogiltigt tal f�r flaggan -%c
 %s: ogiltig flagga -- %c
 %s: flaggan "%c%s" tar inget argument
 %s: flaggan "%s" �r tvetydig
 %s: flaggan "%s" kr�ver ett argument
 %s: flaggan "--%s" tar inget argument
 %s: flaggan "-W %s" till�ter inget argument
 %s: flaggan "-W %s" �r tvetydig
 %s: flaggan kr�ver ett argument -- %c
 %s: stoppades av signal %d %s: avslutades av signal %d %s: ok�nd flagga "%c%s"
 %s: ok�nd flagga "--%s"
 %s: v�rdet p� flaggan -%c ska vara < %ld
 %s: v�rdet p� flaggan -%c ska vara >= %ld
 " < %s ... %s > ?  Databasen %s �r i formatet %s.
 Aktiverade funktioner:  GNU find version %s
 GNU findutils version %s
 GNU locate version %s
 GNU xargs version %s
 Ogiltig specialsekvens %s i inmatningsavskiljarspecifikationen. Ogiltig specialsekvens %s i inmatningsavskiljarspecifikationen; teckenv�rden f�r inte �verstiga %lo. Ogiltig specialsekvens %s i inmatningsavskiljarspecifikationen; teckenv�rden f�r inte �verstiga %lx. Ogiltig specialsekvens %s i inmatningsavskiljarspecifikationen; efterf�ljande tecknen %s �r ok�nda. Ogiltig inmatningsavskiljarspecifikation %s: avskiljaren m�ste vara antingen ett enstaka tecken eller en specialsekvens som b�rjar med \. Storlek p� locate-databasen: %s byte
 Maximal l�ngd p� kommando som vi faktiskt kan anv�nda: %ld
 Endast en instans av {} st�ds med -exec%s ... + Rapportera (och f�lj r�ttningen av) fel genom felrapporteringssidan f�r
findutils p� http://savannah.gnu.org/ eller, om du inte har tillg�ng till
webben, genom att skicka e-post till <bug-findutils@gnu.org>. Skriv
felrapporter p� engelska om m�jligt.
Skicka synpunkter p� �vers�ttningen till sv@li.org. Den aktuella katalogen �r inkluderad i milj�variabeln PATH, vilket �r os�kert i kombination med �tg�rden %s f�r find. Ta bort aktuell katalog fr�n din $PATH (allts�, ta bort ".", inledande eller avslutande kolon) Milj�variabeln FIND_BLOCK_SIZE st�ds inte, det enda som p�verkar blockstorleken �r milj�variabeln POSIXLY_CORRECT Ok�nt systemfel Anv�ndning: %s [--version | --help]
eller       %s vanligaste_bigram < fillista > locate-databas
 Giltiga argument �r: Varning: filsystemet %s har nyligen monterats. Varning: filsystemet %s har nyligen avmonterats. Du kan inte anv�nda {} inom verktygsnamnet f�r -execdir och -okdir, p� grund av att det inneb�r en m�jlig s�kerhetsrisk. ^[nN] ^[jJyY] " �tg�rder: -delete -print0 -printf FORMAT -fprintf FIL FORMAT -print 
      -fprint0 FIL -fprint FIL -ls -fls FIL -prune -quit
      -exec KOMMANDO ; -exec KOMMANDO {} + -ok KOMMANDO ;
      -execdir KOMMANDO ; -execdir KOMMANDO {} + -okdir KOMMANDO ;
 tvetydigt argument %s f�r %s argumentraden �r f�r l�ng argument till --limit blockstorlek kan inte grena kan inte f� tag i aktuell katalog dagar dubbelt milj�n �r f�r stor f�r exec fel vid v�ntande p� %s fel vid v�ntande p� barnprocess ogiltig typ "%c" f�r -size ogiltigt argument %s f�r %s ogiltigt argument "%s" till "%s" ogiltigt uttryck ogiltigt uttryck; Jag f�rv�ntade mig att hitta ett ")"-tecken n�gonstans men kunde inte se ett. ogiltigt uttryck; du har f�r m�nga ")" tomt argument till -size ogiltigt ogiltigt predikat "%s" niv� h�gre i filsystemshierarkin niv�er h�gre i filsystemshierarkin argument till "%s" saknas hoppsan -- ogiltig standardins�ttning av "and"! hoppsan -- ogiltig uttryckstyp (%d)! hoppsan -- ogiltig uttryckstyp! operatorer (avtagande prioritetsordning; -and underf�rst�s n�r inga andra
anges):
      ( UTTR )   ! UTTR   -not UTTR   UTTR1 -a UTTR2   UTTR1 -and UTTR2
      UTTR1 -o UTTR2   UTTR1 -or UTTR2   UTTR1 , UTTR2
 positionsberoende flaggor (alltid sanna): -daystart -follow -regextype

normala flaggor (alltid sanna, anges f�re andra uttryck):
      -depth --help -maxdepth NIV�ER -mindepth NIV�ER -mount -noleaf
      --version -xdev -ignore_readdir_race -noignore_readdir_race
 funktionskontroll av biblioteksfunktionen fnmatch() misslyckades. enkelt tests (N kan vara +N, -N eller N): -amin N -anewer FIL -atime N -cmin N
      -cnewer FIL -ctime N -empty -false -fstype TYP -gid N -group NAMN
      -ilname M�NSTER -iname M�NSTER -inum N -iwholename M�NSTER -iregex M�NSTER
      -links N -lname M�NSTER -mmin N -mtime N -name M�NSTER -newer FIL ov�ntat extra predikat ok�nd citattecknet %s �r oavslutat; som standard �r citattecken speciella f�r xargs s�vida du inte anv�nder flaggan -0 varning: Unix-filnamn inneh�ller normalt sett inte snedstreck (�ven om s�kv�gar g�r det).  Det betyder att "%s %s" antagligen kommer alltid att bli falsk p� detta system.  Du kanske tycker testet "-wholename" �r anv�ndbart, eller kanske "-samefile".  Alternativt, om du anv�nder GNU grep, kunde du anv�nda "'find ... -print0 | grep -FzZ %s". varning: f�ljer inte den symboliska l�nken %s varning: flaggan -d �r f�r�ldrad; anv�nd -depth ist�llet, eftersom den senare st�ds enligt POSIX. varning: locate-databasen kan endast l�sas en g�ng fr�n standard in. varning: predikatet -ipath �r f�r�ldrat; anv�nd -iwholename ist�llet. varning: ok�nd kontrollsekvens "\%c" varning: ok�nt formatdirektiv "%%%c" varning: du har angivit flaggan %s efter argumentet %s som inte �r en flagga, men flaggor beror inte p� position (%s p�verkar test som �r angivna f�re den, liksom de som �r angivna efter den). Ange flaggor f�re andra argument.
 med en sammanlagd l�ngd p� %s byte 