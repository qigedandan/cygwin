??       ?     ?   ?  ,      ?   ~  ?  p  h   ?  ?   F  ?   I  ?        0  9     j     |     ?   ,  ?     ?   %  ?   ,  !   -  N      |   &  ?     ?     ?   L     J  Q   -  ?   5  ?   (      L  )     v   D  ?   ?  ?   B     D  X     ?   I  ?   =     A  E   J  ?   =  ?   8     9  I   C  ?   F  ?   (     @  7   B  x   M  ?   K  	   8  U   ,  ?   J  ?   9     /  @   0  p   K  ?   $  ?   G     )  Z  V  ?   9  ?        G  4   A  |   <  ?   .  ?   C  *   ,  n   ?  ?   <  ?   E      B   ^   %   ?   5   ?   F   ?   .  !D   >  !s   >  !?   A  !?   8  "3   3  "l   #  "?   /  "?   D  "?   /  #9   4  #i   ?  #?   !  $?     $?   !  $?     $?   I  %   &  %O     %v     %?   I  %?   1  %?   &  &)     &P     &g     &?     &?   $  &?     &?     &?     '
     '     '$     '>     ']   #  'm     '?   '  '?   ?  '?   =  (?   '  (?     (?     (?   %  )     )-     )B     )T     )f     )x   "  )?   4  )?     )?   .  )?   "  *)   (  *L   *  *u     *?   )  *?   !  *?   '  *?   )  +'     +Q     +h      +x      +?     +?     +?   	  +?  A  +?     -<     -O     -T     -i   1  -{   2  -?   0  -?     .   #  .,     .P   )  .l   1  .?   -  .?     .?     /     /'     /:     /K     /Y   "  /t   %  /?     /?     /?     /?     /?   	  /?     0     0     0     0,     0<   !  0[     0}     0?   
  0?     0?  M  0?   t  2  ?  2?   ?  4)   ?  4?   L  5t   '  5?   ;  5?     6%     67     6Q   &  6l     6?   %  6?   &  6?   '  6?     7%   &  7E     7l     7?   L  7?   L  7?   0  8F   ;  8w   7  8?   n  8?     9Z   O  9x   |  9?   D  :E   ?  :?      ;   L  ;5   O  ;?   c  ;?   j  <6   v  <?   ;  =   P  =T   E  =?     =?   %  >k   n  >?   m  ?    P  ?n   O  ??   G  @   F  @W   u  @?   M  A   4  Ab   /  A?   ?  A?   /  BJ   J  Bz   3  B?  ?  B?   ,  D?     D?   J  D?   ?  EE   t  E?   5  E?   ?  F0   ,  Fp   I  F?   7  F?   D  G   v  Gd   (  G?   :  H   O  H?   <  H?   G  H?   F  I   B  I[   :  I?   D  I?   -  J   4  JL   I  J?   /  J?   ?  J?    K;     LB      La   %  L?   $  L?   R  L?   7  M    !  MX     Mz   I  M?   9  M?   .  N     NM     Nm     N?      N?   %  N?   %  N?     O     O2     OD   :  OL     O?     O?   %  O?     O?   3  O?   ?  P+   J  P?   2  Q;     Qn     Qu   .  Q?      Q?     Q?     Q?     R     R,   '  RB   9  Rj     R?   3  R?   %  R?   *  S   1  SI     S{     S?   '  S?   3  S?   6  T     TE     Tb   )  T}   '  T?   /  T?     T?   	  U  v  U)     V?     V?     V?   !  V?   3  V?   7  W*   /  Wb   ,  W?   5  W?   /  W?   3  X%   C  XY   7  X?   .  X?   +  Y     Y0     YL     Y^      Yo   %  Y?      Y?     Y?     Y?     Y?     Z     Z     Z'   	  ZE     ZO     Zd   %  Zv   *  Z?     Z?   "  Z?     Z?     [      P              ?   Q   V   ?       /          ?   ?          S   ?   ?   ;       o   "   @   ?   F   r                      ?   ?   ?   2      G   1           A       y   O   |   ?   Y   f   )       k   4   ?   ?   g           H   L   0   :      \   `   X       ?          8   %   Z   <       i   #              N   .   ~               ?   ]   q   d          -       {   p       b      6       ?   ?       7   ,          a   B                 
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
PO-Revision-Date: 2002-11-20 15:54+0100
Last-Translator: Ernest Adrogu? Calveras <eadrogue@gmx.net>
Language-Team: Catalan <ca@dodds.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
   Tant FMTG com FMTL poden contenir:
    %%  %
    %c'C'  el car?cter C
    %c'\OOO'  el car?cter amb codi octal OOO   FMTG pot contenir:
    %<  l?nies de FITXER1
    %>  l?nies de FITXER2
    %=  l?nies comunes de FITXER1 i FITXER2
    %[-][AMPLADA][.[PRECISI?]]{doxX}LLETRA  espec. estil printf per a LLETRA
      LLETRA ?s una de les seg?ents pels grups nous (en min?scules pels vells):
        F  nombre de la primera l?nia
        L  nombre de l'?ltima l?nia
        N  nombre de l?nies del grup = L-F+1
        E  F-1
        M  L+1   FMTL pot contenir:
    %L  contingut de la l?nia
    %l  contingut de la l?nia sense el salt de l?nia final
    %[-][AMPLADA][.[PRECISI?]]{doxX}n  espec. estil printf pel nombre de l?nia   TIPUSL pot ser `old' (velles), `new' (noves), o `unchanged' (inalterades).
  TIPUSG pot ser qualsevol de TIPUSL o b? `changed' (alterades).   Ignora els primers SALT1 octets de FITXER1 i els primers SALT2 de FITXER2. %s i %s difereixen: octet %s, l?nia %s
 %s i %s difereixen: l'octet %s, l?nia %s, ?s %3o %s %3o %s
 %s: diff fallit:  %s: opci? il?legal -- %c
 %s: opci? no v?lida -- %c
 %s: l'opci? `%c%s' no admet arguments
 %s: l'opci? `%s' ?s ambigua
 %s: l'opci? `%s' requereix arguments
 %s: l'opci? `--%s' no admet arguments
 %s: l'opci? `-W %s' no admet arguments
 %s: l'opci? `-W %s' ?s ambigua
 %s: l'opci? requereix arguments -- %c
 %s: opci? no reconeguda `%c%s'
 %s: opci? no reconeguda `--%s'
 --TIPUSG-group-format=FMTG  Similar, per? formata els grups TIPUSG amb FMTG. --TIPUSL-line-format=FMTL  Similar, per? formata les l?nies TIPUSL amb FMTL. --binary  Escriu i llegeix dades en mode binari. --diff-program=PROGRAMA  Usa PROGRAMA per comparar fitxers. heu especificat ambdues opcions --from-file i --to-file --from-file=FITXER1  Compara FITXER1 amb tots els operands. FITXER1 pot ser
                     un directori. --help  Mostra aquesta ajuda. --horizon-lines=N?M  No descarta N?M l?nies que tinguin un prefix i sufix com?. --ignore-file-name-case  Ignora difer?ncies entre maj?scules i min?scules en
                         els noms dels fitxers. --line-format=FMTL  Similar, per? formata totes les l?nies amb FMTL. --no-ignore-file-name-case  Considera difer?ncies entre maj?scules i min?scules
                            quan compara noms de fitxers. --normal  Genera un diff normal. --speed-large-files  Assumeix fitxers grans i molts canvis petits dispersos. --strip-trailing-cr  Treu els car?cters finals de retorn de carro de l'entrada. --tabsize=N?M  Estableix la dist?ncia de tabulaci? en N?M (8 per omissi?)
               car?cters. --to-file=FITXER1  Compara tots els operands amb FITXER2. FITXER2 pot ser
                   un directori. --unidirectional-new-file  Tracta els fitxers primers inexistents com si
                           estiguessin buits. -3  --easy-only  Mostra els canvis no comuns i no solapats. -A  --show-all  Mostra tots els canvis, senyalant els conflictes amb separadors. -B  --ignore-blank-lines  Ignora canvis de l?nies que estan en blanc. -D NOM  --ifdef=NOM  Genera un fitxer combinat amb les difer?ncies expressades
                     en directives `#ifdef NOM'. l'opci? -D no funciona amb directoris -E  --ignore-tab-expansion  Ignora canvis provocats per la dist?ncia de
                            tabulaci?. -E  --show-overlap  Mostra els canvis no comuns, senyalant els conflictes amb
                    separadors. -H  --speed-large-files  Assumeix fitxers grans i molts canvis petits dispersos. -I ER  --ignore-matching-lines=ER  Ignora canvis en l?nies que encaixin amb ER. -L ETIQUETA  --label=ETIQUETA  Usa ETIQUETA en lloc del nom del fitxer. -N  --new-file  Considera els fitxers inexistents com si f?ssin buits. -S FITXER  --starting-file=FITXER  Comen?a amb FITXER quan es comparen
                                   directoris. -T  --initial-tab  Alinea el text de cada l?nia amb un car?cter de tabulaci?. -W  --ignore-all-space  Ignora tot l'espai en blanc. -X  Mostra els canvis solapats, amb separadors. -X FITXER  --exclude-from=FITXER  Exclou fitxers que coincideixen amb
                                  qualsevol patr? de FITXER. -a  --text  Tracta tots els fitxers com a text. -b  --ignore-space-change  Ignora canvis en la quantitat d'espai en blanc. -b  --print-bytes  Mostra els bytes que difereixen. -c  -C N?M  --context[=N?M]  Escriu N?M (3 per omissi?) l?nies de context
                             copiat.
-u  -U N?M  --unified[=N?M]  Escriu N?M (3 per omissi?) l?nies de context
                             unificat.
  --label ETIQUETA  Usa ETIQUETA en lloc del nom del fitxer.
  -p  --show-c-function  Mostra en quina funci? C es troba cada canvi.
  -F ER  --show-function-line=ER  Mostra la l?nia m?s recent que encaixi amb ER. -d  --minimal  Intenta trobar canvis m?nims. -e  --ed  Genera un script ed. -e  --ed  Mostra els canvis no comuns de FITXER-VELL a FITXER2 en FITXER1. -i  --ignore-case  No distingeix entre maj?scules i min?scules. -i  --ignore-case  Ignora difer?ncies entre maj?scules i min?scules en el
                   contingut dels fitxers. -i  Afegeix les instruccions `w' i `q' a l'script ed. -i SALT  --ignore-initial=SALT  Ignora els primers SALT octets. -i SALT1:SALT2  --ignore-initial=SALT1:SALT2 -l  --left-column  Nom?s escriu les l?nies en com? a la columna esquerra. -l  --paginate  Pagina la sortida amb el programa `pr'. -l  --verbose  Mostra la posici? i valor dels octets que difereixen. -m  --merge  Produeix un fitxer de canvis combinat en lloc d'un script ed
             (usant l'opci? -A per omissi?). -n  --rcs  Genera un diff en format RCS. -n L?MIT  --bytes=L?MIT  Compara com a m?xim L?MIT octets. -o FITXER  --output=FITXER  Opera interactivament, i envia la sortida a FITXER. -q  --brief  Indica tan sols si els fitxers difereixen o no. -r  --recursive  Compara recursivament qualsevol subdirectori existent. -s  --quiet  --silent  No escriu res; torna l'estat de sortida i prou. -s  --report-identical-files  Avisa quan dos fitxers s?n id?ntics. -s  --suppress-common-lines  No mostra les l?nies en com?. -t  --expand-tabs  Expandeix les tabulacions de la sortida a espais. -v  --version  Mostra la versi? del programa. -w  --ignore-all-space  Ignora tot l'espai en blanc. -w N?M  --width=N?M  No m?s de N?M (130 per omissi?) car?cters per l?nia. -x  --overlap-only  Mostra els canvis solapats. -x PAT  --exclude=PAT  Exclou fitxers que coincideixen amb PAT. -y  --side-by-side  Disposa el resultat en dues columnes.
  -W N?M  --width=N?M  No m?s de N?M (130 per omissi?) car?cters per l?nia.
  --left-column  Nom?s mostra les l?nies en com? a la columna esquerra.
  --suppress-common-lines  No mostra les l?nies en com?. Subdirectoris comuns: %s i %s
 Compara fitxers l?nia per l?nia. Compara tres fitxers l?nia per l?nia. Compara dos fitxers octet per octet. FITXERS ?s `FITXER1 FITXER2' o b? `DIR1 DIR2' o `DIR FITXER...' o `FITXER... DIR'. El fitxer %s ?s un %s mentre que el fitxer %s ?s un %s
 Els fitxers %s i %s s?n id?ntics
 Els fitxers %s i %s difereixen
 Amb les opcions --from-file o --to-file no hi ha restriccions de FITXERS. Si un FITXER ?s `-' o falta, llegeix l'entrada est?ndard. Si FITXER ?s `-', llegeix l'entrada est?ndard. Refer?ncia cap enrera no v?lida Classe de car?cter no v?lida Car?cter de col?laci? no v?lid El contingut de \{\} no ?s v?lid Expressi? regular precedent no v?lida L?mit superior de l'interval no v?lid Expressi? regular no v?lida Mem?ria exhaurida Cap cas No hi ha cap car?cter de salt de l?nia al final del fitxer Cap expressi? regular pr?via Nom?s a %s: %s
 Final prematur de l'expressi? regular Expressi? regular massa gran Envieu informes d'errors a <bug-gnu-utils@gnu.org>. Els valors de SALT poden tenir els seg?ents sufixs multiplicadors:
kB per 1000, K per 1024, MB per 1.000.000, M per 1.048.576, GB per
1.000.000.000, G per 1.073.741.824, i aix? amb T, P, E, Z i Y. SALT1 i SALT2 s?n el nombre d'octets que es passen per alt de cada fitxer. Combina difer?ncies entre fitxers en dues columnes Succ?s Barra invertida al final Proveu `%s --help' per obtenir m?s informaci?. Error no identificat del sistema Signe ( o \( desaparellat Signe ) o \) desaparellat Signe [ o ^[ desaparellat Signe \{ desaparellat Sintaxi: %s [OPCI?]... FITXER1 FITXER2
 Sintaxi: %s [OPCI?]... FITXER1 [FITXER2 [SALT1 [SALT2]]]
 Sintaxi: %s [OPCI?]... FITXERS
 Sintaxi: %s [OPCI?]... FITXER1 FITXER-VELL FITXER2
 l'opci? `-%ld' ?s obsoleta; eviteu-la l'opci? `-%ld' ?s obsoleta; useu `-%c %ld' heu especificat `-' per m?s d'un fitxer d'entrada fitxer especial de blocs ambd?s fitxers s?n directoris no es pot comparar `-' amb un directori no es poden comparar els noms de fitxer `%s' i `%s' no es pot combinar interactivament l'entrada est?ndard fitxer especial de car?cters cmp: final de fitxer a %s
 el valor `%s' de l'opci? %s ?s conflictiu opcions d'estil de sortida conflictives opcions de dist?ncia de tabulaci? incompatibles opcions d'amplada incompatibles directori ed:	Edita i usa les dues versions, amb un encap?alament afegit.
eb:	Edita i usa les dues versions.
el:	Edita i usa la versi? de l'esquerra.
er:	Edita i usa la versi? de la dreta.
e:	Edita una nova versi?.
l:	Usa la versi? de l'esquerra.
r:	Usa la versi? de la dreta.
s:	Inclou les l?nies comunes silenciosament
v:	Inclou les l?nies comunes i informa amb loquacitat
q:	Surt.
 sobra l'operand `%s' cua FIFO opcions incompatibles el fitxer d'entrada s'ha encongit error intern: tipus de diff inv?lid en process_diff error intern: tipus de diff inv?lid passat a la sortida error intern: format dels blocs diff desmanegat el valor `%s' de l'opci? --bytes no ?s v?lid el valor `%s' de l'opci? --ignore-initial no ?s v?lid el nombre de l?nies de context `%s' no ?s v?lid el format diff no ?s v?lid: ?ltima l?nia incompleta el format diff no ?s v?lid: car?cters inv?lids al principi de l?nia el format diff no ?s v?lid: separador de canvis inv?lid el nombre de l?nies d'horitz? `%s' no ?s v?lid la dist?ncia de tabulaci? `%s' no ?s v?lida l'amplada `%s' no ?s v?lida mem?ria exhaurida cua de missatges falta un operand despr?s de `%s' les opcions -l i -s s?n incompatibles aquest host no suporta paginaci? error del programa lectura fallida fitxer ordinari buit fitxer ordinari sem?for objecte en mem?ria compartida connector desbordament de pila sortida est?ndard el programa subsidiari `%s' ha fallat no s'ha trobat el programa subsidiari `%s' enlla? simb?lic massa opcions d'etiqueta de fitxer fitxer estramb?tic error d'escriptura 