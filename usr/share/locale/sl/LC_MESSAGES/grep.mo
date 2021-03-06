??    4      ?  G   \      x  
  y  0  ?  t  ?  $   *    O  v  c     ?     ?       ,         M  %   k  ,   ?  -   ?      ?  &        4     T     t     v     ?  E   ?     ?     ?  ?   
  (   ?     ?  ?   ?  &   n     ?     ?     ?     ?     ?  )   ?  (        8     :     Y     u     ?     ?     ?     ?     ?     ?          (     ?     Z     k  ?  z    ?    ?  ?  ?  >   ?#    ?#  ?  ?$     ?&     ?&     '  )   ,'     V'  !   r'  )   ?'  *   ?'     ?'  "   (     +(     K(     k(     m(     (  I   ?(     ?(     ?(  ?   )  )   ?)     ?)  ?   ?)  ,   ?*     ?*     ?*     +     %+     D+  .   ]+  -   ?+     ?+     ?+  )   ?+     ,     %,      A,     b,     v,     ?,     ?,     ?,     ?,     ?,     -     $-     $                    /      ,      0      "               -   )   *   3          4                                                  &             2          '   %          !                1                     
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
PO-Revision-Date: 2002-03-11 09:25+0100
Last-Translator: Primo? Peterlin <primoz.peterlin@biofiz.mf.uni-lj.si>
Language-Team: Slovenian <sl@li.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8-bit
 
Nadzor nad kontekstom:
  -B, --before-context=?T   ?T vrstic konteksta pred vrstico z VZORCEM
  -A, --after-context=?T    ?T vrstic konteksta za vrstico z VZORCEM
  -C, --context[=?T]        ?T vrstic konteksta pred in za vrstico z VZORCEM
  -?T                       isto kot --context=?T
      --color, --colour     ujemajo?e nize barvno ozna?imo
  -U, --binary              ne pore?emo znakov CR na koncu vrstic (MS-DOS)
  -u, --unix-byte-offsets   v odmikih ne ?tejemo znakov CR (MS-DOS)

Ukaz ,egrep` pomeni isto kot ,grep -E`, ,fgrep` pa isto kot ,grep -F`.
?e DATOTEKA ni podana ali pa je -, beremo s standardnega vhoda. ?e sta podani
manj kot dve DATOTEKI, privzamemo izbiro -h. Izhodna koda je ni?, ?e smo VZOREC
na?li, ena, ?e ga nismo, 2 pa pomeni skladenjsko ali sistemsko napako.
 
Razno:
  -s, --no-messages         brez sporo?il o napakah
  -v, --invert-match        komplement: vrstice, kjer ni VZORCA
  -V, --version             verzija programa
      --help                ta pomo?
      --mmap                ?e je mo?no, uporabi pomnilni?ko preslikan vhod
 
Nadzor izhoda:
  -m, --max-count=?TEVILO   odnehamo, ko je dose?eno ?TEVILO ujemanj
  -b, --byte-offset         z izpisom odmika (v zlogih)
  -n, --line-number         z izpisom zaporedne ?tevilke vrstice
      --line-buffered       izhodni medpomnilnik izpraznimo vsako vrstico
  -H, --with-filename       z izpisom imena datoteke
  -h, --no-filename         brez izpisa imena datoteke
      --label=OZNAKA        z navedeno OZNAKO, kadar beremo s standardnega vhoda
  -o, --only-matching       izpis samo dela vrstice z VZORCEM
  -q, --quiet, --silent     brez vsega obi?ajnega izpisa
      --binary-type=TIP     privzemi izbrani TIP binarne datoteke
                            TIP je lahko ,binary`, ,text` ali ,without-match`
  -a, --text                isto kot --binary-type=text
  -I                        isto kot --binary-type=without-match
  -d, --directories=DEJANJE  kako obravnavamo imenike
                            DEJANJE je lahko ,read`, ,recurse` ali ,skip`
  -D, --devices=DEJANJE     kako obravnavamo datoteke naprav
                            DEJANJE je lahko ,read` ali ,skip`
  -R, -r, --recursive       isto kot --directories=recurse
      --include=VZOREC      prei??emo le datoteke, ki ustrezajo VZORCU
      --exclude=VZOREC      izpustimo datoteke, ki ustrezajo VZORCU
      --exclude-from=DATOTEKA  izpustimo datoteke, ki ustrezajo vzorcu v DATOTEKI
  -L, --files-without-match le imena tistih DATOTEK, kjer VZORCA nismo na?li
  -l, --files-with-matches  le imena tistih DATOTEK, kjer smo VZOREC na?li
  -c, --count               le skupno ?tevilo vrstic v DATOTEKI, v katerih se
                            pojavi VZOREC
  -Z, --null                izpi?i znak NUL za imenom DATOTEKE
 
Morebitne napake v programu sporo?ite na <bug-grep@gnu.org>.
   -E, --extended-regexp     VZOREC je raz?irjeni regularni izraz
  -F, --fixed-strings       VZOREC je mno?ica nizov, vsak v svoji vrstici
  -G, --basic-regexp        VZOREC je osnovni regularni izraz
  -P, --perl-regexp         VZOREC je regularni izraz z raz?iritvami perla
   -e, --regexp=VZOREC       uporabimo VZOREC kot regularni izraz
  -f, --file=DATOTEKA       VZOREC preberemo s podane DATOTEKE
  -i, --ignore-case         ne razlikujemo med velikimi in malimi ?rkami
  -w, --word-regexp         iskanje uspe?no le, ?e je VZOREC cela beseda
  -x, --line-regexp         iskanje uspe?no le, ?e je VZOREC cela vrstica
  -z, --null-data           vrstica podatkov je kon?ana z znakom NUL, ne z
                            znakom za skok v novo vrstico
 %s (GNU grep) %s
 %s: nedovoljena izbira -- %c
 %s: neveljavna izbira -- %c
 %s: izbira ,%c%s` ne dovoljuje argumenta
 %s: izbira ,%s` je dvoumna
 %s: izbira ,%s` zahteva argument
 %s: izbira ,--%s` ne dovoljuje argumenta
 %s: izbira ,-W %s` ne dovoljuje argumenta
 %s: izbira ,-W %s` je dvoumna
 %s: izbira zahteva argument -- %c
 %s: neprepoznana izbira ,%c%s`
 %s: neprepoznana izbira ,--%s`
 ` (standardni vhod) Binarna datoteka %s ustreza
 Copyright (C) 1988, 1992-1999, 2000, 2001 Free Software Foundation, Inc.
 Pomnilnik porabljen Skladnja ni podana V DATOTEKI ali na standardnem vhodu i??emo VZOREC.
Primer: %s -i 'hello.*world' menu.h main.c

Izbira in tolma?enje regularnih izrazov:
 Izbiri -P in -z se med seboj izklju?ujeta Izbira -P ni podprta To je prost program; pogoji, pod katerimi ga lahko uporabljate, razmno?ujete
in raz?irjate so navedeni v izvorni kodi. Za program ni NOBENEGA jamstva,
niti jamstev USTREZNOSTI ZA PRODAJO ali PRIMERNOSTI ZA UPORABO.
 Poskusite ,%s --help` za dodatna pojasnila.
 Oklepaj ( brez zaklepaja Zaklepaj ) brez oklepaja Oklepaj [ brez zaklepaja Nedokon?ano ube?no zaporedje \ Neznana sistemska napaka Uporaba: %s [IZBIRA]... VZOREC [DATOTEKA] ...
 Uporaba: %s [IZBIRA]... VZOREC [DATOTEKA]...
 , podana navodila si nasprotujejo vhod je prevelik, da bi ga mogli pre?teti velikost konteksta ni veljavna neveljavno najve?je ?tevilo slabo dolo?eno ?tevilo ponovitev pomnilnik porabljen zmanjkalo pomnilnika rekurzivna zanka imenikov nedokon?ano ?tevilo ponovitev neznan tip binarne datoteke neznana metoda datotek naprav neznana metoda imenikov pozor: %s: %s
 pisanje rezultatov 