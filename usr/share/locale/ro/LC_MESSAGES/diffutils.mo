??       ?     ?   ?  ,      ?   ~  ?  p  h   ?  ?   F  ?   I  ?        0  9     j     |     ?   ,  ?     ?   %  ?   ,  !   -  N      |   &  ?     ?     ?   L     J  Q   -  ?   5  ?   (      L  )     v   D  ?   ?  ?   B     D  X     ?   I  ?   =     A  E   J  ?   =  ?   8     9  I   C  ?   F  ?   (     @  7   B  x   M  ?   K  	   8  U   ,  ?   J  ?   9     /  @   0  p   K  ?   $  ?   G     )  Z  V  ?   9  ?        G  4   A  |   <  ?   .  ?   C  *   ,  n   ?  ?   <  ?   E      B   ^   %   ?   5   ?   F   ?   .  !D   >  !s   >  !?   A  !?   8  "3   3  "l   #  "?   /  "?   D  "?   /  #9   4  #i   ?  #?   !  $?     $?   !  $?     $?   I  %   &  %O     %v     %?   I  %?   1  %?   &  &)     &P     &g     &?     &?   $  &?     &?     &?     '
     '     '$     '>     ']   #  'm     '?   '  '?   ?  '?   =  (?   '  (?     (?     (?   %  )     )-     )B     )T     )f     )x   "  )?   4  )?     )?   .  )?   "  *)   (  *L   *  *u     *?   )  *?   !  *?   '  *?   )  +'     +Q     +h      +x      +?     +?     +?   	  +?  A  +?     -<     -O     -T     -i   1  -{   2  -?   0  -?     .   #  .,     .P   )  .l   1  .?   -  .?     .?     /     /'     /:     /K     /Y   "  /t   %  /?     /?     /?     /?     /?   	  /?     0     0     0     0,     0<   !  0[     0}     0?   
  0?     0?  e  0?   |  2%  ?  2?   ?  4=   L  5   J  5d   #  5?   6  5?     6
     6     66   )  6R     6|   (  6?   )  6?   *  6?   "  7   )  7=     7g     7?   V  7?   S  7?   -  8R   E  8?   3  8?   S  8?     9N   ?  9n   H  9?   B  9?   X  ::   "  :?   Q  :?   U  ;   U  ;^   Q  ;?   B  <   [  <I   F  <?   R  <?   a  =?   /  =?   O  =?   Z  >!   U  >|   a  >?   N  ?4   1  ??   P  ??   >  @   /  @E   A  @u   `  @?   -  A   >  AF   .  A?  ?  A?   G  C7      C   u  C?   J  D   G  Da   2  D?   M  D?   ,  E*   F  EW   G  E?   K  E?   T  F2   *  F?   :  F?   P  F?   1  G>   =  Gp   O  G?   M  G?   5  HL   A  H?   4  H?   /  H?   K  I)   >  Iu   E  I?   ?  I?      J?   !  K   #  K2   $  KV   X  K{   7  K?   !  L     L.   O  LI   J  L?   :  L?     M     M=     MZ     Mx   '  M?     M?   "  M?     M?     N   5  N   0  NL     N}   $  N?     N?   2  N?   ?  O    L  O?   -  P     P5   '  P<   3  Pd     P?     P?     P?     P?     P?   *  P?   <  Q%   "  Qb   A  Q?   )  Q?   2  Q?   =  R$     Rb   *  Rv   &  R?   0  R?   ;  R?     S5     SM   2  S]   1  S?     S?     S?     T   ?  T	     U?     U?     U?   !  U?   0  U?   >  V0   5  Vo     V?   *  V?      V?   ,  W   :  W<   4  Ww      W?     W?     W?     W?     X
     X!   %  X>   #  Xd     X?     X?     X?     X?     X?   %  X?     Y     Y
     Y      Y8   (  YW     Y?   %  Y?     Y?     Y?      P              ?   Q   V   ?       /          ?   ?          S   ?   ?   ;       o   "   @   ?   F   r                      ?   ?   ?   2      G   1           A       y   O   |   ?   Y   f   )       k   4   ?   ?   g           H   L   0   :      \   `   X       ?          8   %   Z   <       i   #              N   .   ~               ?   ]   q   d          -       {   p       b      6       ?   ?       7   ,          a   B                 
   ?               ?   ?   U       T       ?   t      x   }              s   ?               '   ?   D              [   J       ?   C   ?   ?   =   ?   K   v       !   $   j      ?         ?      ?   9           	   h       ?       ?         ?   M          ?   ?          I   E   ?   ?   ?   _   n          >       ?   ^   &   (       ?   +   W           *       ?      e   R       ?   w      ?       ?       3       c   ?   ?   u   5       z   ?   m   ?   l   ?   ?      ?      Either GFMT or LFMT may contain:
    %%  %
    %c'C'  the single character C
    %c'\OOO'  the character with octal code OOO   GFMT may contain:
    %<  lines from FILE1
    %>  lines from FILE2
    %=  lines common to FILE1 and FILE2
    %[-][WIDTH][.[PREC]]{doxX}LETTER  printf-style spec for LETTER
      LETTERs are as follows for new group, lower case for old group:
        F  first line number
        L  last line number
        N  number of lines = L-F+1
        E  F-1
        M  L+1   LFMT may contain:
    %L  contents of line
    %l  contents of line, excluding any trailing newline
    %[-][WIDTH][.[PREC]]{doxX}n  printf-style spec for input line number   LTYPE is `old', `new', or `unchanged'.  GTYPE is LTYPE or `changed'.   Skip the first SKIP1 bytes of FILE1 and the first SKIP2 bytes of FILE2. %s %s differ: byte %s, line %s
 %s %s differ: byte %s, line %s is %3o %s %3o %s
 %s: diff failed:  %s: illegal option -- %c
 %s: invalid option -- %c
 %s: option `%c%s' doesn't allow an argument
 %s: option `%s' is ambiguous
 %s: option `%s' requires an argument
 %s: option `--%s' doesn't allow an argument
 %s: option `-W %s' doesn't allow an argument
 %s: option `-W %s' is ambiguous
 %s: option requires an argument -- %c
 %s: unrecognized option `%c%s'
 %s: unrecognized option `--%s'
 --GTYPE-group-format=GFMT  Similar, but format GTYPE input groups with GFMT. --LTYPE-line-format=LFMT  Similar, but format LTYPE input lines with LFMT. --binary  Read and write data in binary mode. --diff-program=PROGRAM  Use PROGRAM to compare files. --from-file and --to-file both specified --from-file=FILE1  Compare FILE1 to all operands.  FILE1 can be a directory. --help  Output this help. --horizon-lines=NUM  Keep NUM lines of the common prefix and suffix. --ignore-file-name-case  Ignore case when comparing file names. --line-format=LFMT  Similar, but format all input lines with LFMT. --no-ignore-file-name-case  Consider case when comparing file names. --normal  Output a normal diff. --speed-large-files  Assume large files and many scattered small changes. --strip-trailing-cr  Strip trailing carriage return on input. --tabsize=NUM  Tab stops are every NUM (default 8) print columns. --to-file=FILE2  Compare all operands to FILE2.  FILE2 can be a directory. --unidirectional-new-file  Treat absent first files as empty. -3  --easy-only  Output unmerged nonoverlapping changes. -A  --show-all  Output all changes, bracketing conflicts. -B  --ignore-blank-lines  Ignore changes whose lines are all blank. -D NAME  --ifdef=NAME  Output merged file to show `#ifdef NAME' diffs. -D option not supported with directories -E  --ignore-tab-expansion  Ignore changes due to tab expansion. -E  --show-overlap  Output unmerged changes, bracketing conflicts. -H  --speed-large-files  Assume large files and many scattered small changes. -I RE  --ignore-matching-lines=RE  Ignore changes whose lines all match RE. -L LABEL  --label=LABEL  Use LABEL instead of file name. -N  --new-file  Treat absent files as empty. -S FILE  --starting-file=FILE  Start with FILE when comparing directories. -T  --initial-tab  Make tabs line up by prepending a tab. -W  --ignore-all-space  Ignore all white space. -X  Output overlapping changes, bracketing them. -X FILE  --exclude-from=FILE  Exclude files that match any pattern in FILE. -a  --text  Treat all files as text. -b  --ignore-space-change  Ignore changes in the amount of white space. -b  --print-bytes  Print differing bytes. -c  -C NUM  --context[=NUM]  Output NUM (default 3) lines of copied context.
