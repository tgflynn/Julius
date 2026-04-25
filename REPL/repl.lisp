
(defmacro keffacez (&optional (pas nil) &rest body)
  (declare (optimize
            (safety 0)
            (speed 0)
            (space 0)
            (debug 0)
            (compilation-speed 0)))
  (declare (muffle-conditions style-warning))
  (if (equal (eval pas) t)
      `(progn ,@body)
      `(progn )))

(keffacez nil
(defparameter *CMDS* '(
                       ( "khelp" 0 "Displays help" nil )
                       ( "car" 1 "Returns head of list" cl::car )
                       ( "cdr" 2 "Returns rest of list" cl::cdr )
                       ( "nth" 3 "Returns nth element of list" cl::nth )
                       ( "load" 4 "Loads a Lisp source file" cl::load )
                       ( "getf" 5 "Accesses a place" cl::getf )
                       ( "setf" 6 "Sets a place to some value" cl::setf )
                       ( "match" 7 "Matches a string" nil )
                       ( "do" 8 "do loop" cl::do )
                       ( "die" 9 "Save image and exit" nil )
                       ( "kcore" 10 "Save image" nil )
                       ( "krand" 11 "Returns a random float" nil )
                       ( "kgen" 12 "Generates a single random float" nil )
                       ( "kdivides" 13 "Checks if the 1st argument is divisible by the 2nd" nil )
                       ))
)

(defparameter *CMDS* '(
                       ( "khelp" 0 "Displays help" nil )
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


(defun kerror (x)
  (format t "Error: ~s~%" x))

(defun kidentity (x)
  x)

(defun katomp (x)
  (not (consp x)))

(defun knilp (x)
  (cond ((equal x nil) 't)
        (t nil)))

(defun khead (n lst)
  (cond ((or (= n 0) (knilp lst)) nil)
        (t (cons (car lst) (khead (- n 1) (cdr lst))))))

(defun kfilter (pred lst)
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

(keffacez t
(defun kcomlist ()
  (let ((lst (kfilter #'(lambda (x)
                          (not (knilp (car x))))
                      *CMDS*)))
    lst)
  )
)

(defun khelp ()
  (let* ((rec (nth 0 *CMDS*))
         (fun (lambda ()
                (let ((lst (mapcar #'(lambda (x)
                                       (format nil
                                               "~{~5,10T~a~}~%"
                                               (list (nth 0 x) (nth 1 x) (nth 2 x))
                                               ))
                                   (kcomlist))))
                  (format t "This is the help.~%")
                  (format t "Commands :~%~{~a~}~%" lst)
                ))))
    (setf (nth 3 rec) fun)
    (funcall fun)))


(defun khelp-2 ()
  (let* ((rec (nth 0 *CMDS*))
         (fun (lambda ()
                (let ((lst (mapcar #'(lambda (x)
                                       (format nil
                                        "~10,1,20,'*<~a~> ~10,1,20,'*<~a~> ~80,0T~0,1,50,'*<~a~> ~%"
                                               (nth 0 x) (nth 1 x) (nth 2 x)
                                               ))
                                   (khead 3 *CMDS*))))
                  (format t "This is the help.~%")
                  (format t "Commands :~%~{~a~%~}~%" lst)
                ))))
    (setf (nth 3 rec) fun)
    (funcall fun)))

; "~0,1,20,'*<~a ~; (~a) ~; ~a~> ~%"
;"QQ" "Q" "Q"


;~10<foo~;bar~>

(defun kpwd ()
  (truename "."))

(defun khex (arg)
  (let* ((rec (nth 19 *CMDS*))
         (fun #'(lambda (x)
                  (format nil "~X" x))))
    (setf (nth 3 rec) fun)
    (funcall fun arg)))

