??    3      ?  G   L      h  ?  i  0    `  J  $   ?    ?  v  ?     [     m     ?  ,   ?     ?  %   ?  ,     -   ?      m  &   ?     ?     ?     ?     ?       E         f     w  ?   ?  (        9  ?   X  &   ?          #     0     =     Q  )   f  (   ?     ?     ?     ?     ?          (     ?     P     ^     w     ?     ?     ?     ?  )  ?  ?    f    D  l  c   ?     !  ?  5"     ?#     $     "$  &   >$     e$  &   ?$  $   ?$  ,   ?$      ?$  &   %     D%     ]%     v%     x%     ?%  E   ?%     ?%     ?%  ?   &  '   ?&     ?&  ?   ?&  +   p'     ?'     ?'     ?'     ?'     ?'  ,   ?'  ,   (     D(  %   F(  &   l(  &   ?(      ?(     ?(     ?(     )     )     ')     D)     V)     u)     ?)     $                    /      ,      0       "       -          )   *   2          3                                                   &             1          '   %          !                                      
          (   +   	   #   .             
Context control:
  -B, --before-context=NUM  print NUM lines of leading context
  -A, --after-context=NUM   print NUM lines of trailing context
  -C, --context=NUM         print NUM lines of output context
  -NUM                      same as --context=NUM
      --color, --colour     use markers to distinguish the matching string
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
  -q, --quiet, --silent     suppress all normal output
      --binary-files=TYPE   assume that binary files are TYPE
                            TYPE is 'binary', 'text', or 'without-match'
  -a, --text                equivalent to --binary-files=text
  -I                        equivalent to --binary-files=without-match
  -d, --directories=ACTION  how to handle directories
                            ACTION is 'read', 'recurse', or 'skip'
  -R, -r, --recursive       equivalent to --directories=recurse
      --include=PATTERN     files that match PATTERN will be examine
      --exclude=PATTERN     files that match PATTERN will be skip.
      --exclude-from=FILE   files that match PATTERN in FILE will be skip.
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
 ` conflicting matchers specified input is too large to count invalid context length argument invalid max count malformed repeat count memory exhausted out of memory recursive directory loop unfinished repeat count unknown binary-files type unknown directories method warning: %s: %s
 writing output Project-Id-Version: GNU grep 2.5e
POT-Creation-Date: 2001-03-07 00:02-0500
PO-Revision-Date: 2001-08-23 09:46+02:00
Last-Translator: Daniel Resare <daniel@resare.com>
Language-Team: Swedish <sv@li.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
 
Kontroll av sammanhang:
  -B, --before-context=ANTAL  skriv ANTAL rader f?re tr?ffad rad
  -A, --after-context=ANTAL   skriv ANTAL rader efter tr?ffad rad
  -C, --context=ANTAL         skriv ANTAL rader runt tr?ffad rad
  -ANTAL                      motsvarar --context=ANTAL
      --color, --colour       anv?nd mark?rer f?r att s?rskilja tr?ff
  -U, --binary                ta inte bort CR-tecken vid radslut (MSDOS)
  -u, --unix-byte-offsets     skriv offset som om CR-tecken inte f?rekommit

"egrep" betyder "grep -E". "fgrep" betyder "grep -F".
Utan FIL, eller om FIL ?r -, l?ser programmet fr?n standard in. Om f?rre ?n
tv? FILer ?r angivna, s?tts flaggan -h. Programmet returnerar 0 om n?got
matchar, 1 om inget matchade och 2 om n?got fel uppst?tt.
 
Diverse:
  -s, --no-messages         visa inga felmeddelanden
  -v, --invert-match        v?lj rader utan tr?ffar
  -V, --version             visa versionsinformation och avsluta
      --help                visa detta hj?lpmeddelande och avsluta
      --mmap                anv?nd om m?jligt minesmappning vid
                            l?sning av indata.
 