-u  -U NUM  --unified[=NUM]  Output NUM (default 3) lines of unified context.
  --label LABEL  Use LABEL instead of file name.
  -p  --show-c-function  Show which C function each change is in.
  -F RE  --show-function-line=RE  Show the most recent line matching RE. -d  --minimal  Try hard to find a smaller set of changes. -e  --ed  Output an ed script. -e  --ed  Output unmerged changes from OLDFILE to YOURFILE into MYFILE. -i  --ignore-case  Consider upper- and lower-case to be the same. -i  --ignore-case  Ignore case differences in file contents. -i  Append `w' and `q' commands to ed scripts. -i SKIP  --ignore-initial=SKIP  Skip the first SKIP bytes of input. -i SKIP1:SKIP2  --ignore-initial=SKIP1:SKIP2 -l  --left-column  Output only the left column of common lines. -l  --paginate  Pass the output through `pr' to paginate it. -l  --verbose  Output byte numbers and values of all differing bytes. -m  --merge  Output merged file instead of ed script (default -A). -n  --rcs  Output an RCS format diff. -n LIMIT  --bytes=LIMIT  Compare at most LIMIT bytes. -o FILE  --output=FILE  Operate interactively, sending output to FILE. -q  --brief  Output only whether files differ. -r  --recursive  Recursively compare any subdirectories found. -s  --quiet  --silent  Output nothing; yield exit status only. -s  --report-identical-files  Report when two files are the same. -s  --suppress-common-lines  Do not output common lines. -t  --expand-tabs  Expand tabs to spaces in output. -v  --version  Output version info. -w  --ignore-all-space  Ignore all white space. -w NUM  --width=NUM  Output at most NUM (default 130) print columns. -x  --overlap-only  Output overlapping changes. -x PAT  --exclude=PAT  Exclude files that match PAT. -y  --side-by-side  Output in two columns.
  -W NUM  --width=NUM  Output at most NUM (default 130) print columns.
  --left-column  Output only the left column of common lines.
  --suppress-common-lines  Do not output common lines. Common subdirectories: %s and %s
 Compare files line by line. Compare three files line by line. Compare two files byte by byte. FILES are `FILE1 FILE2' or `DIR1 DIR2' or `DIR FILE...' or `FILE... DIR'. File %s is a %s while file %s is a %s
 Files %s and %s are identical
 Files %s and %s differ
 If --from-file or --to-file is given, there are no restrictions on FILES. If a FILE is `-' or missing, read standard input. If a FILE is `-', read standard input. Invalid back reference Invalid character class name Invalid collation character Invalid content of \{\} Invalid preceding regular expression Invalid range end Invalid regular expression Memory exhausted No match No newline at end of file No previous regular expression Only in %s: %s
 Premature end of regular expression Regular expression too big Report bugs to <bug-gnu-utils@gnu.org>. SKIP values may be followed by the following multiplicative suffixes:
