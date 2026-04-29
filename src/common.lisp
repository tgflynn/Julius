
(in-package :IC)

(defun kpackage ()
  "Return the current package."
  *package*)

(defun kidentity (x)
  "Return x."
  x)

(defun kerror (x &optional (throw nil))
  "Signals condition x unless throw is nil."

  (let ((res
          (if throw
              (signal x)
              (format nil "kerror: ~s" x)  
              )))
    (format t "res = ~s~%" res)
    res
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


