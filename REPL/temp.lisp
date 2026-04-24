;; (let ((res
;;        (macroexpand-1 '(kwhile (k-inbounds-p (length *CMDS*) num (+ num 1))
;;                         (addfun)))))
;;   (format t "~a~%" res))

;(KWHILE (K-INBOUNDS-P (LENGTH *CMDS*) NUM (+ NUM 1)) (ADDFUN))



;; (LET ((NUM 5))
;;   (TAGBODY
;;    START
;;      (FORMAT T "NUM = ~A~%" NUM)
;;      (IF (K-INBOUNDS-P (LENGTH *CMDS*) NUM (+ NUM 1))
;;          (ADDFUN)
;;          (GO END))
;;    END
;;      (FORMAT T "NUM = ~A~% (AFTER END)" NUM)
;;      (GO START))
;;  )

  ;; (let ((tnum num))
  ;;   (kwhile (k-inbounds-p (length *CMDS*) tnum (+ tnum 1))
  ;;           (progn
  ;;             (addfun)
  ;;             (incf tnum))))

(keffacez nil
(kexpand-1 (kwhile (k-inbounds-p (length *CMDS*) tnum (+ tnum 1))
                   (progn
                     (addfun)
                     (incf tnum))))
)

(keffacez t
(DEFUN TEST-ADD ()
  (let* ((num 5)
         (tnum num)
         (idx 0))
    (TAGBODY
     START
       (PROGN
         (FORMAT T "After START, TNUM = ~A~%" TNUM)
         (incf idx)
         (when (> idx 10) (return-from TEST-ADD idx))
         (IF (AND (K-INBOUNDS-P (LENGTH *CMDS*) TNUM (+ TNUM 1)) (< TNUM 10))
             (PROGN
               (FORMAT T "NUM = ~A TNUM = ~A (LENGTH *CMDS*) = ~A~%"
                       NUM TNUM (LENGTH *CMDS*))
                                        ;(ADDFUN)
               (INCF TNUM))
             (GO END))
         )
     END
       (PROGN
         (FORMAT T "After END, TNUM = ~A~%" TNUM)
         (GO START)
         )
       )
    )
  )
)

;(macroexpand-1 '(kwhile (k-inbounds-p (length *CMDS*) tnum (+ tnum 1)) (progn (addfun) (incf tnum))))

;; (TAGBODY
;;  START
;;    (IF (K-INBOUNDS-P (LENGTH *CMDS*) TNUM (+ TNUM 1))
;;        (PROGN (ADDFUN) (INCF TNUM))
;;        (GO END))
;;  END
;;    (GO START))