kB 1000, K 1024, MB 1,000,000, M 1,048,576,
GB 1,000,000,000, G 1,073,741,824, and so on for T, P, E, Z, Y. SKIP1 and SKIP2 are the number of bytes to skip in each file. Side-by-side merge of file differences. Success Trailing backslash Try `%s --help' for more information. Unknown system error Unmatched ( or \( Unmatched ) or \) Unmatched [ or [^ Unmatched \{ Usage: %s [OPTION]... FILE1 FILE2
 Usage: %s [OPTION]... FILE1 [FILE2 [SKIP1 [SKIP2]]]
 Usage: %s [OPTION]... FILES
 Usage: %s [OPTION]... MYFILE OLDFILE YOURFILE
 `-%ld' option is obsolete; omit it `-%ld' option is obsolete; use `-%c %ld' `-' specified for more than one input file block special file both files to be compared are directories cannot compare `-' to a directory cannot compare file names `%s' and `%s' cannot interactively merge standard input character special file cmp: EOF on %s
 conflicting %s option value `%s' conflicting output style options conflicting tabsize options conflicting width options directory ed:	Edit then use both versions, each decorated with a header.
eb:	Edit then use both versions.
el:	Edit then use the left version.
er:	Edit then use the right version.
e:	Edit a new version.
l:	Use the left version.
r:	Use the right version.
s:	Silently include common lines.
v:	Verbosely include common lines.
q:	Quit.
 extra operand `%s' fifo incompatible options input file shrank internal error: invalid diff type in process_diff internal error: invalid diff type passed to output internal error: screwup in format of diff blocks invalid --bytes value `%s' invalid --ignore-initial value `%s' invalid context length `%s' invalid diff format; incomplete last line invalid diff format; incorrect leading line chars invalid diff format; invalid change separator invalid horizon length `%s' invalid tabsize `%s' invalid width `%s' memory exhausted message queue missing operand after `%s' options -l and -s are incompatible pagination not supported on this host program error read failed regular empty file regular file semaphore shared memory object socket stack overflow standard output subsidiary program `%s' failed subsidiary program `%s' not found symbolic link too many file label options weird file write failed Project-Id-Version: diffutils 2.8.3
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2004-04-13 00:07-0700
PO-Revision-Date: 2003-08-22 08:43+0300
Last-Translator: Eugen Hoanca <eugenh@urban-grafx.ro>
Language-Team: Romanian <translation-team-ro@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
  Una din GFMT sau LFMT poate con?ine:
    %%  %
    %c'C'  caracterul singular C
    %c'\OOO'  caracterul cu codul octal OOO   GFMT poate con?ine:
    %<  linii din FI?IER1
    %>  linii din FI?IER2
    %=  linii comune lui FI?IER1 si FI?IER2
    %[-][WIDTH][.[PREC]]{doxX}LETTER  specifica?ii stil printf pentru LETTER
      LETTERs sunt dup? cum urmeaz? pentru grup nou, liter? mic? pentru grup vechi:
        F  primul num?r de linie
        L  ultimul num?r de linie
        N  numere de linii = L-F+1
        E  F-1
        M  L+1   LFMT poate con?ine:
    %L  con?inut de linie
    %l  con?inut de linie, excluz?nd orice caracter de linie nou? final
    %[-][WIDTH][.[PREC]]{doxX}n  specifica?ii  stil printf-pentru introducerea num?rului de linie   LTYPE este `old', `new', sau `unchanged'.  GTYPE este LTYPE sau `changed'.   Omite primii OMIS1 octe?i din FI?IER1 ?i primii OMIS2 octe?i din FI?IER2 %s %s difer?: octetul %s, linia %s
 %s %s difer?: octetul %s, linia %s este %3o %s %3o %s
 %s: diff e?uat:  %s: op?iune ilegal? -- %c
 %s: op?iune invalid? -- %c
 %s: op?iunea `%c%s' nu permite parametri
 %s: op?iunea `%s' este ambigu?
 %s: op?iunea `%s' necesit? un parametru
 %s: op?iunea `--%s' nu permite parametri
 %s: op?iunea `-W %s' nu permite parametri
 %s: op?iunea `-W %s' este ambigu?
 %s: op?iunea necesit? un parametru -- %c
 %s: op?iune necunoscut? `%c%s'
 %s: op?iune necunoscut? `--%s'
 --GTYPE-group-format=GFMT  Similar, dar formatul de intrare GTYPE se grupeaz? cu GFMT. --LTYPE-line-format=LFMT  Similar, dar formateaz? liniile de intrare LTYPE cu LFMT. --binary  Cite?te ?i scrie date ?n mod binar. --diff-program=PROGRAM  Folose?te PROGRAM pentru a compara fi?ierele.  --from-file ?i --to-file sunt specificate ?mpreun? --from-file=FI?IER1  Compar? FI?IER1 cu to?i operanzii.  FI?IER1 poate fi director. --help  Tip?re?te acest ajutor. --horizon-lines=NUM  Re?ine NUM linii de prefix ?i sufix comun. --ignore-file-name-case  Ignor? cazul c?nd se compar? numele de fi?iere. --line-format=LFMT  Similar, dar formateaz? toate liniile cu LFMT. --no-ignore-file-name-case  Ia ?n calcul cazul atunci c?nd se compar? numele de fi?iere. --normal  Afi?eaz? un diff normal. --speed-large-files  Presupune fi?iere mari ?i multe modific?ri mici ?mpr??tiate. --strip-trailing-cr  Elimin? returul de car(carriage return) final la intrare(input). --tabsize=NUM  Opririle tab-ului vor fi la fiecare NUM (implicit 8) coloane tip?rite. --to-file=FI?IER2  Compar? to?i operanzii cu FI?IER2.  FI?IER2 poate fi director. --unidirectional-new-file  Trateaz? primele fi?iere lips? ca vide. -3  --easy-only  Afi?eaz? schimb?rile nesuprapuse(nonoverlapping) ?i nerezultate(unmerged). -A  --show-all  Afi?eaz? toate modific?rile, conflictele de paranteze. -B  --ignore-blank-lines  Ignor? schimb?rile unde toate liniile sunt goale(blank). -D NUME  --ifdef=NUME  Afi?eaz? fi?ierul rezultat(merged) pentru a ar?ta diff-urile`#ifdef NAME'. op?iunea -D nu este compatibil? cu directoarele -E  --ignore-tab-expansion  Ignor? schimb?rile produse de modificarea tab-ului. -E  --show-overlap  Afi?eaz? modific?rile nerezultate(unmerged), conflictele de paranteze. -H  --speed-large-files  Presupune fi?iere mari ?i multe modific?ri mici ?mpr??tiate. -I RE  --ignore-matching-lines=RE  Ignor? schimb?rile la toate liniile care se potrivesc RE-ului. -L ETICHET?  --label=ETICHET?  Folose?te ETICHET? ?n loc de numele fi?ierului. -N  --new-file  Trateaz? fi?ierele lips? ca vide. -S FI?IER  --starting-file=FI?IER  ?ncepe cu FI?IER ?n compararea directoarelor. -T  --initial-tab  Aliniaz? tab-urile ad?ug?nd ?n fa?? un tab. -W  --ignore-all-space  Ignor? tot spa?iul gol. -X  Afi?eaz? schimb?rile de suprapunere, pun?ndu-le ?n paranteze. -X FI?IER  --exclude-from=FI?IER  Exclude fi?ierele care se potrivesc oric?rui tipar din FI?IER. -a  --text  Trateaz? toate fi?ierele ca text. -b  --ignore-space-change  Ignor? schimb?rile din spa?iul vid. -b  --print-bytes  Tip?re?te octe?ii diferi?i. -c  -C NUM  --context[=NUM]  Tip?re?te NUM (implicit 3) linii de contextcopiat.
