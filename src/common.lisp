
(in-package :IC)

(defun kpackage ()
  "Return the current package."
  *package*)

(defun kidentity (x)
  "Return x. "
  x)

(defun kunhex (x)
  (let ((pfun (lambda (x)
                (cond
                  ((equal (elt x 0) #\#) (subseq x 2))
                  (t x)
                  ))))
    (cond
      ((numberp x) x)
      ((stringp x) (parse-integer (funcall pfun x) :radix 16))
      ((symbolp x) (kunhex (symbol-name x)))
      (t x)
      )
    )
  )

(defun kcond-handler-bind (condition handler)
  "Binds function: handler to condition."
  (let*  ((conditions (list condition))
          (hfun (lambda (x)
                  (funcall handler x))))
    (kunused conditions)
    (kunused hfun)
    ;(format t "conditions = ~a type-of conditions = ~a~%" conditions conditions)
    ;(handler-bind conditions hfun)
    )
  )

(defun kcond-handler-bind-test-1 ()
  ;; (macrolet ((count-down (x) `(do ((counter ,x (1- counter)))
  ;;                                 ((= counter 0) 'done)
  ;;                               (when (= counter 1)
  ;;                                 ;(warn "Almost done")
  ;;                                 )
  ;;                               (format t "~&~D~%" counter))))
    ;(count-down 5)
    )
  ;)

;;  (defun ignore-warnings-while-counting (x)
;;    (handler-bind ((warning #'ignore-warning))
;;      (count-down x)))
;; =>  IGNORE-WARNINGS-WHILE-COUNTING
;;  (defun ignore-warning (condition)
;;    (declare (ignore condition))
;;    (muffle-warning))
;; =>  IGNORE-WARNING
;;  (ignore-warnings-while-counting 3)
;; >>  3
;; >>  2
;; >>  1
;; =>  DONE

;; (defun kerror (x &optional (throw nil))
;;   "Signals condition x unless throw is nil."
;;   ;(cl::muffle-warnings)
;;   ;(when throw (signal x))
  
;;   (let ((err-msg (format nil "kerror: ~s" x)))
;;     (if throw
;;         ;(error err-msg)
;;         err-msg
;;         )
;;     )
;;   )

(defun kerror (x &optional (throw nil))
  "Signals condition x unless throw is nil."
  (kunused throw)
  ;(cl::muffle-warnings)
  ;(when throw (signal x))
  
  (let ((err-msg (format nil "kerror: ~s" x)))
    (if throw
        ;(error err-msg)
        err-msg
        )
    )
  )


(defun katomp (x)
  "Return t if x is an atom (ie. not a cons)."
  (not (consp x)))

(defun knilp (x)
  "Return t if x is nil."
  (cond ((equal x nil) 't)
        (t nil)))

(defun kunused (sym)
  "Ignore variable: sym."
  (declare (ignore sym))
  )

(defun khead (n lst)
  "Return a list of the first n elements of lst."
  (cond ((or (= n 0) (knilp lst)) nil)
        (t (cons (car lst) (khead (- n 1) (cdr lst))))))

(defun kfilter (pred lst)
  "Return all elements in list lst for which pred returns t."
  (let* ((fun (lambda (x)
                (if (funcall pred x) x nil)))
         (tlst (mapcar fun lst)))
    tlst

    (let ((hd (car tlst))
          (tl (cdr tlst)))
      (cond ((not (knilp hd)) (cons hd (kfilter pred tl)))
            (t tl)))
    )
  )

(defun kpack-list-sym-ext (package)
  "Return list of all external symbols in package."
  (let ((sym-list '()))
    (do-external-symbols (symb package)
      (format t "princ: ~%")
      (princ symb)
      (terpri)
      (format t "prin1: ~%")
      (prin1 symb)
      (terpri)
      (format t "symb (A) = ~a~%" symb)
      (format t "symb (S) = ~s~%" symb)
      (setf sym-list (cons (symbol-name symb) sym-list)))
    (format t "kpack-list-sym-ext sym-list = ~s~%" sym-list)
    sym-list
    )
  )

(defun kexport ()
  "Export all external symbols in current package."
  (let* ((pkg (kpackage))
         (exp-list (kpack-list-sym-ext pkg)))
    (format t "kexport exp-list = ~s~%~a~%" exp-list exp-list)
    (dolist (symb exp-list)
      (format t "symb = ~a pkg = ~a~%" symb pkg)
      (let ((int-symb (intern symb pkg)))
        ;(find-symbol (symbol-name symb) :ic)
        (export int-symb pkg)
        )
      )
    )
  )
;(kexport) 

(defmacro klambda-list-test (&whole whole-list &rest args)
  "A macro for testing lambda lists."
  (format t "klambda-list-test: whole = ~s~%" (list whole-list))
  (format t "klambda-list-test: args = ~s~%" args)
  `(uiop:run-program ,@args)
  )


(defun krun (&rest args)
  "Run an external program."
  (uiop:run-program args))

(defun ksym-list (args)
  "List symbols contained in packages defined by args."
  args
  )

(defun ksym-find (symb)
  "Attempt to find the symbol symb."
  symb
  )

(defun ksym-desc (symb)
  "Describe the symbol symb."
  `((
     :symbol (string ,symb)
     :package (string ,(symbol-package symb))
     ))
  )

(defun kapropos (string-designator &optional package external-only)
  "Search documentation."
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


