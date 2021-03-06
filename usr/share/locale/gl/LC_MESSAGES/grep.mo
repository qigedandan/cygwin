??    4      ?  G   \      x  
  y  0  ?  t  ?  $   *    O  v  c     ?     ?       ,         M  %   k  ,   ?  -   ?      ?  &        4     T     t     v     ?  E   ?     ?     ?  ?   
  (   ?     ?  ?   ?  &   n     ?     ?     ?     ?     ?  )   ?  (        8     :     Y     u     ?     ?     ?     ?     ?     ?          (     ?     Z     k  B  z  ?  ?  B  ?  ?  ?  n   ?%  #  ?%  ?  "'     ?(     ?(     ?(  ,   )     B)  (   _)  ,   ?)  -   ?)     ?)  (   *  !   ,*  !   N*     p*     r*     ?*  E   ?*     ?*     ?*  ?   +  (   ?+     ?+  ?   ?+  +   ?,     ?,     ?,     ?,     ?,     -  .   -  -   N-     |-  $   ~-  &   ?-  -   ?-     ?-  "   .     3.     D.     U.      t.  &   ?.  "   ?.  !   ?.     /     /     $                    /      ,      0      "               -   )   *   3          4                                                  &             2          '   %          !                1                     
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
 writing output Project-Id-Version: grep 2.5g
POT-Creation-Date: 2002-01-22 14:39+0100
PO-Revision-Date: 2002-03-12 15:58+0100
Last-Translator: Jacobo Tarr?o Barreiro <jtarrio@iname.com>
Language-Team: Galician <gpul-traduccion@ceu.fi.udc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
 
Control de contexto:
  -B, --before-context=NUM  amosa NUM li?as de contexto previo
  -A, --after-context=NUM   amosa NUM li?as de contexto posterior
  -C, --context=NUM         amosa NUM li?as de contexto na sa?da
  -NUM                      o mesmo que --context=NUM
      --color[=CANDO],
      --colour[=CANDO]      empregar marcadores para distingui-la cadea
                            coincidente. CANDO pode ser `always', `never' ou
                            `auto' (`sempre', `nunca' ou `auto').
  -U, --binary              non elimina os caracteres CR na fin de li?a (MSDOS)
  -u, --unix-byte-offsets   amosa-los desprazamentos coma se os CR non
                               estiveran a? (MSDOS)

`egrep' significa `grep -E'.  `fgrep' significa `grep -F'.
Se non se indica un FICHEIRO, ou cando o FICHEIRO ? -, lese da entrada
est?ndar. Se se dan menos de dous FICHEIROs, suponse -h. O estado de sa?da ?
0 se hai aparici?ns, 1 se non hai, e 2 se o que hai son problemas.
 
Variadas:
  -s, --no-messages         suprime as mensaxes de erro
  -v, --invert-match        selecciona as li?as que non encaixan
  -V, --version             amosa a informaci?n da versi?n e sae
      --help                amosa esta axuda e sae
      --mmap                emprega entrada mapeada en memoria se se pode
 
Control de sa?da:
  -m, --max-count=N?M       parar tras N?M aparici?ns
  -b, --byte-offset         amosa o desprazamento do byte coas li?as de sa?da
  -n, --line-number         amosa o numero de li?a coas li?as de sa?da
      --line-buffered       baleira-lo buffer de sa?da con cada li?a
  -H, --with-filename       amosa o nome do ficheiro de cada aparici?n
  -h, --no-filename         suprime o prefixo de nome de ficheiro na sa?da
      --label=ETIQUETA      amosa-la ETIQUETA coma o nome da entrada est?ndar
  -o, --only-matching       amosar s? a parte da li?a que encaixa co PATR?N
  -q, --quiet, --silent     suprime toda a sa?da normal
      --binary-files=TIPO   supo?er que os ficheiros binarios son TIPO
                            TIPO ? 'binary', 'text' ou 'without-match'
                            ('binario', 'texto', ou 'sen aparici?ns')
  -a, --text                equivalente a --binary-files=text
  -I                        equivalente a --binary-files=without-match
  -d, --directories=ACCION  como trata-los directorios
                            ACCION ? 'read', 'recurse', ou 'skip'.
                            ('ler', 'ascender recursivamente', ou 'omitir')
  -D, --devices=ACCI?N      como trata-los dispositivos, FIFOs e sockets
                            ACCI?N ? 'read' ou 'skip' ('ler' ou 'omitir')
  -R, -r, --recursive       equivalente a --directories=recurse.
      --include=PATR?N      hanse examina-los ficheiros que encaixen no PATR?N
      --exclude=PATR?N      hanse omiti-los ficheiros que encaixen no PATR?N
      --exclude-from=FICH   hanse omiti-los ficheiros que encaixen nos patr?ns
                               armacenados no FICHeiro
  -L, --files-without-match s? amosa os FICHEIROS sen aparici?ns
  -l, --files-with-matches  s? amosa os FICHEIROS con aparici?ns
  -c, --count               s? amosa o n?m. de li?as coincidentes por FICHEIRO
  -Z, --null                producir un byte 0 tralo nome do FICHEIRO
 
Informe dos erros no programa a <bug-grep@gnu.org>.
Informe dos erros na traducci?n a <proxecto@trasno.net>.
   -E, --extended-regexp     o PATR?N ? unha expresi?n regular extendida
  -F, --fixed-strings       o PATR?N ? un conxunto de cadeas en distintas li?as
  -G, --basic-regexp        o PATR?N ? unha expresi?n regular b?sica
  -P, --perl-regexp         o PATR?N ? unha expresi?n regular de Perl
   -e, --regexp=PATR?N       usa o PATR?N coma unha expresi?n regular
  -f, --file=FICHEIRO       obt?n o PATR?N no FICHEIRO
  -i, --ignore-case         ignora a distinci?n entre mai?sculas e min?sculas
  -w, --word-regexp         obliga ? PATRON a encaixar con palabras completas
  -x, --line-regexp         obliga ? PATRON a encaixar con li?as completas
  -z, --null-data           as li?as de datos rematan nun bit 0
 %s (GNU grep) %s
 %s: opci?n non permitida -- %c
 %s: opci?n non v?lida -- %c
 %s: a opci?n `%c%s' non admite un argumento
 %s: a opci?n `%s' ? ambigua
 %s: a opci?n `%s' precisa dun argumento
 %s: a opci?n `--%s' non admite un argumento
 %s: a opci?n `-W %s' non admite un argumento
 %s: a opci?n `-W %s' ? ambigua
 %s: a opci?n precisa dun argumento --%c
 %s: opci?n non reco?ecida `%c%s'
 %s: opci?n non reco?ecida `--%s'
 " (entrada est?ndar) Arquivo binario %s aparici?ns
 Copyright 1988, 1992-1999, 2000, 2001 Free Software Foundation, Inc.
 Memoria esgotada Sintaxe sen especificar Busca o PATR?N en cada FICHEIRO ou na entrada est?ndar.
Exemplo: %s -i 'ola mundo' menu.h main.c

Selecci?n e interpretaci?n de expresi?ns regulares:
 As opci?ns -P e -z non se poden combinar A opci?n -P non est? soportada Isto ? software libre; vexa o c?digo funte polas condici?ns de copia. NON HAI
garant?a; nin sequera de COMERCIABILIDADE ou APTITUDE PARA UN FIN PARTICULAR.
 Escriba `%s --help' para m?is informaci?n.
 ( sen emparellar ) sen emparellar [ sen emparellar Escape \ sen rematar Erro do sistema desco?ecido Emprego: %s [OPCI?N]... PATR?N [FICHEIRO] ...
 Emprego: %s [OPCI?N]... PATR?N [FICHEIRO]...
 " especific?ronse patr?ns conflictivos a entrada ? longa de m?is para contala argumento de lonxitude do contexto non v?lido valor m?ximo non v?lido conta de repetici?ns mal formulada memoria esgotada memoria esgotada ciclo de directorios recursivo conta de repetici?ns sen rematar tipo de ficheiros binarios desco?ecido m?todo de dispositivos desco?ecido m?todo de directorios desco?ecido aviso: %s: %s
 escribindo na sa?da 