-u  -U NUM  --unified[=NUM]  Tip?re?te NUM (implicit 3) linii de contextunificat.
  --label ETICHET?  Folose?te ETICHET? ?n loc de nume fi?ier.
  -p  --show-c-function  Afi?eaz? fiecare schimbare din fiecare func?ie C.
  -F RE  --show-function-line=RE  Afi?eaz? cele mai recente linii care se potrivesc RE. -d  --minimal  ?ncearc? din greu s? g?se?ti un set mai mic de schimb?ri -e  --ed  Afi?eaz? un script ed. -e  --ed  Trimite(output) modific?rile nerezultate(unmerged) de la FI?IER_VECHI la  FI?IERUL_VOSTRU ?n FI?IERUL_MEU.. -i  --ignore-case  Consider? majusculele ?i minusculele ca fiind acelea?i. -i  --ignore-case  Ignor? diferen?ele de caz din con?inutul fi?ierului. -i  Adaug? comenzile `w' ?i `q' la scripturile ed. -i OMIS  --ignore-initial=OMIS  Omite primii octe?i OMISi din intrare(input). -i OMIS1:OMIS2  --ignore-initial=OMIS1:OMIS2 -l  --left-column  Afi?eaz? doar coloana din st?nga a liniilor comune. -l  --paginate  Trimite ie?irea(output) prin `pr' pentru a fi paginat?. -l  --verbose  Tip?re?te numerele octe?ilor ?i valorile octe?ilor diferi?i. -m  --merge  Afi?eaz? fi?ierul rezultat(merged) ?n loc de scriputl ed (implicit -A). -n  --rcs  Afi?eaz? un diff ?n format RCS. -n LIMIT?  --bytes=LIMIT?  Compar? cel mult LIMIT? octe?i. -o FI?IER  --output=FI?IER  Opereaz? interactiv, trimi??nd outputul spre FI?IER. -q  --brief  Afi?eaz? doar dac? fi?ierele difer?. -r  --recursive  Compar? recursiv orice subdirector ?nt?lnit. -s  --quiet  --silent  Nu tip?re?te nimic; anun??(yield) doar starea de ie?ire. -s  --report-identical-files  Raporteaz? c?nd dou? fi?iere sunt asem?n?toare. -s  --suppress-common-lines  Nu afi?a liniile comune. -t  --expand-tabs  Schimb? tab-urile ?n spa?ii la ie?ire(output). -v  --version  Tip?re?te informa?ii despre versiune. -w  --ignore-all-space  Ignor? tot spa?iul vid. -w NUM  --width=NUM  Afi?eaz? cel mult NUM (implicit 130) coloane tip?rite. -x  --overlap-only  Afi?eaz? toate schimb?rile de suprapunere. -x TIP  --exclude=TIP  Exclude fi?ierele care se potrivesc TIParului. -y  --side-by-side  Afi?eaz? pe dou? coloane.
  -W NUM  --width=NUM  Afi?eaz? cel mult NUM (implicit 130) coloane tip?rite.
  --left-column  Afi?eaz? doar coloana din st?nga a liniilor comune.
  --suppress-common-lines  Nu afi?a liniile comune. Subdirectoare comune: %s ?i %s.
 Compar? fi?ierele linie cu linie. Compar? trei fi?iere linie cu linie Compar? dou? fi?iere octet cu octet. FI?IEREle sunt `FI?IER1 FI?IER2' sau `DIR1 DIR2' sau `DIR FI?IER...' or `FI?IER... DIR'. Fi?ierul %s este un %s pe c?nd fi?ierul %s este un %s.
 Fi?ierele %s ?i %s sunt identice
 Fi?ierele %s ?i %s difer?
 Dac? --from-file sau --to-file sunt precizate, nu exist? restric?ii pe FI?IERE. Dac? un FI?IER este `-' sau lipse?te, se cite?te intrarea(input) standard. Dac? FI?IER este `-', se cite?te intrarea(input) standard. Referin?? precedent? invalid? Nume clas? caracter invalid? Caracter de comparare invalid Con?inut invalid al \{\} Expresie normal? de preceden?? invalid? Sf?r?it de domeniu invalid Expresie normal?(regular) invalid? Memorie plin? Nici o potrivire Nici un element de linie nou? la sf?r?itul fi?ierului Nu a existat nici o expresie normal? antecedent? Doar ?n %s: %s
 Sf?r?it prematur de expresie normal? Expresie normal? prea mare Raporta?i erorile(bugs)la <bug-gnu-utils@gnu.org>. Valorile OMIS pot fi urmate de urm?toarele sufixe multiplicative:
