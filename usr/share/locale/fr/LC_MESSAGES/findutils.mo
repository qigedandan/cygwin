��    a      $  �   ,      8  !   9  3   [  "   �  )   �  �   �     e	  s   �	  q   �	  $   f
     �
  "   �
     �
  ,   �
       %   -  ,   S  -   �      �  &   �     �          +     K  )   k  *   �     �     �  !   �     �               7     N  <   d  b   �  b     c   g  �   �     L  5   l  7   �  �   �  �   �  �   |       [   #       1   �  3   �  q   �     l     r     x  �   z     s     �     �  
   �     �     �     �     �  !   �          2     R     j     �     �  P   �  )        1     P  (   g  )   �     �  )   �  %   �      #  �   D  	    6        T  )  [     �     �  W   �  I     +   J  q   v  >   �  L   '  "   t  -   �  �   �  $   �  �  �  3   j   >   �   )   �   7   !  �   ?!  +   �!  �   %"  �   �"  =   I#     �#  .   �#     �#  3   �#      $  *   @$  3   k$  4   �$  #   �$  )   �$     "%  +   >%  !   j%  !   �%  1   �%  2   �%     &     &  -   &&     T&     g&     �&     �&     �&  O   �&  �   '  �   �'  �   (  �   �(  2   6)  D   i)  9   �)  �   �)  �   �*  �   �+     ^,  q   v,     �,  ?   -  @   E-  �   �-     .     .      .    ".  #   */  '   N/     v/     �/      �/  %   �/     �/     �/  0   �/     0  C   70  (   {0  $   �0  %   �0     �0  ?   1  '   C1  *   k1     �1  :   �1  <   �1     '2  9   F2  +   �2  "   �2  �   �2  U  �3  R   �4     -5  B  45     w6     �6  l   �6  �  7  6   �8  �   �8  m   P9  T   �9  7   :  8   K:  �   �:  (   A;     %   P   ]   _       M       G   `      Z                 O   ,   C       2          S   5   I   /       6   )       E       a          X            ^          	       +   7   K   '      4   R                  1      :   H   [       !   N              B       D   Q   F          Y   J      &      ;   <   ?              9      -       U   0   (       V         3      #   W           @      \   L       $       =   8              "                    .       >   A   T   
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
 with a cumulative length of %s bytes Project-Id-Version: GNU findutils 4.2.27
Report-Msgid-Bugs-To: bug-findutils@gnu.org
POT-Creation-Date: 2007-06-09 18:49+0100
PO-Revision-Date: 2006-05-23 08:00-0500
Last-Translator: Michel Robitaille <robitail@IRO.UMontreal.CA>
Language-Team: French <traduc@traduc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8-bit
Plural-Forms: nplurals=2; plural=(n > 1);
 
	%s contient des caract�res de chariot (newline),  
	et %s contient des caract�res avec le bit du haut mis � un.
 
	duquel %s contient des espaces blancs,  
Rapporter toutes anomalies � <bug-findutils@gnu.org>.
 
Le r�pertoire utilis� par d�faut est le r�pertoire courant;
l'option par d�faut est -print active.
Une expression peut �tre constitu�e: d'op�rateurs, d'options, de tests et d'actions:
 %s a termin� son ex�cution par le signal %d %s%s a �t� modifi� durant l'ex�cution de %s (ancien no de p�riph�rique %ld, nouveau no de p�riph�rique %ld, type du syst�me de fichiers est %s) [ref %ld] %s%s a �t� modifi� durant l'ex�cution de %s (ancien no d'inode %ld, nouveau no d'inode %ld, type du syst�me de fichiers est %s) [ref %ld] %s: a termin� son ex�cution avec le statut 255; arr�t abrupt. %s: option ill�gale -- %c
 %s: l'option -%c contient un nombre invalide.
 %s: option invalide --%c
 %s: l'option � %c%s � ne requiert pas de param�tre
 %s: l'option � %s � est ambigu�
 %s: l'option � %s � requiert un param�tre
 %s: l'option � --%s � ne requiert pas de param�tre
 %s: l'option � -W %s � ne requiert pas de param�tre
 %s: l'option � -W %s � est ambigu�
 %s: l'option requiert un param�tre -- %c
 %s: stopp� par le signal %d %s a termin� son ex�cution par le signal %d %s: option non reconnue � %c%s �
 %s: option non reconnue � --%s �
 %s: la valeur de l'option -%c devrait �tre < %ld
 %s: la valeur de l'option -%c devrait �tre >= %ld
 ' < %s ... %s > ?  La base de donn�es %s est dans le format %s.
 Options activ�es:  � find � de GNU version %s
 GNU findutils version %s
 GNU locate version %s
 GNU xargs version %s
 S�quence d'�chappement invalide %s dans la sp�cification d'entr�e de d�limiteur S�quence d'�chappement invalide %s dans la sp�cification d'entr�e de d�limiteur; la valeur du caract�re ne doit pas exc�der %lo. S�quence d'�chappement invalide %s dans la sp�cification d'entr�e de d�limiteur; la valeur du caract�re ne doit pas exc�der %lx. S�quence d'�chappement invalide %s dans la sp�cification d'entr�e de d�limiteur; la valeur du caract�re en suffixe %s n'est pas reconnu. Sp�cification d'entr�e de d�limiteur invalide %s: le d�limituer doit �tre soit un caract�re simple ou une s�quence d'�chappement d�butant par \. Taille de la base de donn�es localis�e: %s octets
 La longueur maximale de la commande qui pourrait �tre utilis�e: %ld
 Une seule instance de {} est support�e avec -exec%s ... + Rapporter (et faire le suivi du progr�s de correctif) toutes anomalies selon les instructions se situant sur la
