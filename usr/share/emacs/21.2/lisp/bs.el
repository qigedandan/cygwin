;;; bs.el --- menu for selecting and displaying buffers

;; Copyright (C) 1998, 1999, 2000, 2001 Free Software Foundation, Inc.
;; Author: Olaf Sylvester <Olaf.Sylvester@netsurf.de>
;; Maintainer: Olaf Sylvester <Olaf.Sylvester@netsurf.de>
;; Keywords: convenience

;; This file is part of GNU Emacs.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; Version: 1.17
;; X-URL: http://home.netsurf.de/olaf.sylvester/emacs
;;
;; The bs-package contains a main function bs-show for poping up a
;; buffer in a way similar to `list-buffers' and `electric-buffer-list':
;; The new buffer offers a Buffer Selection Menu for manipulating
;; the buffer list and buffers.
;;
;; -----------------------------------------------------------------------
;; | MR Buffer          Size  Mode          File                         |
;; | -- ------          ----  ----          ----                         |
;; |.   bs.el           14690  Emacs-Lisp    /home/sun/sylvester/el/bs.e$|
;; |  % executable.el    9429  Emacs-Lisp    /usr/share/emacs/19.34/lisp$|
;; |  % vc.el          104893  Emacs-Lisp    /usr/share/emacs/19.34/lisp$|
;; |  % test_vc.el        486  Emacs-Lisp    /home/sun/sylvester/el/test$|
;; |  % vc-hooks.el     43605  Emacs-Lisp    /usr/share/emacs/19.34/lisp$|
;; -----------------------------------------------------------------------

;;; Quick Installation und Customization:

;; Use
;;   M-x bs-show
;; for buffer selection or optional bind a key to main function `bs-show'
;;   (global-set-key "\C-x\C-b" 'bs-show)    ;; or another key
;;
;; For customization use
;; M-x bs-customize


;;; More Commentary:

;; bs-show will generate a new buffer named *buffer-selection*, which shows
;; all buffers or a subset of them, and has possibilities for deleting,
;; saving and selecting buffers. For more details see docstring of
;; function `bs-mode'. A current configuration describes which buffers appear
;; in *buffer-selection*. See docstring of variable `bs-configurations' for
;; more details.
;;
;; The package bs combines the advantages of the Emacs functions
;; `list-buffers' and `electric-buffer-list'.
;;
;; Additional features for Buffer Selection Menu:
;;  - configurable list of buffers (show only files etc.).
;;  - comfortable way to change displayed subset of all buffers.
;;  - show sorted list of buffers.
;;  - cyclic navigation:
;;     - goes to top of buffer list if you are on last line and press down.
;;     - goes to end of buffer list if you are on first line and press up.
;;  - Offer an alternative buffer list by prefix key C-u.

;;; Cycling through buffers