(defun kdivides (a b)
  (let ((c (if (= b 0) 0
               (mod a b))))
    (when (= c 0)
      't)))

(defun kgen (n &optional (max 1))
  (let* (;(rec (nth 12 *CMDS*))
         (lst '())
         (fun (lambda (max)
                (setf lst (append lst (list (random (expt 2 max)))))))           
         ;(tres (funcall fun max))
         )
      
    (dotimes (ind n lst) (funcall fun max))

    (let ((carry 0)
          (idx 0)
          (s 0))

      ;(format t "lst = ~a~%" lst)
      (mapcar #'(lambda (x) 
                  (setf carry (mod x 2))
                  (let ((nextd 0))
                    (if (< idx n)
                        (setf nextd (* carry (expt 2 (- (- n idx) 1))))
                        (setf nextd 0))
                    (setf s (+ s (- x carry) nextd))
                    (incf idx)
                    ;; (format t "idx = ~a pidx = ~a x = ~a carry = ~a nextd = ~a s = ~a~%"
                    ;;         idx (- idx 1) x carry nextd s)
                    ))
              lst)
      ;(format t "lst = ~a~%" lst)
      
      s
      )
    ))
  


(defun krand (nbits)
  (let* ((rec (nth 11 *CMDS*))
         (fun (lambda (nbits)
                (float nbits))))
    (setf (nth 3 rec) fun)
    (funcall fun nbits)))

(defun kseq (n)
  (let (
        (lst '())
        )
    (dotimes (ind n lst)
      (setf lst (append (list (kgen 8)) lst)))
      
    lst
    ))

(defun ksleep (msec)
  ;; (declare (optimize
  ;;           (safety 0)
  ;;           (speed 0)
  ;;           (space 0)
  ;;           (debug 0)
  ;;           (compilation-speed 0)))
  (let* ((units-per-msec (/ internal-time-units-per-second 1000))
         ;(units-per-usec internal-time-units-per-second)
         (current (get-internal-real-time)))
    (do ((var 1 (1+ var)))
        ((>= (get-internal-real-time) (+ current (* msec units-per-msec)))
         ;; (format t "var = ~a units-per-msec = ~a units-per-usec = ~a~%"
         ;;         var units-per-msec units-per-usec)
         ))
    ))

(defun ktime (fun)
  (let* ((t1 (get-internal-real-time)))
    (let ((res (funcall fun)))
      ;(format t "res = ~a~%" res)
      (let* ((t2 (get-internal-real-time))
             (dt (float (/ (- t2 t1) internal-time-units-per-second))))
        (format t "dt = ~a [s]~%" dt)
        (values dt res)))
    ))
;;; Example: (ktime #'(lambda () (kgamma2 100000)))

(defun ksum (lst)
  (let ((s 0))
    ;(format t "lst = ~a~%" lst)
    (mapcar #'(lambda (x)
                (let ((nx (if (equal x t) 1 x)))
                  (cond ((numberp nx)
                         (setf s (+ s nx)))
                        (t 'nil)))) lst)
    s))

(defun kgenseq (len &optional (lst '()))
  (let ((start 0))
    ;;(format t "len=~a start=~a lst=~a~%" len start lst)
    (cond
      ((and (listp lst) (>= len 1))
       (kgenseq (- len 1) (cons nil lst)))
      (t
       (reverse lst)))))


(defun kgseq (len start &optional (lst '()))
  ;;(format t "len=~a start=~a lst=~a~%" len start lst)
  (cond
    ((and (listp lst) (>= len 1))
     (kgseq (- len 1) (+ start 1) (cons start lst)))
    (t
     (reverse lst))))


(defun kcore ()
  (declare (optimize
            (safety 0)
            (speed 0)
            (space 0)
            (debug 0)
            (compilation-speed 0)))
  (let* ((rec (nth 10 *CMDS*))
         (fun (lambda ()
                (ksleep 10000)
                (let ((res (format nil "Dying...")))
                  ;(sb-ext:save-lisp-and-die "kore.dat" :executable t :toplevel (function khelp))
                  (sb-ext:save-lisp-and-die "kore.dat" :executable t :toplevel (function khelp))
                  res))))
    (setf (nth 3 rec) fun)
    (let ((res2 (funcall fun)))
      (ksleep 10)
      (format t "res2 = ~a~%" res2))))


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


;; (defun do-repl (input-stream)
;;   (dotimes (i 1 (incf i))
;;     ;(ksleep 5000)
;;     (let ((ic
;;            (read-char input-stream)
;;            ;(read-char-no-hang input-stream 't :EOF 't)
;;             ))
;;       ;(ksleep 5000)
;;       (format t "i = ~a ic = ~s~%" i ic))
;;     )
;;   )

(defparameter *my-stream* (make-synonym-stream '*terminal-io*))

(defun do-repl-2 (input-stream)
  (let* ((is (make-synonym-stream input-stream))
        ;(bfun (slot-value is 'sb-impl::bin))
         (bfun (slot-value sb-sys::*tty* 'sb-impl::bin))
         ;(bis (funcall bfun is))
         )
    (format t "bfun = ~s~%" bfun)
    (let* ((pc (peek-char t is nil))
           ;(ic (read-char is t 'the-end))
           (cc (char-code pc)))
      (unread-char pc is)
      (format t "pc = ~s cc = ~s~%" pc cc))))

(defun do-repl (input-stream)
  (do ((c (read-char input-stream)
          (read-char input-stream nil 'the-end)))
      ((not (characterp c)))
    (format t "~s " c)))

(defun repl (x &optional input-stream)
  (if x
      nil
      (do-repl input-stream)
      )
  )

(defun kmonte (n)
  (/ (float (ksum (kseq n))) (float (expt 2 8))))
  
  ;; (/ (float (ksum (mapcar #'(lambda (x y)
  ;;                             (+ (expt x 2) (expt y 2)))
  ;;                         (kseq n) (kseq n))))
  ;;    (float (expt 2 8))))

;; (defun kmonte (n)
;;   (/ (float (ksum (mapcar #'(lambda (x y)
;;                               (+ (expt x 2) (expt y 2)))
;;                           (kseq n) (kseq n))))
;;      (float (expt 2 8))))

(defun kfact (n)
  (cond ((<= n 1) 1)
        (t (* n (kfact (- n 1))))))

;;; (float (ksum (mapcar #'(lambda (x) (/ 1 (kfact x))) (kgseq 15 0))))
;;; approximately equals:
;;; (exp 1.0)

(defun kgamma (M)
  (let* ((fun #'(lambda (n)
                  (- (ksum (mapcar
                            #'(lambda (k)
                                (/ 1 k))
                            (kgseq M 1)))
                     (log n)))))
    (funcall fun M)))

(defun kgamma2 (M)
  (let ((s 0))
    (dotimes (k M (incf k))
      (setf s (+ s (/ 1 (+ k 1)))))
    (let ((res (- s (log M))))
      (format t "~%~,20f~%" res)
      res)
    ))
              

;; (defun set-prompt ()
;;   ;(declare (sb-ext:disable-package-locks sb-impl::*repl-prompt-fn*))
;;   (declare (sb-ext:disable-package-locks sb-impl))
;;   (setf sb-impl::*repl-prompt-fn*
;;         (lambda ()
;;          ;(format nil "~A> " (package-name *package*)))))
;;           (format nil "~A> " #\K))))
;;   )

(defun kprint (object &optional (output-stream *standard-output*))
  ;;   ;(declare (sb-ext:disable-package-locks :print))
  (cl::print object output-stream)
  (terpri output-stream)
  (format output-stream "K> ")
  ;(write #\K :stream output-stream)
  ;(cl:print #\> output-stream)
  ;(cl:print #\space output-stream)
;;   ;(write-string (format nil "~a" object) output-stream)
;;   ;object
  )

(defun ktrue ()
  't)


(defun k-inbounds-p (x xmin xmax)
  (and (>= x xmin) (<= x xmax)))
 
(defmacro expand-1 (form &environment env)
  (multiple-value-bind (expansion expanded-p)
      (macroexpand-1 form env)
    `(values ',expansion ',expanded-p)))

(defmacro expand (form &environment env)
  (multiple-value-bind (expansion expanded-p)
      (macroexpand form env)
    `(values ',expansion ',expanded-p)))

(defmacro kexpand-1 (form &environment env)
  (multiple-value-bind (expansion expanded-p)
      (macroexpand form env)
    (format t "expansion:~%~S~%" expansion)
    `(values ',expansion ',expanded-p)
    ))

;; (defmacro kexpand (form &environment env)
;;   (kexpand-1 form env))

(defun kwalk-1 (sexpr fun)
  (cond
    ((consp sexpr) (let* ((hd (car sexpr))
                         (tl (cdr sexpr))
                          (nh (funcall fun hd)))
                     (cond
                       ((listp tl) (cons nh (kwalk-1 tl fun)))
                       ((katomp nh) (cons nh (list nh)))
                       (t (kerror "Unknown error"))))
     )
    (t (funcall fun sexpr))
    )
  )

(keffacez nil
(defmacro kexpand (&whole wform &rest args)
  (declare (muffle-conditions style-warning))
  (format t "wform = ~s~%" wform)
  (let ((hd (car wform))
        (tl (cdr wform)))
    (format t "hd = ~s tl = ~s~%" hd tl)
    (if (equal hd 'kexpand)
        (kexpand-1 (cdr wform))
        (cdr wform))))
)

(defmacro kexpand (&whole wform &rest args)
  (declare (muffle-conditions style-warning))
  (let ((fun (lambda (x)
               (if (equal x 'kexpand)
                   'kexpand-1
                   ;(quote 'kexpand)
                   x))))
    (format t "wform = ~s~%" wform)
    (let ((rexpr (kwalk-1 wform fun)))
      (format t "rexpr = ~s~%" rexpr)
      rexpr
      )
    )
  )

(defun addfun ()
  (let ((lst (kgenseq 4)))
  (setf *CMDS* (append *CMDS* (list lst)))))

(keffacez
(defmacro kwhile (condition &rest body)
  `(tagbody
    start (if (,@condition) ,@body (go end))
    end
      (progn
        (if (not (,@condition))
            (progn
              (format t "kwhile: before go start: condition = ~s~%" (quote ,condition))
              (go start)
              )
            nil)
        )
      )
  )
)

(defmacro kwhile (condition &rest body)
  `(tagbody
    start (if (,@condition) ,@body (go end))

    end
      (if (,@condition)
          (go start)
          nil)
      )
  )
      


(defun setfun (fname num description lfun)
  (let ((tlimit nil)
        (tnum 0)
        (done nil))
    (kwhile (progn
              (format t "done = ~a~%" done)
              (and (k-inbounds-p (length *CMDS*) num (+ num 10))) (not done))
            (progn
              (format t "length = ~a num = ~a tnum = ~a done = ~a~%"
                      (length *CMDS*) num tnum done)
              (addfun)
              (incf tnum)
              
              (when (or (>= (length *CMDS*) (+ num 1))
                        (and tlimit (> tnum 10)))
                (setf done 't))

              (format t "after when: length = ~a num = ~a tnum = ~a done = ~a~%"
                      (length *CMDS*) num tnum done)
              
              
              )))
  (format t "after kwhile~%")
  (let* ((rec (nth num *CMDS*)))
    (setf (nth 0 rec) fname)
    (setf (nth 1 rec) num)
    (setf (nth 2 rec) description)
    (setf (nth 3 rec) lfun)))

(keffacez nil
(defun setfun (fname num lfun)
  (let ((tnum 0)
        (done nil))
    (kwhile (and (k-inbounds-p (length *CMDS*) num (+ num 10)) done)
            (progn
              (addfun)
              (incf tnum)
              (when (> tnum 10) (setf done 't))
              )))
  (let* ((rec (nth num *CMDS*)))
    (setf (nth 0 rec) fname)
    (setf (nth 3 rec) lfun)))
)

(defun kread (&optional input-stream eof-error-p eof-value recursive-p)
  (read input-stream eof-error-p eof-value recursive-p))

(defun keval (form)
  (eval form))

(progn
  (setfun "kcore" 10 "Save image" nil )
  (setfun "krand" 11 "Returns a random float" nil )
  (setfun "kgen" 12 "Generates a single random float" nil )
  (setfun "kdivides" 13 "Checks if the 1st argument is divisible by the 2nd" nil )
  (setfun "kseq" 14 "Generates n random floats" nil )
  (setfun "ksum" 15 "Sums a list" nil )
  (setfun "kgseq" 16 "Generates a list of integers" nil )
  (setfun "kmonte" 17 "Approximates pi" nil )
  (setfun "kfact" 18 "Computes n!" nil )
  (setfun "khex" 19 "Formats numbers as hex strings" nil )
  
  (setfun "ktime" 20 "Measure execution time" #'ktime)
  (setfun "kprint" 21 "Calls print" #'kprint)
  (setfun "kpwd" 22 "Returns current directory path" #'kpwd)
  (setfun "keval" 23 "Evaluates form" #'keval)
  (setfun "kread" 24 "Reads and parses objects from input stream" #'kread)
  
  (khelp)
  )


