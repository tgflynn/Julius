
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
                                              `( "[:alpha:]" ("\#00" . "\#FF") )  
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


(defun kcheck-character-class (c cclass)
  (let ((ccode (char-code c)))
    (cond
      ((and (>= ccode 0) (<= ccode #X7F) (equal cclass (nth 0 *JULIUS-REGX-CHAR-CLASSES*))) t)
      (t nil)))
  )