;; This package offers two functions for buffer cycling. If you want to cycle
;; through buffer list you can use `bs-cycle-next' or `bs-cycle-previous'.
;; Bind these function to a key like
;;   (global-set-key [(f9)]   'bs-cycle-previous)
;;   (global-set-key [(f10)]  'bs-cycle-next)
;;
;; Both functions use a special subset of all buffers for cycling to avoid
;; to go through internal buffers like *Messages*.
;;
;; Cycling through buffers ignores sorting because sorting destroys
;; the logical buffer list. If buffer list is sorted by size you
;; won't be able to cycle to the smallest buffer.

;;; Customization:

;; There is a customization group called `bs' in group `convenience'.
;; Start customization by M-x bs-customize
;;
;; Buffer list
;; -----------
;; You can define your own configurations by extending variable
;; `bs-configurations' (see docstring for details).
;;
;; `bs-default-configuration' contains the name of default configuration.
;; The default value is "files" which means to show only files.
;;
;; If you always want to see all buffers, customize variable
;; `bs-default-configuration' in customization group `bs'.
;;
;; Configure sorting
;; -----------------
;; You can define functions for sorting the buffer list.
;; When selecting buffers, you can step through available sorting
;; methods with key 'S'.
;; To define a new way of sorting, customize variable `bs-sort-functions'.
;;
;; There are four basic functions for sorting:
;;   by buffer name, by mode, by size, or by filename
;;
;; Configure buffer cycling
;; ------------------------
;; When cycling through buffer list the functions for cycling will use
;; the current configuration of bs to calculate the buffer list.
;; If you want to use a different configuration for cycling you have to set
;; the variable `bs-cycle-configuration-name'. You can customize this variable.
;;
;; For example: If you use the configuration called "files-and-scratch" you
;; can cycle through all file buffers and *scratch* although your current
;; configuration perhaps is "files" which ignores buffer *scratch*.

;;; History:

;;; Code:

;; ----------------------------------------------------------------------
;; Globals for customization
;; ----------------------------------------------------------------------

(defgroup bs nil
  "Buffer Selection: Maintaining buffers by buffer menu."
  :version "21.1"
  :link '(emacs-commentary-link "bs")
  :link '(url-link "http://home.netsurf.de/olaf.sylvester/emacs")
  :group 'convenience)

(defgroup bs-appearance nil
  "Buffer Selection appearance: Appearance of bs buffer menu."
  :group 'bs)

(defcustom bs-attributes-list
  '((""       1   1 left  bs--get-marked-string)
    ("M"      1   1 left  bs--get-modified-string)
    ("R"      2   2 left  bs--get-readonly-string)
    ("Buffer" bs--get-name-length 10 left  bs--get-name)
    (""       1   1 left  " ")
    ("Size"   8   8 right bs--get-size-string)
    (""       1   1 left  " ")
    ("Mode"   12 12 right bs--get-mode-name)
    (""       2   2 left  "  ")
    ("File"   12 12 left  bs--get-file-name)
    (""       2   2 left  "  "))
  "*List specifying the layout of a Buffer Selection Menu buffer.
Each entry specifies a column and is a list of the form of:
\(HEADER MINIMUM-LENGTH MAXIMUM-LENGTH ALIGNMENT FUN-OR-STRING)
HEADER         : string for header for first line or a function
  which calculates column title.
MINIMUM-LENGTH : minimum width of column (number or name of function).
  The function must return a positive integer.
MAXIMUM-LENGTH : maximum width of column (number or name of function)
                 (currently ignored)
ALIGNMENT      : alignment of column: (`left' `right' `middle')
FUN-OR-STRING  : Name of a function for calculating the value or
a string for a constant value.
The function gets as parameter the buffer where we have started
buffer selection and the list of all buffers to show.  The function must
return a string representing the column's value."
  :group 'bs-appearance
  :type '(repeat sexp))

(defvar bs--running-in-xemacs (string-match "XEmacs" (emacs-version))
  "Non-nil when running under XEmacs.")

(defun bs--make-header-match-string ()
  "Return a regexp matching the first line of a Buffer Selection Menu buffer."
  (let ((res "^\\(")
	(ele bs-attributes-list))
    (while ele
      (setq res (concat res (car (car ele)) " *"))
      (setq ele (cdr ele)))
    (concat res "$\\)")))

;;; Font-Lock-Settings
(defvar bs-mode-font-lock-keywords
  (list ;; header in font-lock-type-face
   (list (bs--make-header-match-string)
	 '(1 font-lock-type-face append) '(1 'bold append))
   ;; Buffername embedded by *
   (list "^\\(.*\\*.*\\*.*\\)$"
	 1
	 ;; problem in XEmacs with font-lock-constant-face
	 (if (facep 'font-lock-constant-face)
	     'font-lock-constant-face
	   'font-lock-comment-face))
   ;; Dired-Buffers
   '("^..\\(.*Dired by .*\\)$" 1 font-lock-function-name-face)
   ;; the star for modified buffers
   '("^.\\(\\*\\) +[^\\*]"     1 font-lock-comment-face))
  "Default font lock expressions for Buffer Selection Menu.")

(defcustom bs-max-window-height 20
  "*Maximal window height of Buffer Selection Menu."
  :group 'bs-appearance
  :type 'integer)

(defvar bs-dont-show-regexp nil
  "Regular expression specifying which buffers not to show.
A buffer whose name matches this regular expression will not be
included in the buffer list.")

(defvar bs-must-show-regexp nil
  "Regular expression for specifying buffers which must be shown.
A buffer whose name matches this regular expression will be
included in the buffer list.
Note that this variable is temporary: if the configuration is changed
it is reset to nil.  Use `bs-must-always-show-regexp' to specify buffers
that must always be shown regardless of the configuration.")

(defcustom bs-must-always-show-regexp nil
  "*Regular expression for specifying buffers to show always.
A buffer whose name matches this regular expression will
be shown regardless of current configuration of Buffer Selection Menu."
  :group 'bs
  :type '(choice (const :tag "Nothing at all" nil) regexp))

(defvar bs-dont-show-function nil
  "Function for specifying buffers not to show.
The function gets one argument - the buffer to test.  The function must
return a value different from nil to ignore the buffer in
Buffer Selection Menu.")

(defvar bs-must-show-function nil
  "Function for specifying buffers which must be shown.
The function gets one argument - the buffer to test.")

(defvar bs-buffer-sort-function nil
  "Sort function to sort the buffers that appear in Buffer Selection Menu.
The function gets two arguments - the buffers to compare.")

(defcustom bs-maximal-buffer-name-column 45
  "*Maximum column width for buffer names.
The column for buffer names has dynamic width.  The width depends on
maximal and minimal length of names of buffers to show.  The maximal
width is bounded by `bs-maximal-buffer-name-column'.
See also `bs-minimal-buffer-name-column'."
  :group 'bs-appearance
  :type 'integer)

(defcustom bs-minimal-buffer-name-column 15
  "*Minimum column width for buffer names.
The column for buffer names has dynamic width.  The width depends on
maximal and minimal length of names of buffers to show.  The minimal
width is bounded by `bs-minimal-buffer-name-column'.
See also `bs-maximal-buffer-name-column'."
  :group 'bs-appearance
  :type 'integer)

(defconst bs-header-lines-length 2
  "Number of lines for headers in Buffer Selection Menu.")

(defcustom bs-configurations
  '(("all" nil nil nil nil nil)
    ("files" nil nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)
    ("files-and-scratch" "^\\*scratch\\*$" nil nil bs-visits-non-file
     bs-sort-buffer-interns-are-last)
    ("all-intern-last" nil nil nil nil bs-sort-buffer-interns-are-last))
  "*List of all configurations you can use in the Buffer Selection Menu.
A configuration describes which buffers appear in Buffer Selection Menu
and also the order of buffers.  A configuration is a list with
six elements.  The first element is a string and describes the configuration.
The following five elements represent the values for Buffer Selection Menu
configuration variables `bs-must-show-regexp', `bs-must-show-function',
`bs-dont-show-regexp', `bs-dont-show-function' and `bs-buffer-sort-function'.
By setting these variables you define a configuration."
  :group 'bs-appearance
  :type '(repeat sexp))

(defcustom bs-default-configuration "files"
  "*Name of default configuration used by the Buffer Selection Menu.
\\<bs-mode-map>
Will be changed using key \\[bs-select-next-configuration].
Must be a string used in `bs-configurations' for naming a configuration."
  :group 'bs
  :type 'string)

(defcustom bs-alternative-configuration "all"
  "*Name of configuration used when calling `bs-show' with \
\\[universal-argument] as prefix key.
Must be a string used in `bs-configurations' for naming a configuration."
  :group 'bs
  :type  'string)

(defvar bs-current-configuration bs-default-configuration
  "Name of current configuration.
Must be a string used in `bs-configurations' for naming a configuration.")

(defcustom bs-cycle-configuration-name nil
  "*Name of configuration used when cycling through the buffer list.
A value of nil means to use current configuration `bs-default-configuration'.
Must be a string used in `bs-configurations' for naming a configuration."
  :group 'bs
  :type '(choice (const :tag "like current configuration" nil)
   string))

(defcustom bs-string-show-always "+"
  "*String added in column 1 indicating a buffer will always be shown."
  :group 'bs-appearance
  :type 'string)

(defcustom bs-string-show-never "-"
  "*String added in column 1 indicating a buffer will never be shown."
  :group 'bs-appearance
  :type 'string)

(defcustom bs-string-current "."
  "*String added in column 1 indicating the current buffer."
  :group 'bs-appearance
  :type 'string)

(defcustom bs-string-current-marked "#"
  "*String added in column 1 indicating the current buffer when it is marked."
  :group 'bs-appearance
  :type 'string)

(defcustom bs-string-marked ">"
  "*String added in column 1 indicating a marked buffer."
  :group 'bs-appearance
  :type 'string)

(defcustom bs-string-show-normally  " "
  "*String added in column 1 indicating a unmarked buffer."
  :group 'bs-appearance
  :type 'string)

(defvar bs--name-entry-length 20
  "Maximum length of all displayed buffer names.
Used internally, only.")

;; ----------------------------------------------------------------------
;; Internal globals
;; ----------------------------------------------------------------------

(defvar bs-buffer-show-mark nil
  "Flag for the current mode for showing this buffer.
A value of nil means buffer will be shown depending on the current
configuration.
A value of `never' means to never show the buffer.
A value of `always' means to show buffer regardless of the configuration.")

(make-variable-buffer-local 'bs-buffer-show-mark)

;; Make face named region (for XEmacs)
(unless (facep 'region)
  (make-face 'region)
  (set-face-background 'region "gray75"))

(defun bs--sort-by-name (b1 b2)
  "Compare buffers B1 and B2 by buffer name."
  (string< (buffer-name b1)
	   (buffer-name b2)))

(defun bs--sort-by-filename (b1 b2)
  "Compare buffers B1 and B2 by file name."
  (string< (or (buffer-file-name b1) "")
	   (or (buffer-file-name b2) "")))

(defun bs--sort-by-mode (b1 b2)
  "Compare buffers B1 and B2 by mode name."
  (save-excursion
    (string< (progn (set-buffer b1) (format "%s" mode-name))
	     (progn (set-buffer b2) (format "%s" mode-name)))))

(defun bs--sort-by-size (b1 b2)
  "Compare buffers B1 and B2 by buffer size."
  (save-excursion
    (< (progn (set-buffer b1) (buffer-size))
       (progn (set-buffer b2) (buffer-size)))))

(defcustom bs-sort-functions
  '(("by name"     bs--sort-by-name     "Buffer" region)
    ("by size"     bs--sort-by-size     "Size"   region)
    ("by mode"     bs--sort-by-mode     "Mode"   region)
    ("by filename" bs--sort-by-filename "File"   region)
    ("by nothing"  nil                  nil      nil))
  "*List of all possible sorting aspects for Buffer Selection Menu.
You can add a new entry with a call to `bs-define-sort-function'.
Each element is a list of four elements (NAME FUNCTION REGEXP-FOR-SORTING FACE)
NAME specifies the sort order defined by function FUNCTION.
FUNCTION nil means don't sort the buffer list.  Otherwise the functions
must have two parameters - the buffers to compare.
REGEXP-FOR-SORTING is a regular expression which describes the
column title to highlight.
FACE is a face used to fontify the sorted column title.  A value of nil means
don't highlight."
  :group 'bs
  :type '(repeat sexp))

(defun bs-define-sort-function (name fun &optional regexp-for-sorting face)
  "Define a new function for buffer sorting in Buffer Selection Menu.
NAME specifies the sort order defined by function FUN.
A value of nil for FUN means don't sort the buffer list.  Otherwise the
functions must have two parameters - the buffers to compare.
REGEXP-FOR-SORTING is a regular expression which describes the
column title to highlight.
FACE is a face used to fontify the sorted column title.  A value of nil means
don't highlight.
The new sort aspect will be inserted into list `bs-sort-functions'."
  (let ((tupel (assoc name bs-sort-functions)))
    (if tupel
	(setcdr tupel (list fun regexp-for-sorting face))
      (setq bs-sort-functions
	    (cons (list name fun regexp-for-sorting face)
		  bs-sort-functions)))))

(defvar bs--current-sort-function nil
  "Description of the current function for sorting the buffer list.
This is an element of `bs-sort-functions'.")

(defcustom bs-default-sort-name "by nothing"
  "*Name of default sort behavior.
Must be \"by nothing\" or a string used in `bs-sort-functions' for
naming a sort behavior.  Default is \"by nothing\" which means no sorting."
  :group 'bs
  :type  'string
  :set (lambda (var-name value)
	 (set var-name value)
	 (setq bs--current-sort-function
	       (assoc value bs-sort-functions))))

(defvar bs--buffer-coming-from nil
  "The buffer in which the user started the current Buffer Selection Menu.")

(defvar bs--show-all nil
  "Flag whether showing all buffers regardless of current configuration.
Non nil means to show all buffers.  Otherwise show buffers
defined by current configuration `bs-current-configuration'.")

(defvar bs--window-config-coming-from nil
  "Window configuration before starting Buffer Selection Menu.")

(defvar bs--intern-show-never "^ \\|\\*buffer-selection\\*"
  "Regular expression specifying which buffers never to show.
A buffer whose name matches this regular expression will never be
included in the buffer list.")

(defvar bs-current-list nil
  "List of buffers shown in Buffer Selection Menu.
Used internally, only.")

(defvar bs--marked-buffers nil
  "Currently marked buffers in Buffer Selection Menu.")

(defvar bs-mode-map ()
  "Keymap of `bs-mode'.")

(if bs-mode-map
    ()
  (setq bs-mode-map (make-sparse-keymap))
  (define-key bs-mode-map " "       'bs-select)
  (define-key bs-mode-map "f"       'bs-select)
  (define-key bs-mode-map "v"       'bs-view)
  (define-key bs-mode-map "!"       'bs-select-in-one-window)
  (define-key bs-mode-map [mouse-2] 'bs-mouse-select) ;; for GNU EMACS
  (define-key bs-mode-map [button2] 'bs-mouse-select) ;; for XEmacs
  (define-key bs-mode-map "F"       'bs-select-other-frame)

  (let ((key ?1))
    (while (<= key ?9)
      (define-key bs-mode-map (char-to-string key) 'digit-argument)
      (setq key (1+ key))))

  (define-key bs-mode-map "-"       'negative-argument)
  (define-key bs-mode-map "\e-"     'negative-argument)

  (define-key bs-mode-map "o"       'bs-select-other-window)
  (define-key bs-mode-map "\C-o"    'bs-tmp-select-other-window)
  ;; for GNU EMACS
  (define-key bs-mode-map [mouse-3] 'bs-mouse-select-other-frame)
  ;; for XEmacs
  (define-key bs-mode-map [button3] 'bs-mouse-select-other-frame)
  (define-key bs-mode-map [up]      'bs-up)
  (define-key bs-mode-map "n"       'bs-down)
  (define-key bs-mode-map "p"       'bs-up)
  (define-key bs-mode-map [down]    'bs-down)
  (define-key bs-mode-map "\C-m"    'bs-select)
  (define-key bs-mode-map "b"       'bs-bury-buffer)
  (define-key bs-mode-map "s"       'bs-save)
  (define-key bs-mode-map "S"       'bs-show-sorted)
  (define-key bs-mode-map "a"       'bs-toggle-show-all)
  (define-key bs-mode-map "d"       'bs-delete)
  (define-key bs-mode-map "\C-d"    'bs-delete-backward)
  (define-key bs-mode-map "k"       'bs-delete)
  (define-key bs-mode-map "g"       'bs-refresh)
  (define-key bs-mode-map "C"       'bs-set-configuration-and-refresh)
  (define-key bs-mode-map "c"       'bs-select-next-configuration)
  (define-key bs-mode-map "q"       'bs-kill)
  ;; (define-key bs-mode-map "z"       'bs-kill)
  (define-key bs-mode-map "\C-c\C-c" 'bs-kill)
  (define-key bs-mode-map "\C-g"    'bs-abort)
  (define-key bs-mode-map "\C-]"    'bs-abort)
  (define-key bs-mode-map "%"       'bs-toggle-readonly)
  (define-key bs-mode-map "~"       'bs-clear-modified)
  (define-key bs-mode-map "M"       'bs-toggle-current-to-show)
  (define-key bs-mode-map "+"       'bs-set-current-buffer-to-show-always)
  ;;(define-key bs-mode-map "-"       'bs-set-current-buffer-to-show-never)
  (define-key bs-mode-map "t"       'bs-visit-tags-table)
  (define-key bs-mode-map "m"       'bs-mark-current)
  (define-key bs-mode-map "u"       'bs-unmark-current)
  (define-key bs-mode-map ">"       'scroll-right)
  (define-key bs-mode-map "<"       'scroll-left)
  (define-key bs-mode-map "\e\e"    nil)
  (define-key bs-mode-map "\e\e\e"  'bs-kill)
  (define-key bs-mode-map [escape escape escape] 'bs-kill)
  (define-key bs-mode-map "?"       'bs-help))

;; ----------------------------------------------------------------------
;; Functions
;; ----------------------------------------------------------------------

(defun bs-buffer-list (&optional list sort-description)
  "Return a list of buffers to be shown.
LIST is a list of buffers to test for appearance in Buffer Selection Menu.
The result list depends on the global variables `bs-dont-show-regexp',
`bs-must-show-regexp', `bs-dont-show-function', `bs-must-show-function'
and `bs-buffer-sort-function'.
If SORT-DESCRIPTION isn't nil the list will be sorted by
a special function.  SORT-DESCRIPTION is an element of `bs-sort-functions'."
  (setq sort-description (or sort-description bs--current-sort-function)
	list (or list (buffer-list)))
  (let ((result nil))
    (while list
      (let* ((buffername (buffer-name (car list)))
	     (int-show-never (string-match bs--intern-show-never buffername))
	     (ext-show-never (and bs-dont-show-regexp
				  (string-match bs-dont-show-regexp
						buffername)))
	     (extern-must-show (or (and bs-must-always-show-regexp
					(string-match
					 bs-must-always-show-regexp
					 buffername))
				   (and bs-must-show-regexp
					(string-match bs-must-show-regexp
						      buffername))))
	     (extern-show-never-from-fun (and bs-dont-show-function
					      (funcall bs-dont-show-function
						       (car list))))
	     (extern-must-show-from-fun (and bs-must-show-function
					     (funcall bs-must-show-function
						      (car list))))
	     (show-flag (save-excursion
			  (set-buffer (car list))
			  bs-buffer-show-mark)))
	(if (or (eq show-flag 'always)
		(and (or bs--show-all (not (eq show-flag 'never)))
		     (not int-show-never)
		     (or bs--show-all
			 extern-must-show
			 extern-must-show-from-fun
			 (and (not ext-show-never)
			      (not extern-show-never-from-fun)))))
	    (setq result (cons (car list)
			       result)))
	(setq list (cdr list))))
    (setq result (reverse result))
    ;; The current buffer which was the start point of bs should be an element
    ;; of result list, so that we can leave with space and be back in the
    ;; buffer we started bs-show.
    (if (and bs--buffer-coming-from
	     (buffer-live-p bs--buffer-coming-from)
	     (not (memq bs--buffer-coming-from result)))
	(setq result (cons bs--buffer-coming-from result)))
    ;; sorting
    (if (and sort-description
	     (nth 1 sort-description))
	(setq result (sort result (nth 1 sort-description)))
      ;; else standard sorting
      (bs-buffer-sort result))))

(defun bs-buffer-sort (buffer-list)
  "Sort buffers in BUFFER-LIST according to `bs-buffer-sort-function'."
  (if bs-buffer-sort-function
      (sort buffer-list bs-buffer-sort-function)
    buffer-list))

(defun bs--redisplay (&optional keep-line-p sort-description)
  "Redisplay whole Buffer Selection Menu.
If KEEP-LINE-P is non nil the point will stay on current line.
SORT-DESCRIPTION is an element of `bs-sort-functions'"
  (let ((line (1+ (count-lines 1 (point)))))
    (bs-show-in-buffer (bs-buffer-list nil sort-description))
    (if keep-line-p
	(goto-line line))
    (beginning-of-line)))

(defun bs--goto-current-buffer ()
  "Goto line which represents the current buffer;
actually the line which begins with character in `bs-string-current' or
`bs-string-current-marked'."
  (let ((regexp (concat "^"
			(regexp-quote bs-string-current)
			"\\|^"
			(regexp-quote bs-string-current-marked)))
	point)
    (save-excursion
      (goto-char (point-min))
      (if (search-forward-regexp regexp nil t)
	  (setq point (- (point) 1))))
    (if point
	(goto-char point))))

(defun bs--current-config-message ()
  "Return a string describing the current `bs-mode' configuration."
  (if bs--show-all
      "Show all buffers."
    (format "Show buffer by configuration %S"
	    bs-current-configuration)))

(defun bs-mode ()
  "Major mode for editing a subset of Emacs' buffers.
\\<bs-mode-map>
Aside from two header lines each line describes one buffer.
Move to a line representing the buffer you want to edit and select
buffer by \\[bs-select] or SPC. Abort buffer list with \\[bs-kill].
There are many key commands similar to `Buffer-menu-mode' for
manipulating the buffer list and buffers.
For faster navigation each digit key is a digit argument.

\\[bs-select] or SPACE -- select current line's buffer and other marked buffers.
\\[bs-toggle-show-all]  -- toggle between all buffers and a special subset.
\\[bs-select-other-window] -- select current line's buffer in other window.
\\[bs-tmp-select-other-window] -- make another window display that buffer and
    remain in Buffer Selection Menu.
\\[bs-mouse-select] -- select current line's buffer and other marked buffers.
\\[bs-save] -- save current line's buffer immediatly.
\\[bs-delete] -- kill current line's buffer immediatly.
\\[bs-toggle-readonly] -- toggle read-only status of current line's buffer.
\\[bs-clear-modified] -- clear modified-flag on that buffer.
\\[bs-mark-current] -- mark current line's buffer to be displayed.
\\[bs-unmark-current] -- unmark current line's buffer to be displayed.
\\[bs-show-sorted] -- display buffer list sorted by next sort aspect.
\\[bs-set-configuration-and-refresh] -- ask user for a configuration and \
apply selected configuration.
\\[bs-select-next-configuration] -- select and apply next \
available Buffer Selection Menu configuration.
\\[bs-kill] -- leave Buffer Selection Menu without a selection.
\\[bs-toggle-current-to-show] -- toggle status of appearance.
\\[bs-set-current-buffer-to-show-always] -- mark current line's buffer \
to show always.
\\[bs-visit-tags-table] -- call `visit-tags-table' on current line's buffer.
\\[bs-help] -- display this help text."
  (interactive)
  (kill-all-local-variables)
  (use-local-map bs-mode-map)
  (make-local-variable 'font-lock-defaults)
  (make-local-variable 'font-lock-verbose)
  (setq major-mode 'bs-mode
	mode-name "Buffer-Selection-Menu"
	buffer-read-only t
	truncate-lines t
	font-lock-defaults '(bs-mode-font-lock-keywords t)
	font-lock-verbose nil)
  (run-hooks 'bs-mode-hook))

(defun bs-kill ()
  "Let buffer disappear and reset window-configuration."
  (interactive)
  (bury-buffer (current-buffer))
  (set-window-configuration bs--window-config-coming-from))

(defun bs-abort ()
  "Ding and leave Buffer Selection Menu without a selection."
  (interactive)
  (ding)
  (bs-kill))

(defun bs-set-configuration-and-refresh ()
  "Ask user for a configuration and apply selected configuration.
Refresh whole Buffer Selection Menu."
  (interactive)
  (call-interactively 'bs-set-configuration)
  (bs--redisplay t))

(defun bs-refresh ()
  "Refresh whole Buffer Selection Menu."
  (interactive)
  (bs--redisplay t))

(defun bs--window-for-buffer (buffer-name)
  "Return a window showing a buffer with name BUFFER-NAME.
Take only windows of current frame into account.
Return nil if there is no such buffer."
  (let ((window nil))
    (walk-windows (lambda (wind)
		    (if (string= (buffer-name (window-buffer wind))
				 buffer-name)
			(setq window wind))))
    window))

(defun bs--set-window-height ()
  "Change the height of the selected window to suit the current buffer list."
  (unless (one-window-p t)
    (shrink-window (- (window-height (selected-window))
		      ;; window-height in xemacs includes mode-line
		      (+ (if bs--running-in-xemacs 3 1)
			 bs-header-lines-length
			 (min (length bs-current-list)
			      bs-max-window-height))))))

(defun bs--current-buffer ()
  "Return buffer on current line.
Raise an error if not on a buffer line."
  (beginning-of-line)
  (let ((line (+ (- bs-header-lines-length)
		 (count-lines 1 (point)))))
    (if (< line 0)
	(error "You are on a header row"))
    (nth line bs-current-list)))

(defun bs--update-current-line ()
  "Update the entry on current line for Buffer Selection Menu."
  (let ((buffer (bs--current-buffer))
	(inhibit-read-only t))
    (beginning-of-line)
    (delete-region (point) (line-end-position))
    (bs--insert-one-entry buffer)
    (beginning-of-line)))

(defun bs-view ()
  "View current line's buffer in View mode.
Leave Buffer Selection Menu."
  (interactive)
  (view-buffer (bs--current-buffer)))

(defun bs-select ()
  "Select current line's buffer and other marked buffers.
If there are no marked buffers the window configuration before starting
Buffer Selectin Menu will be restored.
If there are marked buffers each marked buffer and the current line's buffer
will be selected in a window.
Leave Buffer Selection Menu."
  (interactive)
  (let ((buffer (bs--current-buffer)))
    (bury-buffer (current-buffer))
    (set-window-configuration bs--window-config-coming-from)
    (switch-to-buffer buffer)
    (if bs--marked-buffers
	;; Some marked buffers for selection
	(let* ((all (delq buffer bs--marked-buffers))
	       (height (/ (1- (frame-height)) (1+ (length all)))))
	  (delete-other-windows)
	  (switch-to-buffer buffer)
	  (while all
	    (split-window nil height)
	    (other-window 1)
	    (switch-to-buffer (car all))
	    (setq all (cdr all)))
	  ;; goto window we have started bs.
	  (other-window 1)))))

(defun bs-select-other-window ()
  "Select current line's buffer by `switch-to-buffer-other-window'.
The window configuration before starting Buffer Selectin Menu will be restored
unless there is no other window.  In this case a new window will be created.
Leave Buffer Selection Menu."
  (interactive)
  (let ((buffer (bs--current-buffer)))
    (bury-buffer (current-buffer))
    (set-window-configuration bs--window-config-coming-from)
    (switch-to-buffer-other-window buffer)))

(defun bs-tmp-select-other-window ()
  "Make the other window select this line's buffer.
The current window remains selected."
  (interactive)
  (let ((buffer (bs--current-buffer)))
    (display-buffer buffer t)))

(defun bs-select-other-frame ()
  "Select current line's buffer in new created frame.
Leave Buffer Selection Menu."
  (interactive)
  (let ((buffer (bs--current-buffer)))
    (bury-buffer (current-buffer))
    (set-window-configuration bs--window-config-coming-from)
    (switch-to-buffer-other-frame buffer)))

(defun bs-mouse-select-other-frame (event)
  "Select selected line's buffer in new created frame.
Leave Buffer Selection Menu.
EVENT: a mouse click EVENT."
  (interactive "e")
  (mouse-set-point event)
  (bs-select-other-frame))

(defun bs-mouse-select (event)
  "Select buffer on mouse click EVENT.
Select buffer by `bs-select'."
  (interactive "e")
  (mouse-set-point event)
  (bs-select))

(defun bs-select-in-one-window ()
  "Select current line's buffer in one window and delete other windows.
Leave Buffer Selection Menu."
  (interactive)
  (bs-select)
  (delete-other-windows))

(defun bs-bury-buffer ()
  "Bury buffer on current line."
  (interactive)
  (bury-buffer (bs--current-buffer))
  (bs--redisplay t))

(defun bs-save ()
  "Save buffer on current line."
  (interactive)
  (let ((buffer (bs--current-buffer)))
    (save-excursion
      (set-buffer buffer)
      (save-buffer))
    (bs--update-current-line)))

(defun bs-visit-tags-table ()
  "Visit the tags table in the buffer on this line.
See `visit-tags-table'."
  (interactive)
  (let ((file (buffer-file-name (bs--current-buffer))))
    (if file
	(visit-tags-table file)
      (error "Specified buffer has no file"))))

(defun bs-toggle-current-to-show ()
  "Toggle status of showing flag for buffer in current line."
  (interactive)
  (let ((buffer (bs--current-buffer))
	res)
    (save-excursion
      (set-buffer buffer)
      (setq res (cond ((null bs-buffer-show-mark)
		       'never)
		      ((eq bs-buffer-show-mark 'never)
		       'always)
		      (t nil)))
      (setq bs-buffer-show-mark res))
    (bs--update-current-line)
    (bs--set-window-height)
    (bs--show-config-message res)))

(defun bs-set-current-buffer-to-show-always (&optional not-to-show-p)
  "Toggle status of buffer on line to `always shown'.
NOT-TO-SHOW-P: prefix argument.
With no prefix argument the buffer on current line is marked to show
always.  Otherwise it is marked to show never."
  (interactive "P")
  (if not-to-show-p
      (bs-set-current-buffer-to-show-never)
    (bs--set-toggle-to-show (bs--current-buffer) 'always)))

(defun bs-set-current-buffer-to-show-never ()
  "Toggle status of buffer on line to `never shown'."
  (interactive)
  (bs--set-toggle-to-show (bs--current-buffer) 'never))

(defun bs--set-toggle-to-show (buffer what)
  "Set value `bs-buffer-show-mark' of buffer BUFFER to WHAT.
Redisplay current line and display a message describing
the status of buffer on current line."
  (save-excursion
    (set-buffer buffer)
    (setq bs-buffer-show-mark what))
  (bs--update-current-line)
  (bs--set-window-height)
  (bs--show-config-message what))

(defun bs-mark-current (count)
  "Mark buffers.
COUNT is the number of buffers to mark.
Move cursor vertically down COUNT lines."
  (interactive "p")
  (let ((dir (if (> count 0) 1 -1))
	(count (abs count)))
    (while (> count 0)
      (let ((buffer (bs--current-buffer)))
	(if buffer
	    (setq bs--marked-buffers (cons buffer bs--marked-buffers)))
	(bs--update-current-line)
	(bs-down dir))
      (setq count (1- count)))))

(defun bs-unmark-current (count)
  "Unmark buffers.
COUNT is the number of buffers to unmark.
Move cursor vertically down COUNT lines."
  (interactive "p")
  (let ((dir (if (> count 0) 1 -1))
	(count (abs count)))
    (while (> count 0)
      (let ((buffer (bs--current-buffer)))
	(if buffer
	    (setq bs--marked-buffers (delq buffer bs--marked-buffers)))
	(bs--update-current-line)
	(bs-down dir))
      (setq count (1- count)))))

(defun bs--show-config-message (what)
  "Show message indicating the new showing status WHAT.
WHAT is a value of nil, `never', or `always'."
  (bs-message-without-log (cond ((null what)
				 "Buffer will be shown normally.")
				((eq what 'never)
				 "Mark buffer to never be shown.")
				(t "Mark buffer to show always."))))

(defun bs-delete ()
  "Kill buffer on current line."
  (interactive)
  (let ((current (bs--current-buffer))
	(inhibit-read-only t))
    (setq bs-current-list (delq current bs-current-list))
    (kill-buffer current)
    (beginning-of-line)
    (delete-region (point) (save-excursion
			     (end-of-line)
			     (if (eobp) (point) (1+ (point)))))
    (if (eobp)
	(progn
	  (backward-delete-char 1)
	  (beginning-of-line)
	  (recenter -1)))
    (bs--set-window-height)))

(defun bs-delete-backward ()
  "Like `bs-delete' but go to buffer in front of current."
  (interactive)
  (let ((on-last-line-p (save-excursion (end-of-line) (eobp))))
    (bs-delete)
    (unless on-last-line-p
      (bs-up 1))))

(defun bs-show-sorted ()
  "Show buffer list sorted by buffer name."
  (interactive)
  (setq bs--current-sort-function
	(bs-next-config-aux (car bs--current-sort-function)
			    bs-sort-functions))
  (bs--redisplay)
  (bs--goto-current-buffer)
  (bs-message-without-log "Sorted %s" (car bs--current-sort-function)))

(defun bs-apply-sort-faces (&optional sort-description)
  "Set text properties for the sort described by SORT-DESCRIPTION.
SORT-DESCRIPTION is an element of `bs-sort-functions'.
Default is `bs--current-sort-function'."
  (let ((sort-description (or sort-description
			      bs--current-sort-function)))
    (save-excursion
      (goto-char (point-min))
      (if (and (nth 2 sort-description)
	       (search-forward-regexp (nth 2 sort-description) nil t))
	  (let ((inhibit-read-only t))
	    (put-text-property (match-beginning 0)
			       (match-end 0)
			       'face
			       (or (nth 3 sort-description)
				   'region)))))))

(defun bs-toggle-show-all ()
  "Toggle show all buffers / show buffers with current configuration."
  (interactive)
  (setq bs--show-all (not bs--show-all))
  (bs--redisplay)
  (bs--goto-current-buffer)
  (bs-message-without-log "%s" (bs--current-config-message)))

(defun bs-toggle-readonly ()
  "Toggle read-only status for buffer on current line.
Uses function `vc-toggle-read-only'."
  (interactive)
  (let ((buffer (bs--current-buffer)))
    (save-excursion
      (set-buffer buffer)
      (vc-toggle-read-only))
    (bs--update-current-line)))

(defun bs-clear-modified ()
  "Set modified flag for buffer on current line to nil."
  (interactive)
  (let ((buffer (bs--current-buffer)))
    (save-excursion
      (set-buffer buffer)
      (set-buffer-modified-p nil)))
  (bs--update-current-line))

(defun bs--nth-wrapper (count fun &rest args)
  "Call COUNT times function FUN with arguments ARGS."
  (setq count (or count 1))
  (while (> count 0)
    (apply fun args)
    (setq count (1- count))))

(defun bs-up (arg)
  "Move cursor vertically up ARG lines in Buffer Selection Menu."
  (interactive "p")
  (if (and arg (numberp arg) (< arg 0))
      (bs--nth-wrapper (- arg) 'bs--down)
    (bs--nth-wrapper arg 'bs--up)))

(defun bs--up ()
  "Move cursor vertically up one line.
If on top of buffer list go to last line."
  (interactive "p")
  (previous-line 1)
  (if (<= (count-lines 1 (point)) (1- bs-header-lines-length))
      (progn
	(goto-char (point-max))
	(beginning-of-line)
	(recenter -1))
    (beginning-of-line)))

(defun bs-down (arg)
  "Move cursor vertically down ARG lines in Buffer Selection Menu."
  (interactive "p")
  (if (and arg (numberp arg) (< arg 0))
      (bs--nth-wrapper (- arg) 'bs--up)
    (bs--nth-wrapper arg 'bs--down)))

(defun bs--down ()
  "Move cursor vertically down one line.
If at end of buffer list go to first line."
  (let ((last (line-end-position)))
    (if (eq last (point-max))
	(goto-line (1+ bs-header-lines-length))
      (next-line 1))))

(defun bs-visits-non-file (buffer)
  "Return t or nil whether BUFFER visits no file.
A value of t means BUFFER belongs to no file.
A value of nil means BUFFER belongs to a file."
  (not (buffer-file-name buffer)))

(defun bs-sort-buffer-interns-are-last (b1 b2)
  "Function for sorting internal buffers B1 and B2 at the end of all buffers."
  (string-match "^\\*" (buffer-name b2)))

;; ----------------------------------------------------------------------
;; Configurations:
;; ----------------------------------------------------------------------

(defun bs-config-clear ()
  "*Reset all variables which specify a configuration.
These variables are `bs-dont-show-regexp', `bs-must-show-regexp',
`bs-dont-show-function', `bs-must-show-function' and
`bs-buffer-sort-function'."
  (setq bs-dont-show-regexp nil
	bs-must-show-regexp nil
	bs-dont-show-function nil
	bs-must-show-function nil
	bs-buffer-sort-function nil))

(defun bs-config--only-files ()
  "Define a configuration for showing only buffers visiting a file."
  (bs-config-clear)
  (setq ;; I want to see *-buffers at the end
   bs-buffer-sort-function 'bs-sort-buffer-interns-are-last
   ;; Don't show files who don't belong to a file
   bs-dont-show-function 'bs-visits-non-file))

(defun bs-config--files-and-scratch ()
  "Define a configuration for showing buffer *scratch* and file buffers."
  (bs-config-clear)
  (setq ;; I want to see *-buffers at the end
   bs-buffer-sort-function 'bs-sort-buffer-interns-are-last
   ;; Don't show files who don't belong to a file
   bs-dont-show-function 'bs-visits-non-file
   ;; Show *scratch* buffer.
   bs-must-show-regexp "^\\*scratch\\*$"))

(defun bs-config--all ()
  "Define a configuration for showing all buffers.
Reset all according variables by `bs-config-clear'."
  (bs-config-clear))

(defun bs-config--all-intern-last ()
  "Define a configuration for showing all buffers.
Internal buffers appear at end of all buffers."
  (bs-config-clear)
  ;; I want to see *-buffers at the end
  (setq bs-buffer-sort-function 'bs-sort-buffer-interns-are-last))

(defun bs-set-configuration (name)
  "Set configuration to the one saved under string NAME in `bs-configurations'.
When called interactively ask user for a configuration and apply selected
configuration."
  (interactive (list (completing-read "Use configuration: "
				      bs-configurations
				      nil
				      t)))
  (let ((list (assoc name bs-configurations)))
    (if list
	(if (listp list)
	    (setq bs-current-configuration name
		  bs-must-show-regexp     (nth 1 list)
		  bs-must-show-function   (nth 2 list)
		  bs-dont-show-regexp     (nth 3 list)
		  bs-dont-show-function   (nth 4 list)
		  bs-buffer-sort-function (nth 5 list))
	  ;; for backward compability
	  (funcall (cdr list)))
      ;; else
      (ding)
      (bs-message-without-log "No bs-configuration named %S." name))))

(defun bs-help ()
  "Help for `bs-show'."
  (interactive)
  (describe-function 'bs-mode))

(defun bs-next-config-aux (start-name list)
  "Get the next assoc after START-NAME in list LIST.
Will return the first if START-NAME is at end."
  (let ((assocs list)
	(length (length list))
	pos)
    (while (and assocs (not pos))
      (if (string= (car (car assocs)) start-name)
	  (setq pos (- length (length assocs))))
      (setq assocs (cdr assocs)))
    (setq pos (1+ pos))
    (if (eq pos length)
	(car list)
      (nth pos list))))

(defun bs-next-config (name)
  "Return next configuration with respect to configuration with name NAME."
  (bs-next-config-aux name bs-configurations))

(defun bs-select-next-configuration (&optional start-name)
  "Apply next configuration START-NAME and refresh buffer list.
If START-NAME is nil the current configuration `bs-current-configuration'
will be used."
  (interactive)
  (let ((config (bs-next-config (or start-name bs-current-configuration))))
    (bs-set-configuration (car config))
    (setq bs-default-configuration bs-current-configuration)
    (bs--redisplay t)
    (bs--set-window-height)
    (bs-message-without-log "Selected configuration: %s" (car config))))

(defun bs-show-in-buffer (list)
  "Display buffer list LIST in buffer *buffer-selection*.
Select buffer *buffer-selection* and display buffers according to current
configuration `bs-current-configuration'.  Set window height, fontify buffer
and move point to current buffer."
  (setq bs-current-list list)
  (switch-to-buffer (get-buffer-create "*buffer-selection*"))
  (bs-mode)
  (let* ((inhibit-read-only t)
	 (map-fun (lambda (entry)
		    (length (buffer-name entry))))
	 (max-length-of-names (apply 'max
				     (cons 0 (mapcar map-fun list))))
	 (name-entry-length (min bs-maximal-buffer-name-column
				 (max bs-minimal-buffer-name-column
				      max-length-of-names))))
    (erase-buffer)
    (setq bs--name-entry-length name-entry-length)
    (bs--show-header)
    (while list
      (bs--insert-one-entry (car list))
      (insert "\n")
      (setq list (cdr list)))
    (delete-backward-char 1)
    (bs--set-window-height)
    (bs--goto-current-buffer)
    (font-lock-fontify-buffer)
    (bs-apply-sort-faces)))

(defun bs-next-buffer (&optional buffer-list sorting-p)
  "Return next buffer and buffer list for buffer cycling in BUFFER-LIST.
Ignore sorting when SORTING-P is nil.
If BUFFER-LIST is nil the result of `bs-buffer-list' will be used as
buffer list.  The result is a cons of normally the second element of
BUFFER-LIST and the buffer list used for buffer cycling."
  (let* ((bs--current-sort-function (if sorting-p
					bs--current-sort-function))
	 (bs-buffer-list (or buffer-list (bs-buffer-list))))
    (cons (or (car (cdr bs-buffer-list))
	      (car bs-buffer-list)
	      (current-buffer))
	  bs-buffer-list)))

(defun bs-previous-buffer (&optional buffer-list sorting-p)
  "Return previous buffer and buffer list for buffer cycling in BUFFER-LIST.
Ignore sorting when SORTING-P is nil.
If BUFFER-LIST is nil the result of `bs-buffer-list' will be used as
buffer list.  The result is a cons of last element of BUFFER-LIST and the
buffer list used for buffer cycling."
  (let* ((bs--current-sort-function (if sorting-p
					bs--current-sort-function))
	 (bs-buffer-list (or buffer-list (bs-buffer-list))))
    (cons (or (car (last bs-buffer-list))
	      (current-buffer))
	  bs-buffer-list)))

(defun bs-message-without-log (&rest args)
  "Like `message' but don't log it on the message log.
All arguments ARGS are transfered to function `message'."
  (let ((message-log-max nil))
    (apply 'message args)))

(defvar bs--cycle-list nil
  "Current buffer list used for cycling.")

;;;###autoload
(defun bs-cycle-next ()
  "Select next buffer defined by buffer cycling.
The buffers taking part in buffer cycling are defined
by buffer configuration `bs-cycle-configuration-name'."
  (interactive)
  (let ((bs--buffer-coming-from (current-buffer))
	(bs-dont-show-regexp   bs-dont-show-regexp)
	(bs-must-show-regexp   bs-must-show-regexp)
	(bs-dont-show-function bs-dont-show-function)
	(bs-must-show-function bs-must-show-function)
	(bs--show-all          nil))
    (bs-set-configuration (or bs-cycle-configuration-name bs-default-configuration))
    (let ((bs-buffer-sort-function nil)
	  (bs--current-sort-function nil))
      (let* ((tupel (bs-next-buffer (if (or (eq last-command
						'bs-cycle-next)
					    (eq last-command
						'bs-cycle-previous))
					bs--cycle-list)))
	     (next (car tupel))
	     (cycle-list (cdr tupel)))
	(setq bs--cycle-list (append (cdr cycle-list)
				     (list (car cycle-list))))
	(bury-buffer)
	(switch-to-buffer next)
	(bs-message-without-log "Next buffers: %s"
				(or (cdr bs--cycle-list)
				    "this buffer"))))))


;;;###autoload
(defun bs-cycle-previous ()
  "Select previous buffer defined by buffer cycling.
The buffers taking part in buffer cycling are defined
by buffer configuration `bs-cycle-configuration-name'."
  (interactive)
  (let ((bs--buffer-coming-from (current-buffer))
	(bs-dont-show-regexp   bs-dont-show-regexp)
	(bs-must-show-regexp   bs-must-show-regexp)
	(bs-dont-show-function bs-dont-show-function)
	(bs-must-show-function bs-must-show-function)
	(bs--show-all          nil))
    (bs-set-configuration (or bs-cycle-configuration-name bs-default-configuration))
    (let ((bs-buffer-sort-function nil)
	  (bs--current-sort-function nil))
      (let* ((tupel (bs-previous-buffer (if (or (eq last-command
						    'bs-cycle-next)
						(eq last-command
						    'bs-cycle-previous))
					    bs--cycle-list)))
	     (prev-buffer (car tupel))
	     (cycle-list (cdr tupel)))
	(setq bs--cycle-list (append (last cycle-list)
				     (reverse (cdr (reverse cycle-list)))))
	(switch-to-buffer prev-buffer)
	(bs-message-without-log "Previous buffers: %s"
				(or (reverse (cdr bs--cycle-list))
				    "this buffer"))))))

(defun bs--get-value (fun &optional args)
  "Apply function FUN with arguments ARGS.
Return result of evaluation.  Will return FUN if FUN is a number
or a string."
  (cond ((numberp fun)
	 fun)
	((stringp fun)
	 fun)
	(t (apply fun args))))

(defun bs--get-marked-string (start-buffer all-buffers)
  "Return a string which describes whether current buffer is marked.
START-BUFFER is the buffer where we started buffer selection.
ALL-BUFFERS is the list of buffer appearing in Buffer Selection Menu.
The result string is one of `bs-string-current', `bs-string-current-marked',
`bs-string-marked', `bs-string-show-normally', `bs-string-show-never', or
`bs-string-show-always'."
  (cond ;; current buffer is the buffer we started buffer selection.
   ((eq (current-buffer) start-buffer)
    (if (memq (current-buffer) bs--marked-buffers)
	bs-string-current-marked	; buffer is marked
      bs-string-current))
   ;; current buffer is marked
   ((memq (current-buffer) bs--marked-buffers)
    bs-string-marked)
   ;; current buffer hasn't a special mark.
   ((null bs-buffer-show-mark)
    bs-string-show-normally)
   ;; current buffer has a mark not to show itself.
   ((eq bs-buffer-show-mark 'never)
    bs-string-show-never)
   ;; otherwise current buffer is marked to show always.
   (t
    bs-string-show-always)))

(defun bs--get-modified-string (start-buffer all-buffers)
  "Return a string which describes whether current buffer is modified.
START-BUFFER is the buffer where we started buffer selection.
ALL-BUFFERS is the list of buffer appearing in Buffer Selection Menu."
  (if (buffer-modified-p) "*" " "))

(defun bs--get-readonly-string (start-buffer all-buffers)
  "Return a string which describes whether current buffer is read only.
START-BUFFER is the buffer where we started buffer selection.
ALL-BUFFERS is the list of buffer appearing in Buffer Selection Menu."
  (if buffer-read-only "%" " "))

(defun bs--get-size-string (start-buffer all-buffers)
  "Return a string which describes the size of current buffer.
START-BUFFER is the buffer where we started buffer selection.
ALL-BUFFERS is the list of buffer appearing in Buffer Selection Menu."
  (int-to-string (buffer-size)))

(defun bs--get-name (start-buffer all-buffers)
  "Return name of current buffer for Buffer Selection Menu.
The name of current buffer gets additional text properties
for mouse highlighting.
START-BUFFER is the buffer where we started buffer selection.
ALL-BUFFERS is the list of buffer appearing in Buffer Selection Menu."
  (let ((name (copy-sequence (buffer-name))))
    (add-text-properties
     0 (length name)
     '(mouse-face highlight
       help-echo
       "mouse-2: select this buffer, mouse-3: select in other frame")
     name)
    (if (< (length name) bs--name-entry-length)
	(concat name
		(make-string (- bs--name-entry-length (length name)) ? ))
      name)))

(defun bs--get-mode-name (start-buffer all-buffers)
  "Return the name of mode of current buffer for Buffer Selection Menu.
START-BUFFER is the buffer where we started buffer selection.
ALL-BUFFERS is the list of buffer appearing in Buffer Selection Menu."
  mode-name)

(defun bs--get-file-name (start-buffer all-buffers)
  "Return string for column 'File' in Buffer Selection Menu.
This is the variable `buffer-file-name' of current buffer.
If current mode is `dired-mode' or `shell-mode' it returns the
default directory.
START-BUFFER is the buffer where we started buffer selection.
ALL-BUFFERS is the list of buffer appearing in Buffer Selection Menu."
  (let ((string (copy-sequence (if (member major-mode
					   '(shell-mode dired-mode))
				   default-directory
				 (or buffer-file-name "")))))
    (add-text-properties
     0 (length string)
     '(mouse-face highlight
       help-echo "mouse-2: select this buffer, mouse-3: select in other frame")
     string)
    string))

(defun bs--insert-one-entry (buffer)
  "Generate one entry for buffer BUFFER in Buffer Selection Menu.
It goes over all columns described in `bs-attributes-list'
and evaluates corresponding string.  Inserts string in current buffer;
normally *buffer-selection*."
  (let ((string "")
	(columns bs-attributes-list)
	(to-much 0)
        (apply-args (append (list bs--buffer-coming-from bs-current-list))))
    (save-excursion
      (while columns
	(set-buffer buffer)
	(let ((min   (bs--get-value (nth 1 (car columns))))
	      ;;(max   (bs--get-value (nth 2 (car columns)))) refered no more
	      (align (nth 3 (car columns)))
	      (fun   (nth 4 (car columns)))
	      (val   nil)
	      new-string)
	  (setq val (bs--get-value fun apply-args))
	  (setq new-string (bs--format-aux val align (- min to-much)))
	  (setq string (concat string new-string))
	  (if (> (length new-string) min)
	      (setq to-much (- (length new-string) min)))
	  )				; let
	(setq columns (cdr columns))))
    (insert string)
    string))

(defun bs--format-aux (string align len)
  "Generate a string with STRING with alignment ALIGN and length LEN.
ALIGN is one of the symbols `left', `middle', or `right'."
  (let ((length (length string)))
    (if (>= length len)
	string
      (if (eq 'right align)
	  (concat (make-string (- len length) ? ) string)
	(concat string (make-string (- len length) ? ))))))

(defun bs--show-header ()
  "Insert header for Buffer Selection Menu in current buffer."
  (mapcar '(lambda (string)
	     (insert string "\n"))
	  (bs--create-header)))

(defun bs--get-name-length ()
  "Return value of `bs--name-entry-length'."
  bs--name-entry-length)

(defun bs--create-header ()
  "Return all header lines used in Buffer Selection Menu as a list of strings."
  (list (mapconcat (lambda (column)
		     (bs--format-aux (bs--get-value (car column))
				     (nth 3 column) ; align
				     (bs--get-value (nth 1 column))))
		   bs-attributes-list
		   "")
	(mapconcat (lambda (column)
		     (let ((length (length (bs--get-value (car column)))))
		       (bs--format-aux (make-string length ?-)
				       (nth 3 column) ; align
				       (bs--get-value (nth 1 column)))))
		   bs-attributes-list
		   "")))

(defun bs--show-with-configuration (name &optional arg)
  "Display buffer list of configuration with name NAME.
Set configuration NAME and determine window for Buffer Selection Menu.
Unless current buffer is buffer *buffer-selection* we have to save
the buffer we started Buffer Selection Menu and the current window
configuration to restore buffer and window configuration after a
selection.  If there is already a window displaying *buffer-selection*
select this window for Buffer Selection Menu.  Otherwise open a new
window.
The optional argument ARG is the prefix argument when calling a function
for buffer selection."
  (bs-set-configuration name)
  (let ((bs--show-all (or bs--show-all arg)))
    (unless (string= "*buffer-selection*" (buffer-name))
      ;; Only when not in buffer *buffer-selection*
      ;; we have to set the buffer we started the command
      (progn
	(setq bs--buffer-coming-from (current-buffer))
	(setq bs--window-config-coming-from (current-window-configuration))))
    (let ((liste (bs-buffer-list))
	  (active-window (bs--window-for-buffer "*buffer-selection*")))
      (if active-window
	  (select-window active-window)
	(if (> (window-height (selected-window)) 7)
	    (progn
	      (split-window-vertically)
	      (other-window 1))))
      (bs-show-in-buffer liste)
      (bs-message-without-log "%s" (bs--current-config-message)))))

(defun bs--configuration-name-for-prefix-arg (prefix-arg)
  "Convert prefix argument PREFIX-ARG to a name of a buffer configuration.
If PREFIX-ARG is nil return `bs-default-configuration'.
If PREFIX-ARG is an integer return PREFIX-ARG element of `bs-configurations'.
Otherwise return `bs-alternative-configuration'."
  (cond ;; usually activation
   ((null prefix-arg)
    bs-default-configuration)
   ;; call with integer as prefix argument
   ((integerp prefix-arg)
    (if (and (< 0 prefix-arg) (<= prefix-arg (length bs-configurations)))
	(car (nth (1- prefix-arg) bs-configurations))
      bs-default-configuration))
   ;; call by prefix argument C-u
   (t bs-alternative-configuration)))

;; ----------------------------------------------------------------------
;; Main function bs-customize and bs-show
;; ----------------------------------------------------------------------

;;;###autoload
(defun bs-customize ()
  "Customization of group bs for Buffer Selection Menu."
  (interactive)
  (customize-group "bs"))

;;;###autoload
(defun bs-show (arg)
  "Make a menu of buffers so you can manipulate buffers or the buffer list.
\\<bs-mode-map>
There are many key commands similar to `Buffer-menu-mode' for
manipulating buffer list and buffers itself.
User can move with [up] or [down], select a buffer
by \\[bs-select] or [SPC]\n
Type \\[bs-kill] to leave Buffer Selection Menu without a selection.
Type \\[bs-help] after invocation to get help on commands available.
With prefix argument ARG show a different buffer list.  Function
`bs--configuration-name-for-prefix-arg' determine accordingly
name of buffer configuration."
  (interactive "P")
  (setq bs--marked-buffers nil)
  (bs--show-with-configuration (bs--configuration-name-for-prefix-arg arg)))

;;; Now provide feature bs
(provide 'bs)

;;; bs.el ends here