Styrning av utskrift:
  -m, --max-count=NUM       skriv bara ut NUM tr?ffar
  -b, --byte-offset         skriv position med visade rader
  -n, --line-number         skriv radnummer med visade rader
      --line-buffered       t?m utskriftsbuffer efter varje rad
  -H, --with-filename       skriv filnamn vid varje tr?ff
  -h, --no-filename         skriv inte filnamn vid varje visad rad
  -q, --quiet, --silent     undvik all normal utskrift
      --binary-files=TYP    antag att bin?ra filer ?r av TYP
                            TYP ?r "binary", "text" eller "without-match"
  -a, --text                motsvarar --binary-files=text
  -I                        motsvarar --binary-files=without-match
  -d, --directories=?TG?RD  hur kataloger skall hanteras
                            ?TG?RD ?r "read", "recurse" eller "skip".
  -R, -r, --recursive       motsvarar --directories=recurse
      --include=M?NSTER     filer som matchar M?NSTER unders?ks
      --exclude=M?NSTER     filer som matchar M?NSTER hoppas ?ver
      --exclude-from=FIL    filer som matchar m?nster i FIL hoppas ?ver
  -L, --files-without-match skriv bara ut FILnamn utan tr?ffar
  -l, --files-with-matches  skriv bara ut FILnamn med tr?ffar
  -c, --count               skriv f?r varje FIL bara ut antal tr?ffade rader
  -Z, --null                skriv 0-byte efter FILnamn
 
Rapportera buggar till <bug-grep@gnu.org>.
Skicka anm?rkningar p? ?vers?ttningar till <sv@li.org>
  -E, --extended-regexp      M?NSTER ?r ett ut?kat regulj?rt uttryck
 -F, --fixed-strings        M?NSTER ?r ett antal str?ngar separerade med nyrad
 -G, --basic-regexp         M?NSTER ?r ett enkelt regulj?rt uttryck
 -P, --perl-regexp          M?NSTER ?r ett regulj?rt uttryck som i Perl
  -e, --regexp=M?NSTER       anv?nd M?NSTER som ett regulj?rt uttryck
 -f, --file=FIL             h?mta M?NSTER fr?n FIL
 -i, --ignore-case          skilj ej p? gemener och versaler
 -w, --word-regexp          tvinga M?NSTER att endast matcha hela ord
 -x, --line-regexp          tvinga M?NSTER att endast matcha hela rader
 -z, --null-data            en rad indata begr?nsas av en nolltecken, inte
                            av ett nyrad-tecken
 %s (GNU grep) %s
 %s: otill?ten flagga -- %c
 %s: otill?ten flagga -- %c
 %s: flaggan "%c%s" tar inget argument
 %s: flaggan "%s" ?r tvetydig
 %s: flaggan "%s" beh?ver ett argument
 %s: flaggan "%s" tar inget argument
 %s: flaggan "-W %s" till?ter inget argument
 %s: flaggan "-W %s" ?r tvetydig
 %s: flagga beh?ver ett argument -- %c
 %s: ok?nd flagga "%c%s"
 %s: ok?nd flagga "--%s"
 " (standard in) Bin?r fil %s matchar
 Copyright 1988, 1992-1999, 2000, 2001 Free Software Foundation, Inc.
 Minnet slut Ingen specificerad syntax S?k efter M?NSTER i varje FIL eller standard in.
Exempel: %s -i 'hello world' menu.h main.c

Val och tolkning av regulj?ra uttryck:
 Flaggorna -P och -z kan inte kombineras Flaggan -P st?ds inte Detta program ?r fri programvara, se k?llkoden f?r kopieringsvilkor. Det
finns INGEN garanti, inte ens f?r S?LJBARHET eller L?MPLIGHET F?R N?GOT
SPECIELLT ?NDAM?L.
 F?rs?k med "%s --help" f?r mer information
 Obalanserad ( Obalanserad ) Obalanserad [ Oavslutad \-sekvens Ok?nt systemfel Anv?ndning: %s [FLAGGA]... M?NSTER [FIL]...
 Anv?ndning: %s [FLAGGA]... M?NSTER [FIL]...
 " motstridiga s?kstr?ngar specificerade det ?r f?r mycket indata f?r att r?kna ogiltigt argument till -A, -B eller -C ogiltigt v?rde f?r antal tr?ffar felformaterad repetionsr?knare minnet slut minnet slut rekursiv katalogloop oavslutad repetitionsr?knare ok?nd bin?rfiltyp ok?nd metod g?llande kataloger varning: %s: %s
 skriver utdata 