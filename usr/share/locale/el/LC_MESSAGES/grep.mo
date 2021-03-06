??    4      ?  G   \      x  
  y  0  ?  t  ?  $   *    O  v  c     ?     ?       ,         M  %   k  ,   ?  -   ?      ?  &        4     T     t     v     ?  E   ?     ?     ?  ?   
  (   ?     ?  ?   ?  &   n     ?     ?     ?     ?     ?  )   ?  (        8     :     Y     u     ?     ?     ?     ?     ?     ?          (     ?     Z     k  0  z    ?  ?  ?  `  Z  4   ?'  ^  ?'  :  O)     ?+     ?+     ?+  ,   ?+  %   ,  "   +,  ,   N,  +   {,  (   ?,  '   ?,  #   ?,  #   -     @-     B-     U-  L   u-     ?-     ?-  ?   ?-  0   ?.     ?.  ?   ?.  4   ?/     ?/     ?/     ?/  &   ?/     0  .   10  -   `0     ?0  +   ?0  +   ?0  $   ?0     1  %   *1     P1     d1  "   x1  $   ?1     ?1     ?1     ?1     2     )2     $                    /      ,      0      "               -   )   *   3          4                                                  &             2          '   %          !                1                     
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
PO-Revision-Date: 2002-03-11 12:00+0000
Last-Translator: Simos Xenitellis <simos@hellug.gr>
Language-Team: Greek <nls@tux.hellug.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8-bit
 
??????? ????? ??? ????????????:
  -B, --before-context=??????? ???????? ??????? ??????? ?? ?????????????
                              ???????????
  -A, --after-context=???????  ???????? ??????? ??????? ?? ?????????????
                              ???????????
  -C, --context=???????     ???????? ??????? (?? ??????? 2) ??????? ??
                              ??????????? ??????
                              ????? ?? ?? ????????? ?? -A ? -B
  -NUM                      ?? ???? ?? --context=???????
      --color[=WHEN],
      --colour[=WHEN]       use markers to distinguish the matching string
                            WHEN may be `always', `never' or `auto'.
  -U, --binary              ?? ??? ???????????? ?????????? CR ??? EOL (MSDOS)
  -u, --unix-byte-offsets   ??????? ???????? ?????? ?? ?? ??? ???????
                              ?????????? CR (MSDOS)

To `egrep' ????? ????????? ??? `grep -E'. ?? `fgrep' ????? ????????? ???
`grep -F'.
With no FILE, or when FILE is -, read standard input.  If less than
????? ??????, ? ???? ?? ?????? ????? -, ?????????? ? ???????? ???????.
?? ??? ???????? ???????? ???????? ??? ??? ??????, ???? ?????????? ??? ????
????? ? ??????? -h.  ? ????????? ?????? ??? ???????????? ????? 0 ?? ???????
?? ?????????, 1 ?? ??? ??????? ??? 2 ?? ???????? ?????? ????????.
 
?????:
  -s, --no-messages         ??????? ????????? ????????? ?????????
  -v, --revert-match        ??????? ??????? ??? ??? ??????????
  -V, --version             ????????? ??????????? ??????? ??? ??????
      --help                ????????? ????? ??? ???????? ??? ??????
      --mmap                ????? ??????? ?????????????-???-????? ??
                              ??????? ?????? ??????????
 
??????? ??????:
  -m, --max-count=???????   ????????? ???? ??? ?????? ???????????
  -b, --byte-offset         ???????? ???????? ????? ??? byte ?? ??? ???????
                              ??????
  -n, --line-number         ???????? ??????? ??????? ?? ??? ??????? ??????
  -H, --with-filename       ???????? ???????? ??????? ?? ???? ?????????
  -h, --no-filename         ??????? ????????? ??? ???????? ??? ??????? ????
                              ???? ??? ??????
      --label=LABEL         print LABEL as filename for standard input
  -o, --only-matching       show only the part of a line matching PATTERN
  -q, --quiet, --silent     ??????? ????????? ???? ??? ????????? ??????
      --binary-files=TYPE   assume that binary files are TYPE
                            TYPE is 'binary', 'text', or 'without-match'
  -a, --text                ?? ??? ?????????? ? ?????? ???????? ?????????
  -I                        equivalent to --binary-files=without-match
  -d, --directories=????????  ?????? ?????? ??? ?????????
                            ? ???????? ????? 'read', 'recurse' ? 'skip'.
                            (??? ????????, ???????? ??? ????????? ??????????).
  -D, --devices=????????    ?????? ?????? ??? ????????, FIFO ??? socket
                            ? ???????? ????? 'read' ? 'skip'.
                            (??? ???????? ??? ????????? ??????????).
  -R, -r, --recursive       ????????? ?? --directories=recurse.
      --include=?????????   ?? ????????? ?????? ??? ?????????? ??? ?????????.
      --exclude=?????????   ?? ???????????? ?????? ??? ?????????? ??? ?????????
      --exclude-from=?????? ?? ???????????? ?? ?????? ??? ?????????? ???
                            ??????????? ??? ??????????? ???? ??? ??????.
  -L, --files-without-match ???????? ???? ?? ??????? ??????? ??? ???
                              ????????? ???????????
  -l, --files-with-matches  ???????? ???? ?? ??????? ??????? ?? ???????????
  -c, --count               ???????? ???? ??? ?????? ??? ??????? ??
                              ??????????? ??? ???? ??????
  -Z, --null                ??????? ???? ????????? byte ???? ?? ????? ???????
 
??????? ???????? ????????? ??? <bug-grep@gnu.org>.
   -E, --extended-regexp     ????????? ????? ??? ?????????? ???????? ???????
  -F, --fixed-regexp        ????????? ????? ??????? ????????????? ???????-
                              ?????? ?? ?????????? ??????? ???????
  -G, --basic-regexp        ????????? ????? ???? ???????? ???????
  -P, --perl-regexp         ????????? ????? ???????? ??????? Perl
   -e, --regexp=?????????    ????? ???????????? ??? ???????? ???????
  -f, --file=??????         ???? ???????????? ??? ?? ?????? ??????
  -i, --ignore-case         ??????? ???????? ?????/?????????
  -w, --word-regexp         ??????? ??? ???????????? ?? ????????? ????
                              ????????? ??????
  -x, --line-regexp         ??????? ??? ???????????? ?? ????????? ????
                              ????????? ???????
  -z, --null-data           ? ?????? ????????? ???????????? ?? byte 0
                              ??? ??? ?? ????????? ??????? ???????
 %s (GNU grep) %s
 %s: ?? ???????? ??????? -- %c
 %s: ?? ?????? ??????? -- %c
 %s: ? ??????? `%c%s' ??? ????????? ????????
 %s: ? ??????? `%s' ????? ???????????
 %s: ? ??????? `%s' ??????? ??????
 %s: ? ??????? `--%s' ??? ????????? ????????
 %s: ? ??????? `-W %s' ??? ??????? ????????
 %s: ? ??????? `-W %s' ????? ???????????
 %s: ? ??????? ??????? ??? ?????? -- %c
 %s: ?? ???????????? ??????? `%c%s'
 %s: ?? ???????????? ??????? `--%s'
 ' (???????? ???????) ?? ??????? ?????? %s ?????????
 ???????? ?????????? 1988, 1992-1999, 2000, 2001 ?????? ????????? ??????????
 ? ????? ??????????? ??? ???????? ?????????? ?????? ??? ???????????? ?? ???? ?????? ? ??? ???????? ??????.
??????????: %s -i 'hello world' menu.h main.c

??????? ????????? ???????? ??? ????????:
 ?? ???????? -P ??? -z ??? ??????? ?? ??????????? ? ??????? -P ??? ????????????? ???? ????? ???????? ?????????, ????? ??? ?????? ?????? ??? ???? ???????
??????????. ??? ??????? ???????, ???? ????? ??? ??????????? ? ?????????????
??? ??? ???????????? ?????.
 ????????? `%s --help' ??? ???????????? ???????????.
 ?? ???????????? ( ?? ???????????? ) ?? ???????????? [ ?? ????????????? ?????????? ???????? \ ??????? ????? ?????????? ?????: %s [???????]... ????????? [??????] ...
 ?????: %s [???????]... ????????? [??????]...
 ` ????????? ????????????? ???????? ?????????? ? ??????? ????? ???? ?????? ??? ?? ???????? ?? ?????? ?????? ?????? ???????????? ?? ??????? ???????? ???????? ????????????????? ???????? ?????????? ? ????? ??????????? ? ????? ??????????? ?????????? ????????????? ????????? ?? ????????????? ???????? ?????????? ??????? ????? ???????? ??????? ??????? ??????? ???????? ??????? ??????? ????????? ?????????????: %s: %s
 ??????? ????????????? 