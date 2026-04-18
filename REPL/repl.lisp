
(defparameter *CMDS* '(
                       ( "help" 0 "Displays help" nil )
                       ( "car" 1 "Returns head of list" cl::car )
                       ( "cdr" 2 "Returns rest of list" cl::cdr )
                       ( "nth" 3 "Returns nth element of list" cl:nth )
                       ( "load" 4 "Loads a Lisp source file" cl:load )
                       ( "match" . nil )
                       ( "do" . nil )
                       ( "getf" . nil )
                       ( "setf" . nil )
                       ))

(defun khelp ()
  (let* ((rec (nth 0 *CMDS*))
         (fun (lambda ()
                "This is the help.")))
    (setf (nth 3 rec) fun)
    (funcall fun)))
  

(defun kload (path)
  (let* ((rec (nth 4 *CMDS*))
         (fun (nth 3 rec)))
    (funcall fun path)))

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
      
    
      
    
    

    

                   
(defun do-repl (input-stream)
  (read-char input-stream)
  )

(defun repl (x &optional input-stream)
  (if x
      nil
      (do-repl input-stream)
      )
  )
