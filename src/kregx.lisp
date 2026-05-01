
(in-package :IC)

;; (defmacro kmunhexify (x)
;;   `|,x|)

(defparameter *JULIUS-REGX-TEST-TARGET-1* "test")
(defparameter *JULIUS-REGX-TEST-LIST-1* '( "test" ))
(defparameter *JULIUS-REGX-TEST-LIST-2* (list #\t #\* #\. ) )
;(defparameter *JULIUS-REGX-TEST-LIST-2A* (list |.| ) )
;(defparameter *JULIUS-REGX-TEST-LIST-2B* (list |*| ) ) ; read as (nil)
;(defparameter *JULIUS-REGX-TEST-LIST-2C* (list |alkh| ) ) ; variable alkh is unbound
;(defparameter *JULIUS-REGX-TEST-LIST-3* (list #\t #\* #\. |*| |.| ) )
;(defparameter *JULIUS-REGX-TEST-LIST-4* (list #\t #\* #\. |.| ) )
(defparameter *JULIUS-REGX-TEST-CHAR-1* #\A)


(defparameter *JULIUS-REGX-CHARS* '(
                                    ( #\. :JULIUS-REGX-WILD-SINGLE )
                                    ( #\* :JULIUS-REGX-WILD-MULT )
                                    ( #\( :JULIUS-REGX-PAREN-OPEN )
                                    ( #\) :JULIUS-REGX-PAREN-CLOSE )
                                    ( #\[ :JULIUS-REGX-BRACKET-OPEN )
                                    ( #\] :JULIUS-REGX-BRACKET-CLOSE )
                                    ( #\{ :JULIUS-REGX-BRACE-OPEN )
                                    ( #\} :JULIUS-REGX-BRACE-CLOSE )
                                    ( #\\ :JULIUS-REGX-SLASH-BACK )
                                    ( #\/ :JULIUS-REGX-SLASH-FORWARD )
                                    ( #\: :JULIUS-REGX-COLON )
                                    ( #\; :JULIUS-REGX-COLON-SEMI )
                                    ( #\, :JULIUS-REGX-COMMA )
                                    ( #\^ :JULIUS-REGX-HAT )
                                    ( #\$ :JULIUS-REGX-DOLLAR )
                                    ( #\? :JULIUS-REGX-QUESTION )
                                    ( #\+ :JULIUS-REGX-PLUS )
                                    ( #\| :JULIUS-REGX-BAR-VERT )
                                    ( #\- :JULIUS-REGX-MINUS )
                                    ))

(defparameter *JULIUS-REGX-CHAR-CLASSES* '(
                                           "[:alnum:]"
                                           "[:alpha:]"
                                           "[:blank:]"
                                           "[:cntrl:]"
                                           "[:digit:]"
                                           "[:graph:]"
                                           "[:lower:]"
                                           "[:print:]"
                                           "[:punct:]"
                                           "[:space:]"
                                           "[:non-space:]"
                                           "[:upper:]"
                                           "[:xdigit:]"
                                           ))

(defparameter *JULIUS-REGX-CHAR-DEFINITIONS* (list
                                              `( "[:alnum:]" (("#41" . "#5A") ("#61" . "#7A") ("#30" . "#39") ))
                                              `( "[:alnum-and-underscore:]"
                                                (("#41" . "#5A") ("#61" . "#7A") ("#30" . "#39") "#5F" ))
                                              `( "[:non-word:]"
                                                (("#41" . "#5A") ("#61" . "#7A") ("#30" . "#39") "#5E" "#5F" ))
                                              `( "[:alpha:]" ("#00" . "#FF") )
                                              `( "[:blank:]" ("#20" "#09") )
                                              `( "[:word-boundaries:]" nil )
                                              `( "[:non-word-boundaries:]" nil )
                                              `( "[:cntrl:]" (("#00" . "#1F") "#7F")) ;;; #7F = #O177
                                              `( "[:digit:]" ("#30" . "#39") )
                                              `( "[:non-digit:]" nil ) ;;; [^0-9]
                                              `( "[:graph:]" ("#21" . "#7E") ) ;;; union of [:alnum:] and [:punct:]
                                              `( "[:lower:]" ("#61" . "#7A") )
                                              `( "[:print:]" ("#20" . "#7E") ) ;;; union of [:alnum:], [:punct:] and space
                                              `( "[:punct:]" (
                                                              "#21"  ; !
                                                              "#22"  ; #\"
                                                              "#23"  ; #
                                                              "#24"  ; $
                                                              "#25"  ; %
                                                              "#26"  ; &
                                                              "#27"  ; '
                                                              "#28"  ; "("
                                                              "#29"  ; ")"
                                                              "#2A"  ; "*"
                                                              "#2B"  ; "+"
                                                              "#2C"  ; ","
                                                              "#2D"  ; "-"
                                                              "#2E"  ; "."
                                                              "#2F"  ; "/"
                                                              "#3A"  ; ":"
                                                              "#3B"  ; ";"
                                                              "#3C"  ; "<"
                                                              "#3D"  ; "="
                                                              "#3E"  ; ">"
                                                              "#3F"  ; "?"
                                                              "#40"  ; "@"
                                                              "#5B"  ; "["
                                                              "#5D"  ; "]"
                                                              "#5E"  ; "^"
                                                              "#5F"  ; "_"
                                                              "#60"  ; "`"
                                                              "#7B"  ; "{"
                                                              "#7C"  ; "|"
                                                              "#7D"  ; "}"
                                                              "#7E"  ; "~"
                                                              ) )
                                              ))

(defparameter *JULIUS-REGX-TEST-STRING-1* "! #\" # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~")
                                        ; (map 'list #'char-code IC::*JULIUS-REGX-TEST-STRING-1*)

(defun char-test (x) (format t "x = ~A (~X) (~D)~%" (code-char x) x x))

(defun kcheck-character-class (c cclass)
  (let ((ccode (char-code c)))
    (cond
      ((and (>= ccode 0) (<= ccode #X7F) (equal cclass (nth 0 *JULIUS-REGX-CHAR-CLASSES*))) t)
      (t nil)))
  )
