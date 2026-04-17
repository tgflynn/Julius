
;; (defun match-1 (x pattern &optional (index 0))
;;   (let ((plen (length pattern)))
    
;;     (cond
;;       ((or (>= index plen))
;;        nil)
;;       ((equal x (char pattern index))
;;        t)
;;       (t
;;        (match x pattern (+ index 1))))))

(defun match (x pattern &optional (index 0))
  (format t "x = ~a pattern = ~a index = ~a~%" x pattern index)
  (let ((plen (length pattern)))
    (when (not (= plen (length x)))
      nil)

    (cond ((< index plen)
           (if (equal (char x index) (char pattern index))
               (match x pattern (+ index 1))
               nil))
          (t (if (= index (- plen 1)) t 'nil))))
  t
  )
    

    
    ;; (cond ((and (equal xc pc) (< index plen))
    ;;        (match x pattern (+ index 1)))
    ;;       (t
    ;;        nil))
    ;; t))

                   
(defun do-repl (input-stream)
  (read-char input-stream)
  )

(defun repl (x &optional input-stream)
  (if x
      nil
      (do-repl input-stream)
      )
  )
