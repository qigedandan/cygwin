??    4      ?  G   \      x  
  y  0  ?  t  ?  $   *    O  v  c     ?     ?       ,         M  %   k  ,   ?  -   ?      ?  &        4     T     t     v     ?  E   ?     ?     ?  ?   
  (   ?     ?  ?   ?  &   n     ?     ?     ?     ?     ?  )   ?  (        8     :     Y     u     ?     ?     ?     ?     ?     ?          (     ?     Z     k  H  z  t  ?  4  8  4  m  0   ?$    ?$  ?  ?%     ?'     ?'     ?'  )   ?'  $   (      B(  )   c(  *   ?(  '   ?(  !   ?(     )     ")     B)     D)  !   Z)  I   |)     ?)     ?)  ?   ?)  '   ?*     ?*  ?   ?*  /   ?+     ?+     ?+     ?+     ?+     ?+  )   ,  )   <,     f,     h,  /   ?,  %   ?,  "   ?,  !   ?,     -     --  )   :-     d-     ?-  %   ?-  &   ?-     ?-     ?-     $                    /      ,      0      "               -   )   *   3          4                                                  &             2          '   %          !                1                     
       .   (   +   	   #                 
Context control:
  -B, --before-context=NUM  print NUM lines of leading context
  -A, --after-context=NUM   print NUM lines of trailing context
  -C, --context=NUM         print NUM lines of output context
  -NUM                      same as --context=NUM
      --color[=WHEN],
      --colour[=WHEN]       use markers to distinguish the matching string
                            WHEN may be `always', `never' or `auto'.
  -U, --binary              do not strip CR characters at EOL (MSDOS)
  -u, --unix-byte-offsets   report offsets as if CRs were not there (MSDOS)

`egrep' means `grep -E'.  `fgrep' means `grep -F'.
With no FILE, or when FILE is -, read standard input.  If less than
two FILEs given, assume -h.  Exit status is 0 if match, 1 if no match,
and 2 if trouble.
 
Miscellaneous:
  -s, --no-messages         suppress error messages
  -v, --invert-match        select non-matching lines
  -V, --version             print version information and exit
      --help                display this help and exit
      --mmap                use memory-mapped input if possible
 
Output control:
  -m, --max-count=NUM       stop after NUM matches
  -b, --byte-offset         print the byte offset with output lines
  -n, --line-number         print line number with output lines
      --line-buffered       flush output on every line
  -H, --with-filename       print the filename for each match
  -h, --no-filename         suppress the prefixing filename on output
      --label=LABEL         print LABEL as filename for standard input
  -o, --only-matching       show only the part of a line matching PATTERN
  -q, --quiet, --silent     suppress all normal output
      --binary-files=TYPE   assume that binary files are TYPE
                            TYPE is 'binary', 'text', or 'without-match'
  -a, --text                equivalent to --binary-files=text
  -I                        equivalent to --binary-files=without-match
  -d, --directories=ACTION  how to handle directories
                            ACTION is 'read', 'recurse', or 'skip'
  -D, --devices=ACTION      how to handle devices, FIFOs and sockets
                            ACTION is 'read' or 'skip'
  -R, -r, --recursive       equivalent to --directories=recurse
      --include=PATTERN     files that match PATTERN will be examined
      --exclude=PATTERN     files that match PATTERN will be skipped.
      --exclude-from=FILE   files that match PATTERN in FILE will be skipped.
  -L, --files-without-match only print FILE names containing no match
  -l, --files-with-matches  only print FILE names containing matches
  -c, --count               only print a count of matching lines per FILE
  -Z, --null                print 0 byte after FILE name
 
Report bugs to <bug-grep@gnu.org>.
   -E, --extended-regexp     PATTERN is an extended regular expression
  -F, --fixed-strings       PATTERN is a set of newline-separated strings
  -G, --basic-regexp        PATTERN is a basic regular expression
  -P, --perl-regexp         PATTERN is a Perl regular expression
   -e, --regexp=PATTERN      use PATTERN as a regular expression
  -f, --file=FILE           obtain PATTERN from FILE
  -i, --ignore-case         ignore case distinctions
  -w, --word-regexp         force PATTERN to match only whole words
  -x, --line-regexp         force PATTERN to match only whole lines
  -z, --null-data           a data line ends in 0 byte, not newline
 %s (GNU grep) %s
 %s: illegal option -- %c
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
 ' (standard input) Binary file %s matches
 Copyright 1988, 1992-1999, 2000, 2001 Free Software Foundation, Inc.
 Memory exhausted No syntax specified Search for PATTERN in each FILE or standard input.
Example: %s -i 'hello world' menu.h main.c

Regexp selection and interpretation:
 The -P and -z options cannot be combined The -P option is not supported This is free software; see the source for copying conditions. There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 Try `%s --help' for more information.
 Unbalanced ( Unbalanced ) Unbalanced [ Unfinished \ escape Unknown system error Usage: %s [OPTION]... PATTERN [FILE] ...
 Usage: %s [OPTION]... PATTERN [FILE]...
 ` conflicting matchers specified input is too large to count invalid context length argument invalid max count malformed repeat count memory exhausted out of memory recursive directory loop unfinished repeat count unknown binary-files type unknown devices method unknown directories method warning: %s: %s
 writing output Project-Id-Version: GNU grep 2.5g
POT-Creation-Date: 2002-01-22 14:39+0100
PO-Revision-Date: 2002-03-13 13:00+0100
Last-Translator: Rafa? Maszkowski <rzm@icm.edu.pl>
Language-Team: Polish <translation-team-pl@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8-bit
 
Sterowanie kontekstem:
  -B, --before-context=ILE  wypisanie ILE linii kontekstu przed
  -A, --after-context=ILE   wypisanie ILE linii kontekstu po
  -C, --context[=ILE]       wypisanie ILE (domy?lnie 2) linii kontekstu
  -ILE                      to samo co --context=ILE
      --color[=KIEDY],
      --colour[=KIEDY]      oznaczanie pasuj?cych znak?w,
                            KIEDY to `always' (zawsze), `never' (nigdy)
                            albo `auto' (automatycznie).
  -U, --binary              bez usuwania znak?w nowej linii na ko?cu
  -u, --unix-byte-offsets   podawanie pozycji tak jakby nie by?o CR?w (MSDOS)

`egrep' oznacza `grep -E'. `fgrep' oznacza `grep -F'.
Bez PLIKu albo gdy PLIK to -, czytane jest standardowe wej?cie. Je?eli
podano mniej ni? dwa PLIKi, zak?ada -h. Zako?czenie z kodem 0 je?eli
WZORZEC pasuje, z 1, je?eli nie, z 2, je?eli s? problemy.
 
R??ne:
  -s, --no-messages         bez komunikat?w o b??dach
  -v, --revert-match        wybierz linie nie pasuj?ce
  -V, --version             wypisz informacj? o wersji i zako?cz
      --help                wy?wietl t? informacj? i zako?cz
      --mmap                je?eli mo?liwe mapuj pliki w pami?ci
 
Sterowanie danymi wyj?ciowymi:
  -m, --max-count=ILE       zatrzymanie po ILE dopasowaniach
  -b, --byte-offset         wypisanie pozycji bajt?w w wyniku
  -n, --line-number         wypisanie numer?w linii w wyniku
      --line-buffered       opr??nienie buf. wyj. po ka?dej linii
  -H, --with-filename       wypisanie nazwy pliku dla ka?dej linii
  -h, --no-filename         bez nazwy pliku w liniach wyj?ciowych
      --label=ETYKIETA      w wyniku ETYKIETA zast?puje nazwe pliku
  -o, --only-matching       pokazanie tylko kawa?ka, kt?ry pasuje do WZORCA
  -q, --quiet, --silent     wy??czenie wypisywanie wyniku
      --binary-files=TYP    za?o?enie, ?e pliki binarne s? typu TYP
                            TYP to 'binary', 'text' lub 'without-match'.
  -a, --text                r?wnowa?ne --binary-files=text
  -I                        r?wnowa?ne --binary-files=without-match
  -d, --directories=DZIA?ANIE  jak si? obchodzi? z katalogami,
                            DZIA?ANIE to `read' (czytanie), `,recurse'
                            (przegl?danie rekurencujne) albo 'skip'
                            (pomini?cie).
  -D, --devices=DZIA?ANIE   jak odwo?ywa? si? do urz?dze?, FIFO i gniazd,
                            DZIA?ANIE to 'read' (czytaj) albo 'skip' (pomi?)
  -R, -r, --recursive       r?wnowa?ne --directories=recurse .
      --include=WZORZEC     przeszukiwane b?d? pliki pasuj?ce do WZORCA
      --exclude=WZORZEC     pliki pasuj?ce do WZORCA b?d? pomini?te
      --exclude-from=PLIK   pomini?cie plik?w pasuj?cych do WZORC?W w PLIKU
  -L, --files-without-match wypisanie tylko nazw PLIK?W bez trafie?
  -l, --files-with-matches  wypisanie tylko nazw PLIK?W z trafieniami
  -c, --count               wypisanie tylko ilo?ci pasuj?cych linii w PLIKACH
  -Z, --null                wypisanie bajtu 0 po ka?dej nazwie PLIKU
 
Raporty o b??dach wysy?aj do bug-grep@gnu.org.
   -E, --extended-regexp     WZORZEC jest rozszerzonym wyr. regularnym
  -F, --fixed-strings       WZORZEC napisy oddzielone przez zn. nowej linii
  -G, --basic-regexp        WZORZEC jest podstawowym wyr. regularnym
  -P, --perl-regexp         WZORZEC jest wyra?eniem regularnym perla
   -e, --regexp=WZORZEC      u?ycie WZORCA jako wyra?enia regularnego
  -f, --file=PLIK           u?ycie wzorc?w z PLIKU
  -i, --ignore-case         zignorowanie ro?nic mi?dzy ma?ymi i wlk. lit.
  -w, --word-regexp         dopasowanie WZORZEC tylko do pe?nych s??w
  -x, --line-regexp         dopasowanie WZORZEC tylko do ca?ych linii
  -z, --null-data           linie s? zako?czone bajtem 0, nie znakiem
                            nowej linii
 %s (GNU grep) %s
 %s: nielegalna opcja -- %c
 %s: b??dna opcja -- %c
 %s: opcja `%c%s' nie mo?e mie? argumentu
 %s: opcja `%s' jest niejednoznaczna
 %s: opcja `%s' wymaga argumentu
 %s: opcja `--%s' nie mo?e mie? argumentu
 %s: opcja `-W %s' nie mo?e mie? argumentu
 %s: opcja `-W %s' jest niejednoznaczna
 %s: opcja wymaga argumentu -- %c
 %s: nierozpoznana opcja `%c%s'
 %s: nierozpoznana opcja `--%s'
 " (standardowe wej?cie) Plik binarny %s pasuje do wzorca
 Copyright (C) 1988, 1992-1999, 2000, 2001 Free Software Foundation, Inc.
 Pami?? wyczerpana Brak specyfikacji sk?adni Szukanie WZORCA w ka?dym pliku lub na standardowym wej?ciu.
Przyk?ad: %s -i 'hello world' menu.h main.c

Wyb?r i interpretacja wyra?e? regularnych:
 Opcje -P i -z nie mog? wyst?powa? razem Opcja -P nie jest obs?ugiwana Oprogramowanie darmowe. Warunki kopiowania zamieszczone s? w kodzie ?r?d?owym.
Nie podlega ?adnej gwarancji, nawet gwarancji przydatno?ci do jakiegokolwiek
zastosowania lub sprzeda?y.
 Napisz `%s --help' ?eby dowiedzie? si? wi?cej.
 ( nie do pary ) nie do pary [ nie do pary Niedoko?czona sekwencja \ Nieznany b??d systemowy U?ycie: %s [OPCJA]... WZORZEC [PLIK] ...
 U?ycie: %s [OPCJA]... WZORZEC [PLIK] ...
 " podane sprzeczne wzorce danych wej?ciowych jest zbyt du?o do policzenia b??dny argument d?ugo?ci kontekstowej b??dna maksymalna liczba powt?rze? ?le sformatowana liczba powt?rze? pami?? wyczerpana brak pami?ci niesko?czona p?tla przegl?dania katalog?w niedoko?czona liczba powt?rze? nieznany typ pliku binarnego nieznany spos?b przegl?dania urz?dze? nieznany spos?b przegl?dania katalog?w uwaga: %s: %s
 zapisuj? wyniki 