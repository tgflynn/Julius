(defpackage julius
  (:nicknames iulius :IC)
  (:use common-lisp)
  (:export "KEFFACEZ" "KRUN" "KSYM-LIST" "KSYM-FIND" "KSYM-DESC" "KAPROPOS")
  )

;; (uiop:define-package julius)
;; (in-package #:julius)

;;(locally
    ;(declare (sb-ext:disable-package-locks julius:print))

;;(defvar *print* #'cl::print)

;; (setf *print* (lambda (object &optional output-stream)
;;                 (cl::print object output-stream)))

;;(defmacro julius::print  (object &optional output-stream)
;;  `(cl::print ,object ,output-stream))

(defmacro mactest-1 (x)
  `(car ,x))

;; (defmacro mactest-2 (x &optional y)
;;   `(if ((not (nullp y)) y (car ,x))))

(defun funtest-2 (x &optional y)
  (IF
   (NOT Y)
   Y
   (CAR X)))

;; (defun julius::print (object &optional output-stream)
;;   ;(declare (sb-ext:disable-package-locks :print))
;;   (terpri output-stream)
;;   (write-char #\K output-stream)
;;   (write-char #\> output-stream)
;;   (write-char #\space output-stream)
;;   ;(write-string (format nil "~a" object) output-stream)
;;   ;object
;;   (cl::print object output-stream)
;;   )

(defun map-count (lst)
  (mapcar #'(lambda (x) (if (equal x 't) 1 0)) lst))

(defun sum-list (lst)
  (cond
    ((and (listp lst) (> (length lst) 0))
     (+ (car lst)
        (sum-list (cdr lst))))
    (t
     0)
    )
  )

(defun compute-list-sum (lst)
  (mapcar #'(lambda (x) (map-count x)) lst))

(defun gen-list (len start &optional (lst '()))
  ;;(format t "len=~a start=~a lst=~a~%" len start lst)
  (cond
    ((and (listp lst) (>= len 1))
     (gen-list (- len 1) (+ start 1) (cons start lst)))
    (t
     (reverse lst))))

(defun divides (a b)
  ;;(format 't "a = ~a b = ~a~%" a b)
  (let ((c (if (= b 0) 0
               (mod a b))))
    ;;(format 't "a = ~a b = ~a c = ~a~%" a b c)
    (when (= c 0)
      't)))

(defun divides-list (a l)
  (mapcar #'(lambda (x) (divides a x)) l))

;(print 0.0)

;)
;; blah blah blah.
