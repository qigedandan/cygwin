??       ?     D   ?  
l      ?   ~  ?  p  h   ?  ?   F  ?   I  ?        0  9     j     |     ?   ,  ?     ?   %  ?   ,  !   -  N      |   &  ?     ?     ?   L     J  Q   -  ?   5  ?   (      L  )     v   D  ?   ?  ?   B     D  X     ?   I  ?   =     A  E   J  ?   =  ?   8     9  I   C  ?   F  ?   (     @  7   B  x   M  ?   K  	   8  U   ,  ?   J  ?   9     /  @   0  p   K  ?   $  ?   G     )  Z  V  ?   9  ?        G  4   A  |   <  ?   .  ?   C  *   ,  n   ?  ?   <  ?   E     B  ^   %  ?   5  ?   F  ?   .   D   >   s   >   ?   A   ?   8  !3   3  !l   #  !?   /  !?   D  !?   /  "9   4  "i   ?  "?   !  #?     #?   !  #?     #?   I  $   &  $O     $v     $?   I  $?   1  $?   &  %)     %P     %g     %?     %?   $  %?     %?     %?     &
     &     &$     &>     &]   #  &m     &?   '  &?   ?  &?   =  '?   '  '?     '?     '?   %  (     (-     (B     (T     (f     (x   "  (?   4  (?     (?   .  (?   "  ))   (  )L   *  )u   )  )?   !  )?   '  )?   )  *     *>      *N      *o     *?     *?  A  *?     ,     ,     ,0   1  ,B   2  ,t   0  ,?     ,?   #  ,?     -   )  -3   1  -]   -  -?     -?     -?     -?     .     .   "  .-   %  .P     .v     .?     .?     .?     .?   !  .?     .?     /  I  /   ?  0c  ?  0?   ?  2?   P  32   Y  3?   &  3?   :  4     4?     4\     4y   )  4?      4?   '  4?   *  5   *  53   #  5^   (  5?     5?     5?   O  5?   M  69   2  6?   H  6?   /  7   q  73      7?   K  7?   r  8   L  8?   w  8?   %  9J   K  9p   N  9?   C  :   l  :O   L  :?   \  ;	   @  ;f   M  ;?   F  ;?   .  <<   O  <k   J  <?   N  =   ?  =U   B  =?   4  >   N  >P   I  >?   +  >?   0  ?   `  ?F   ,  ??   <  ??   /  @    @A   I  B`   !  B?   ]  B?   J  C*   g  Cu   2  C?   O  D   ,  D`   D  D?   <  D?   L  E   Q  E\   *  E?   ;  E?   J  F   :  F`   >  F?   @  F?   E  G   ?  Ga   F  G?   +  G?   ,  H   J  HA   5  H?   I  H?   ?  I   *  J   (  J2   )  J[   '  J?   Z  J?   1  K   "  K:   $  K]   ]  K?   =  K?   2  L     LQ   "  Li     L?     L?   ,  L?     L?     M	     M(     M=      MT   '  Mu     M?   )  M?     M?   0  M?   ?  N$   O  N?   R  O#     Ov     O~   *  O?     O?   $  O?   $  O?   $  P     PC   %  Pa   7  P?     P?   :  P?   3  Q   8  QN   -  Q?   3  Q?   1  Q?   <  R   2  RX     R?   *  R?   0  R?   *  R?      S$  ?  SE     T?     T?     T?   5  U   :  UJ   :  U?     U?   &  U?     V   -  V"   >  VP   4  V?     V?     V?     W     W     W*   )  WG   6  Wq     W?     W?     W?     W?     W?   "  X     X$     XC          ?   v          ?             ?                 0   y      1      F   P       o      S                  #       a              j   8   A   x   <       \   D           g   ?   Y       T       K      ?   E   )   @   U   d   ?   ?       ^   c   2   R   ?   ?   ?      /      *       b       	   |   ?          `   i         4          Q   }       ?   f   :   ?      r   ?       L   
          +       q       ?          ?       ?   ?   ?       $   ?       ?       X   ?   u   .   ?   ?   n       6   ?   ?   [   M       J   '          O   ?          "   Z   7       ?   ?       (   W      G       V       z       C   {   ?   ?   _   B   5   %   ?   ?          m   ?   s           N   ?   h               ,           ?       p   ?   ;   =       t             I   ~              ?   ?       l       3   &   !   e         9       H           >   ]   -   k   w   Either GFMT or LFMT may contain:
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
 `-%ld' option is obsolete; omit it `-%ld' option is obsolete; use `-%c %ld' `-' specified for more than one input file both files to be compared are directories cannot compare `-' to a directory cannot compare file names `%s' and `%s' cannot interactively merge standard input cmp: EOF on %s
 conflicting %s option value `%s' conflicting output style options conflicting tabsize options conflicting width options ed:	Edit then use both versions, each decorated with a header.
eb:	Edit then use both versions.
el:	Edit then use the left version.
er:	Edit then use the right version.
e:	Edit a new version.
l:	Use the left version.
r:	Use the right version.
s:	Silently include common lines.
v:	Verbosely include common lines.
q:	Quit.
 extra operand `%s' incompatible options input file shrank internal error: invalid diff type in process_diff internal error: invalid diff type passed to output internal error: screwup in format of diff blocks invalid --bytes value `%s' invalid --ignore-initial value `%s' invalid context length `%s' invalid diff format; incomplete last line invalid diff format; incorrect leading line chars invalid diff format; invalid change separator invalid horizon length `%s' invalid tabsize `%s' invalid width `%s' memory exhausted missing operand after `%s' options -l and -s are incompatible pagination not supported on this host program error read failed stack overflow standard output subsidiary program `%s' failed subsidiary program `%s' not found too many file label options write failed Project-Id-Version: GNU diffutils 2.8.2
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2004-04-13 00:07-0700
PO-Revision-Date: 2002-06-13 19:39+0200
Last-Translator: Martin von L?wis <martin@v.loewis.de>
Language-Team: German <de@li.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8-bit
   Sowohl GFMT als auch LFMT k?nnen folgendes enthalten:
    %% %
    %c'C'  das einzelne Zeichen C
    %c'\000'  das Zeichen mit dem Oktalcode 000   GFMT kann enthalten:
    %<  Zeilen von DATEI1.
    %>  Zeilen von DATEI2.
    %=  Zeilen, die sowohl zu DATEI1 als auc zu DATEI2 geh?ren.
    %[-][BREITE][.[PR?Z]]{doxX}BUCHST  Ausgabe nach printf-Regeln f?r BUCHST.
      Folgende BUCHTSTaben gelten f?r neue Gruppen, Kleinschreibung f?r alte:
        F  Erste Zeilennummer.
        L  Letzte Zeilennummer.
        N  Zahl der Zeilen = L-F+1.
        E  F-1.   LFMT kann enthalten:
    %L  Inhalt der Zeile.
    %l  Inhalt der Zeile, ohne Newline am Ende.
    %[-][BREITE][.[PR?Z]]{doxX}n  Zeilennummer im printf-Stil.   LTYPE kann ?old?, ?new? oder ?unchanged? sein. GTYPE ist LTYPE oder ?changed?.   Die ersten SKIP1 Bytes von DATEI1 und die ersten SKIP2 Bytes von DATEI2
  ?berspringen. %s %s differieren: Byte %s, Zeile %s.
 %s %s differieren: Zeichen %s, Zeile %s ist %3o %s %3o %s
 %s: ?diff? ist gescheitert:  %s: ung?ltige Option -- %c.
 %s: ung?ltige Option -- %c
 %s: Option ?%c%s? erlaubt kein Argument.
 %s: Option ?%s? ist mehrdeutig.
 %s: Option ?%s? verlangt ein Argument.
 %s: Option ?--%s? verlangt kein Argument.
 %s: Option ?-W %s? erlaubt kein Argument.
 %s: Option ?-W %s? ist mehrdeutig.
 %s: Option verlangt ein Argument -- %c.
 %s: Unbekannte Option ?%c%s?.
 %s: Unbekannte Option ?--%s?.
 --GTYPE-group-format=GFMT   ?hnlich, GTYPE-Eingabe jedoch mit GFMT formatieren. --LTYPE-line-format=LFMT  ?hnlich, LTYPE-Eingabe jedoch mit LFMT formatieren. --binary  Daten im Bin?rmodus lesen und schreiben. --diff-program=PROGRAMM  PROGRAMM zum Vergleichen von Dateien verwenden. --from-file und --to-file sind beide angegeben. --from-file=DATEI1  DATEI1 mit allen Operanden vergleichen.
                    DATEI1 kann ein Verzeichnis sein. --help   Nur diese Hilfe zeigen. --horizon-lines=ZAHL   Behalte ZAHL Zeilen mit gemeinsamen Pre- und Suffix. --ignore-file-name-case  Unterschiede der Gro?/Kleinschreibung von Dateinamen
                         ignorieren. --line-format=LFMT   ?hnlich, aber alle Eingabe-Zeilen mit LFMT formatieren. --no-ignore-file-name-case  Unterschiede der Gro?/Kleinschreibung von 
                            Dateinamen beachten. --normal  Ein normales Diff ausgeben. --speed-large-files  Es werden gro?e Dateien und viele ?nderungen vermutet. --strip-trailing-cr  Wagenr?cklauf (CR) am Zeilenende beim Einlesen entfernen. --tabsize=ZAHL Tabulatorstopps sind alle ZAHL Spalten (Vorgabe: 8). --to-file=DATEI2  Alle Operanden mit DATEI2 vergleichen.
                  DATEI2 kann ein Verzeichnis sein. --unidirectional-new-file  Die ersten fehlenden Dateien als leer betrachten. -3, --easy-only   Nicht-zusammengef?hrte (`unmerged') nicht?berlappende ?nderungen ausgeben. -A  --show-all  Alle ?nderungen ausgeben, Konflikte in Klammern. -B, --ignore-blank-lines   Die ?nderungen ?bergehen, wo die Zeilen leer sind. -D NAME  --ifdef=NAME  Datei mit ?#ifdef NAME? in die Ausgabe mischen. Option -D nicht unterst?tzt bei Verzeichnissen -E  --ignore-tab-expansion  ?nderungen aufgrund von Tabausdehnungen ignorieren. -E  --show-overlap  Ungemische ?nderungen anzeigen, Konflikte in Klammern. -H --speed-large-files  Es werden gro?e Dateien und viele ?nderungen vermutet. -I RE --ignore-matching-lines=RE  ?nderungen ignorieren, deren Zeilen 
                                  auf das Muster RE passen. -L LABEL  --label=LABEL  LABEL anstelle des Dateinamens verwenden. -N --new-file  Fehlende Dateien als leer betrachten. -S DATEI  --starting-file=DATEI  Beim Verzeichnisvergleich mit DATEI beginnen. -T --initial-tab  Einr?ckungen durch vorangestellte Tabulatoren erzeugen. -W  -ignore-all-space  Leerraum ignorieren. -X  ?berlappende ?nderungen geklammert ausgeben. -X  DATEI  --exclude-from=DATEI  Dateien ?berspringen, die auf eines der Muster in DATEI passen. -a  --text  Betrachte alle Dateien als Text. -b  --ignore-space-change  Ignoriere ?nderungen im Leerraum. -b  --print-bytes  Verschiedene Bytes ausgeben.   -c, -C ZAHL, --context[=ZAHL]    ZAHL Zeilen des kopierten Kontextes ausgeben
                                   (Vorgabe: 3).
  -u, -U ZAHL, --unified[=ZAHL]    ZAHL Zeilen des "unifizierten" Kontextes ausgeben
                                   (Vorgabe: 3).
  --label LABEL                    LABEL statt Dateiname verwenden.
  -p, --show-c-function            Anzeigen, in welcher C-Funktion die Ver?nderung
                                   vorkommt.
  -F RE, --show-function-line=RE   Die n?chste Zeile anzeigen, auf die RE zutrifft. -d  --minimal  Aufwendig nach einem kleineren Satz von ?nderungen suchen. -e  --ed  Ein ed-Skript ausgeben. -e  --ed  Nicht in DEINEDATEI ?bernommene ?nderungen aus ALTEDATEI in MEINEDATEI abspeichern. -i  --ignore-case  Nicht zwischen Gro?- und Kleinschreibung unterscheiden. -i  --ignore-case  Unterschiede der Gro?/Kleinschreibung im Dateiinhalt 
                   ignorieren. -i  An ed-Skripte ?w?- und ?q?-Kommandos anh?ngen. -i SKIP  --ignore-initial=SKIP  Die ersten SKIP Bytes der Eingabe ?berspringen. -i SKIP1:SKIP2  --ignore-initial=SKIP1:SKIP2 -l  --left-column  Nur linke Spalte der gemeinsamen Zeilen ausgeben. -l  --paginate  Ausgabe an ?pr? zum Seitenumbruch ?bergeben. -l  --verbose  Bytenummern und Werte aller unterschiedlichen Bytes ausgeben. -m  --merge  Zusammengef?hrte Datei anstelle von ed-Skript ausgeben (Vorgabe -A). -n  --rcs  Ausgabe im Diff-Format von RCS. -n LIMIT  --bytes=LIMIT  H?chstens LIMIT Bytes vergleichen. -o DATEI  --output=DATEI  Interaktiv arbeiten, Ausgabe in DATEI speichern. -q  --brief  Nur ausgeben ob die Dateien verschieden sind. -r  --recursive  Rekursiv alle Unterverzeichnisse vergleichen. -s  -quiet  --silent  Keine Ausgabe; nur den Exit-Status setzen. -s  --report-identical-files  Meldung, wenn zwei Dateien gleich sind. -s  --suppress-common-lines  Keine gemeinsamen Zeilen ausgeben. -t  -expand-tabs  Tabulatoren zu Leerzeichen in der Ausgabe ausdehnen. -v  -version  Versionsinformation ausgeben. -w  --ignore-all-space  Freiraum ignorieren. -w ZAHL  --width=ZAHL  Maximal ZAHL Druckspalten pro Zeile (Vorgabe: 130). -x  --overlap-only  ?berlappende ?nderungen ausgeben. -x MUSTER --exclude=MUSTER  Dateien, die auf MUSTER passen, ausschlie?en. -y  -side-by-side  In zwei Spalten ausgeben.
  -W ZAHL  --width=ZAHL  Maximal ZAHL Zeichen pro Zeile ausgeben(Vorgabe: 130).
  --left-column  Nur linke Spalte gemeinsamer Zeilen ausgeben.
  ---suppress-common-lines  Keine gemeinsamen Zeilen ausgeben. Gemeinsame Unterverzeichnisse: %s und %s.
 Vergleichen Sie Dateien Zeile f?r Zeile. Drei Dateien Zeile f?r Zeile vergleichen. Zwei Dateien Byte f?r Byte vergleichen. DATEIEN sind 'DATEI1 DATEI2' oder 'VERZ1 VERZ2' oder "VERZ DATEI..." 
oder "DATEI... VERZ; Datei %s ist ein %s w?hrend Datei %s ein %s ist.
 Dateien %s und %s sind identisch.
 Dateien %s und %s sind verschieden.
 Wenn --from-file oder --to-file angegeben werden, gibt es keine 
Einschr?nkungen f?r DATEIEN. Wenn DATEI ?-? ist oder fehlt, von der Standardeingabe lesen. Wenn DATEI ?-? ist, von der Standardeingabe lesen. Ung?ltige R?ckreferenz. Ung?ltiger Name f?r Zeichenklasse. Ung?ltiges Sortierzeichen. Ung?ltiger Inhalt von \{\}. Ung?liger vorhergehender regul?rer Ausdruck. Ung?ltiges Bereichsende. Ung?ltiger regul?rer Ausdruck. Speicher verbraucht. Keine ?bereinstimmung. Kein Zeilenumbruch am Dateiende. Kein vorhergehender regul?rer Ausdruck. Nur in %s: %s.
 Vorzeitiges Ende des regul?ren Ausdrucks. Regul?rer Ausdruck zu gro?. Fehlerberichte bitte an <bug-gnu-utils@gnu.org>. SKIP-Werte d?rfen die folgenden multiplikativen Anh?nge haben:
kB 1000, K 1024, MB 1.000.000, M 1.048.576,
GB 1.000.000.000, G 1.073.741.824, und so weiter f?r T, P, E, Z, Y. SKIP1 und SKIP2 ist die Zahl der Bytes, die in jeder Datei ?bersprungen werden. Nebeneinanderstehenden Zusammenbringen (side-by-side merge) der Dateiunterschiede. Erfolg. Extra Backslash. ?%s --help? gibt Ihnen mehr Informationen. Unbekannter Systemfehler. ?ffnende ( oder \( ohne schlie?ende. Schlie?ende ) oder \) ohne ?ffnende. ?ffnende [ oder [^ ohne schlie?ende. ?ffnende \{ ohne schlie?ende. Aufruf: %s [OPTION]... DATEI1 DATEI2
 Aufruf: %s [OPTION]... DATEI1 [DATEI2 [SKIP1 [SKIP2]]]
 Aufruf: %s [OPTION]... DATEIEN
 Benutzung: %s [OPTION]... MEINEDATEI ALTEDATEI DEINEDATEI
 Die Option ?-%ld? ist veraltet; lassen Sie sie weg. Die Option ?-%ld? ist veraltet; verwenden Sie ?-%c %ld?. ?-? f?r mehr als eine Eingabedatei angegeben. Beide zu vergleichenden Dateien sind Verzeichnisse. ?-? kann nicht mit Verzeichnis verglichen werden. Die Dateinamen ?%s? und ?%s? k?nnen nicht verglichen werden. Kann nicht die Standardeingabe interaktiv mischen. cmp: EOF auf %s.
 Widerspr?chlicher Optionswert %s f?r ?%s?. Widerspr?chliche Optionenen f?r den Ausgabestil. Widerspr?chliche Tabulatorbreitenoptionen. Widerspr?chliche Breitenoptionen ed:\tEdieren, dann beide Versionen benutzen, jede mit einem Kopf dekoriert.
eb:\tEdieren, dann beide Versionen benutzen.
el:\tEdieren, dann linke Version benutzen.
er:\tEdieren, dann rechte Version benutzen.
e:\t Neue Version edieren.
l:\tLinke Version benutzen.
r:\tRechte Version benutzen.
s:\tSchweigend gemeinsame Zeilen ?bernehmen.
v:\tLauthals gemeinsame Zeilen ?bernehmen.
q:\tBeenden.
 extra Argument ?%s?. Inkompatible Optionen. Eingabedatei schrumpfte. Interner Fehler: Ung?ltiger diff-Typ in process_diff. Interner Fehler: Ung?ltiger diff-Typ an Ausgabe ?bergeben. Interner Fehler: Format f?r diff-Bl?cke ist durcheinander. ung?ltiger --bytes-Wert ?%s?. ung?ltiger --ignore-initial-Wert ?%s?. Ung?ltige Kontextl?nge ?%s?. Ung?ltiges Diff-Format; felende letzte Zeile. Ung?ltiges Diff-Format; inkorrektes Zeichen in f?hrender Zeile Ung?ltiges Diff-Format; ung?ltiger ?nderungstrenner. ung?ltige Horizontl?nge '%s'. Ung?ltige Tabulatorbreite ?%s?. Ung?ltig mit ?%s?. Speicher verbraucht. Fehlender Operand nach ?%s?. Die Optionen -l und -s sind inkompatibel. Seitenumbruch ist auf diesem System nicht unterst?tzt. Programmfehler Lesefehler. Stack?berlauf Standardausgabe Unterprogramm ?%s? schlug fehl. Unterprogramm ?%s? nicht gefunden. Zu viele Datei-Label-Optionen. Schreibfehler. 