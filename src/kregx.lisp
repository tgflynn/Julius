
(in-package :IC)

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
                                    ))