page http://savannah.gnu.org/ ou si vous n'avez pas d'acc�s web en adressant un courriel �
<bug-findutils@gnu.org>. Le r�pertoire courant est inclus dans la variable d'environnement du CHEMIN, lequel est non s�curitaire dans la combinaison avec l'action %s de find. SVP enlever le r�pertoire courant de  $PATH (i.e enlver "." ou : en pr�fixe et suffixe) La variable d'environnement FIND_BLOCK_SIZE n'est pas support�e, la seule chose qui peut affecter la taille de bloc est la variable d'environnement POSIXLY_CORRECT Erreur syst�me inconnue Usage: %s [--version | --help]
ou     %s bigrammes_les_plus_communs < liste_de_fichiers > base-de-donn�es-locate
 Les param�tres valides sont: AVERTISSEMENT: le syst�me de fichiers %s a �t� r�cemment mont�. AVERTISSEMENT: le syst�me de fichier %s a �t� r�cemment d�mont�. Vous ne pouvez utiliser {} � l'int�rieur du nom de l'utilitaire pour --execdir et -okdir, parce qu'il pose un probl�me potentiel de s�curit�. ^[nN] ^[yY] ` actions: -delete -print0 -printf FORMAT -fprintf FICHIER FORMAT -print 
      -fprint0 FILE -fprint FICHIER -ls -fls FICHIER -prune -quit
      -exec COMMANDE ; -exec COMMANDE {} + -ok COMMANDE ;
      -execdir COMMANDE ; -execdir COMMANDE {} + -okdir COMMANDE ;
 le param�tre %s est ambigu� pour %s La ligne de param�tres est trop longue. argument � --limit taille des blocs Ne peut faire un clonage (fork). Ne peut trouver le r�pertoire courant jours double L'environnement est trop large pour l'ex�cution. Erreur s'attendait � %s Erreur lors de l'attente de la fin d'ex�cution du processus enfant. Type invalide pour l'option -size � %c � le param�tre %s est invalide pour %s Param�tre invalide � %s � pour � %s � expression invalide expression invalide; ')' �tait attendu mais n'a pas �t� d�tect� expression invalide; il y a trop de ')' Param�tre nul invalide pour l'option -size pr�dicat invalide � %s � plus haut niveau dans la hi�rarchie du syst�me de fichiers plus haust niveaux dans la hi�rarchie du syst�me de fichiers Param�tre manquant pour � %s � L'insertion du param�tre par d�faut � and � est invalide. oups -- type (%d) de l'expression invalide! Le type d'expression est invalide. les op�rateurs (par pr�c�dence d�croissante; -and est implicite
lorsqu'aucun autre param�tre n'est fourni):
      ( EXPR )   ! EXPR -not EXPR     EXPR1 -a EXPR2   EXPR1 -and EXPR2
 les options positionnelles (toujours vraies i.e. � true �):
      -daystart -follow -regextype
les options normales (toujours vraies i.e. � true � et devant �tre sp�cifi�es
avant les autres expressions):
      -depth --help -maxdepth NIVEAUX -mindepth NIVEAUX -mount -noleaf
      --version -xdev -ignore_readdir_race -noignore_readdir_race
 la v�rification d'int�grit� par la fonction de fnmatch() de la librairie a �chou�. simple les options de tests (N peut �tre +N ou -N ou N):
      -amin N -anewer FICHIER -atime N -cmin N      -cnewer FICHIER -ctime N -empty -false -fstype TYPE -gid N -group NOM
      -ilname MOD�LE -iname MOD�LE -inum N -iwholename MOD�LE -iregex MOD�LE
      -links N -lname MOD�LE -mmin N -mtime N -name MOD�LE -newer FICHIER pr�dicat superflu inattendu inconnu guillemets %s non pair�s; par d�faut les guillemets sont particuliers � xargs � moins d'utiliser l'option -O AVERTISSEMENT: les noms de fichiers Unix habituellement ne contiennent pas de barre obliques (sauf pour les chemins).  Cela signifie que '%s %s' sera �valuer comme �tant faux tout le temps sur ce syst�me.  Vous pouvez trouver que le test '-wholename' est plus utile ou encore celui de '-samefile'.  Alternativement, si vous utilisez GNU grep, vous devriez utiliser 'find ... -print0 | grep -FzZ %s'. AVERTISSEMENT: ne lien symbolique ne sera pas suivi %s AVERTISSEMENT: l'option -d est obsol�te; svp utilisez -depth � la place, parce celle-ci est est une option se conformant � POSIX AVERTISSEMENT: la base de donn�es des localisations peut seulement �tre lue une seule fois � partir de stdin. AVERTISSEMENT: le pr�dicat -ipath est obsol�te; svp utilisez -iwholename � la place. AVERTISSEMENT: s�quence d'�chappement � \%c � inconnue. AVERTISSEMENT: directive de formatage � %%%c � inconnue. AVERTISSEMENT: vous avez sp�cifi� l'option %s apr�s un argument qui n'est pas une option %s mais les options sont positionnelles (%s affecte les tests sp�cifi�s avant aussi bien qu'apr�s)
 avec une longueur cumulaive de %s octets 