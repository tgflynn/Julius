
(defparameter *CMDS* '(
                       ( "help" 0 "Displays help" nil )
                       ( "car" 1 "Returns head of list" cl::car )
                       ( "cdr" 2 "Returns rest of list" cl::cdr )
                       ( "nth" 3 "Returns nth element of list" cl::nth )
                       ( "load" 4 "Loads a Lisp source file" cl::load )
                       ( "getf" 5 "Accesses a place" cl::getf )
                       ( "setf" 6 "Sets a place to some value" cl::setf )
                       ( "match" 7 "Matches a string" nil )
                       ( "do" 8 "do loop" cl::do )
                       ( "die" 9 "Save image and exit" nil )
                       ))

(defun khelp ()
  (let* ((rec (nth 0 *CMDS*))
         (fun (lambda ()
                "This is the help.")))
    (setf (nth 3 rec) fun)
    (funcall fun)))
  
(defun kload (path)
  (declare (optimize
            (safety 0)
            (speed 0)
            (space 0)
            (debug 0)
            (compilation-speed 0)))

  ;(declaim ((sb-ext::muffle-conditions sb-ext::compiler-note)))
  (let* ((rec (nth 4 *CMDS*))
         (fun (nth 3 rec)))
    (funcall fun path)))

(defun ksleep (msec)
  ;; (declare (optimize
  ;;           (safety 0)
  ;;           (speed 0)
  ;;           (space 0)
  ;;           (debug 0)
  ;;           (compilation-speed 0)))
  (let* ((units-per-msec (/ internal-time-units-per-second 1000))
         (units-per-usec internal-time-units-per-second)
         (current (get-internal-real-time)))
    (do ((var 1 (1+ var)))
        ((>= (get-internal-real-time) (+ current (* msec units-per-msec)))
         (format t "var = ~a units-per-msec = ~a units-per-usec = ~a~%"
                 var units-per-msec units-per-usec)))
    ))

        ;; (var
        ;;       (if (>= (* usec (get-internal-real-time)) (* usec current))
        ;;           (break-from do nil))))))
         
    

(defun kdie ()
  (declare (optimize
            (safety 0)
            (speed 0)
            (space 0)
            (debug 0)
            (compilation-speed 0)))
  (let* ((rec (nth 9 *CMDS*))
         (fun (lambda ()
                (ksleep 10000)
                (let ((res (format nil "Dying...")))
                  (sb-ext:save-lisp-and-die "kore.dat")
                  res))))
    (setf (nth 3 rec) fun)
    (let ((res2 (funcall fun)))
      (ksleep 10)
      (format t "res2 = ~a~%" res2))))


;;; (setf (cdr (nth 0 *CMDS*)) '(0 "Displays help" nil))


;; (defun match-1 (x pattern &optional (index 0))
;;   (let ((plen (length pattern)))
    
;;     (cond
;;       ((or (>= index plen))
;;        nil)
;;       ((equal x (char pattern index))
;;        t)
;;       (t
;;        (match x pattern (+ index 1))))))

(defun match-2 (x pattern &optional (index 0))
  (format t "x = ~a pattern = ~a index = ~a~%" x pattern index)
  (let ((plen (length pattern)))
    (when (not (= plen (length x)))
      nil)

    (cond ((< index plen)
           (if (equal (char x index) (char pattern index))
               (match-2 x pattern (+ index 1))
               nil))
          (t (if (= index (- plen 1)) t 'nil))))
  t
  )

(defun match-3 (x pattern &optional (index 0))
  (format t "x = ~a pattern = ~a index = ~a~%" x pattern index)
  (let* ((xlen (length x))
         (plen (length pattern))
         (lenok (equal xlen plen))
         (res nil))
    (format t "xlen = ~a plen = ~a lenok = ~a index = ~a~%"
            xlen plen lenok index)
    (when (not lenok)
      (return-from match-3))
    (when (>= index plen)
      (return-from match-3))
    (format t "After index check cx = ~a cp = ~a ~%"
            (char x index)
            (char pattern index)
            )
    (if (equal (char x index) (char pattern index))
        (setf res t)
        (setf res nil))
    (format t "res = ~a~%" res)
    (when (and res (= (+ index 1) plen))
      (return-from match-3 t))
    
    (if res
        (match-3 x pattern (+ index 1))
        nil)))

    

(defun match-4 (x pattern &optional (index 0))
  (let* ((xlen (length x))
         (plen (length pattern))
         (lenok (equal xlen plen))
         (nexti (+ index 1)))
    (let ((res
           (cond ((not lenok) nil)
                 ((>= index plen) nil)
                 ((equal (char x index)
                         (char pattern index))
                  t)
                 (t nil))))
      (format t "index = ~a res = ~a nexti = ~a~%"
              index res nexti)
      (match-4 x pattern nexti)
      )
    nil
    ))

(defun kmatch (x pattern)
  (let* ((rec (nth 7 *CMDS*))
         (fun (lambda (x pattern)
                (match-3 x pattern))))
    (setf (nth 3 rec) fun)
    (funcall fun x pattern)))

(defmacro klambda (&whole form &rest bvl-decls-and-body)
  (declare (ignore bvl-decls-and-body))
  `#',form)

;; (defun kloop (var begin end cnt sexpr)
;;   (format t "var = ~a begin = ~a end = ~a cnt = ~a sexpr = ~s~%"
;;           var begin end cnt sexpr)
;;   (let* ((vsym (quote var))
;;          (fun (lambda (vsym)
;;                sexpr))
;;          (res (funcall fun cnt)))
;;     (if (= cnt end)
;;         (let ((gsym ((gensym))))
;;           ((lambda (gsym) res) gsym))
;;       (kloop var begin end (1+ cnt) sexpr))))

;; (kloop 'i 0 5 0 '(let ((j 0))
;;                   (setf j (+ i 1))
;;                   j))

;; (defun kdo (var begin end sexpr)
;;   (let* ((rec (nth 8 *CMDS*))
;;          (fun (lambda (var begin end sexpr)
;;                 (do ((var begin (1+ var)))
;;                     ((= var end))
;;                   (progn
;;                     sexpr)))))       
;;     (setf (nth 3 rec) fun)
;;     (funcall fun var begin end sexpr)))


(defun do-repl (input-stream)
  (read-char input-stream)
  )

(defun repl (x &optional input-stream)
  (if x
      nil
      (do-repl input-stream)
      )
  )
