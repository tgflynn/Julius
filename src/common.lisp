
(defpackage julius
  (:nicknames iulius :IC)
  (:use common-lisp)
  (:export "krun" "ksym-list" "ksym-find" "ksym-desc" "kapropos")
  )

(in-package :IC)

(defun kpackage ()
  *package*)

(defun kpack-list-sym-ext (package)
  (let ((sym-list '()))
    (do-external-symbols (symb package)
      (format t "symb = ~s~%" symb)
      (setf sym-list (cons (symbol-name symb) sym-list)))
    (format t "kpack-list-sym-ext sym-list = ~s~%" sym-list)
    sym-list
    )
  )

(defun kexport ()
  (let* ((pkg (kpackage))
         (exp-list (kpack-list-sym-ext pkg)))
    (format t "kexport exp-list = ~s~%~a~%" exp-list exp-list)
    (dolist (symb exp-list)
      (format t "symb = ~a pkg = ~a~%" symb pkg)
      (let ((int-symb (intern symb pkg)))
        ;(find-symbol (symbol-name symb) :ic)
        (export int-symb pkg))
      )
    )
  )
(kexport)    

(defmacro klambda-list-test (&whole whole-list &rest args)
  (format t "klambda-list-test: whole = ~s~%" (list whole-list))
  (format t "klambda-list-test: args = ~s~%" args)
  `(uiop:run-program ,@args)
  )


(defun krun (&rest args)
  (uiop:run-program args))

(defun ksym-list (args)
  args
  )

(defun ksym-find (symb)
  symb
  )

(defun ksym-desc (symb)
  `((
     :symbol (string ,symb)
     :package (string ,(symbol-package symb))
     ))
  )

(defun kapropos (string-designator &optional package external-only)
  (let ((results '()))
    (dolist (symbol (apropos-list string-designator package external-only))
      (let ((sdesc (ksym-desc symbol)))
        (format t "sdesc = ~s~%" sdesc)
        ;; (setf results (cons
        ;;                (ksym-desc symbol)
        ;;                results
        ;;                ))
        )
      )
    results
    (format t "results = ~s~%" results)
    )
  ;(values) ; note: this returns nothing.
  )