kB 1000, K 1024, MB 1,000,000, M 1,048,576,
GB 1,000,000,000, G 1,073,741,824, ?i a?a mai departe pentru T, P, E, Z, Y. OMIS1 ?i OMIS2 sunt numerele de octe?i care s? fie omi?i din fiecare fi?ier. Analiz? pas cu pas a diferen?elor de fi?iere. Succes Backslash de sf?r?it de linie(trailing) ?ncerca?i  `%s --help' pentru mai multe informa?ii. Eroare de sistem necunoscut? ( or \( ne?nchise ) or \) nedeschise [ sau [^ ne?nchise \{ ne?nchis? Folosire: %s [OP?IUNE]... FI?IER1 FI?IER2
 Folosire: %s [OP?IUNE]... FI?IER1 [FI?IER2 [OMIS1 [OMIS2]]]
 Folosire: %s [OP?IUNE]... FI?IERE
 Folosire: %s [OP?IUNE]... FI?IERUL_MEU FI?IER_VECHI FI?IERUL_T?U
 `-%ld' op?iunea este ?nvechit?; omite?i-o `-%ld' op?iunea este ?nvechit?; folosi?i `-%c %ld' `-' specificat pentru mai mult de un fi?ier de intrare(input) fi?ier bloc special ambele fi?iere de comparat sunt directoare nu se poate compara `-' cu un director nu se pot compara numele de fi?iere `%s' ?i `%s' nu poate rezulta(merge) interactiv intrarea(input) standard fi?ier caracter special cmp: EOF ?n %s
 Exist? un conflict cu %s ?n valoarea op?iunii `%s' Conflict ?n op?iunile stilului de afi?are(output) op?iuni m?rime tab ?n conflict op?iuni de lungime ?n conflict director ed:	Editeaz? apoi folose?te ambele versiuni, fiecare decorat? cu un cap de tabel.
eb:	Editeaz? apoi folose?te ambele versiuni.
el:	Editeaz? apoi folose?te versiunea din st?nga.
er:	Editeaz? apoi folose?te versiunea din dreapta.
e:	Editeaz? o versiune nou?.
l:	Folose?te versiunea din st?nga.
r:	Folose?te versiunea din dreapta.
s:	Include silen?ios liniile comune.
v:	Include detaliat liniile comune.
q:	Ie?ire.
 operand ?n plus(extra) `%s' fifo op?iuni incompatibile fi?ier de intrare(input) mic?orat eroare intern?: tip diff invalid ?n process_diff eroare intern?: tip invalid de diff trimis spre ie?ire(output) eroare intern?: z?p?ceal? ?n formatul blocurilor diff valoare --bytes invalid? `%s' invalid --se ignor? valoarea ini?ial? `%s' lungime invalid? de context `%s' format diff invalid; ultim?-linie incomplet? format diff invalid; caractere precedente liniei incorecte format diff invalid; separator de modificare invalid lungime de orizont invalid? `%s' m?rime tab invalid? `%s' lungime invalid? `%s' memorie plin? coad?(queue) de mesaje lipse?te operandul dup? `%s' op?iunile -l ?i -s sunt incompatibile pagina?ie nesuportat? de acest host eroare de program citire e?uat? fi?ier obi?nuit(regular) vid fi?ier obi?nuit semafor obiect memorie global?(shared memory) socket stiv? plin?(overflow) ie?ire(output) standard programul subsidiar `%s' e?uat programul subsidiar `%s' nu a fost g?sit leg?tur? simbolic? prea multe op?iuni de etichete fi?ier fi?ier ciudat scriere e?uat? 