
(defparameter *PROJ-ASDF* (truename "julius.asd"))

;; (let* ((home (user-homedir-pathname))
;;        (hlen (length (directory-namestring home)))
;;        (project-asdf (make-pathname :directory
;;                                     `(:absolute
;;                                       ,(subseq (directory-namestring home) 1 (- hlen 1))
;;                                       "projects" "lisp" "projects" "julius")
;;                                     :name "julius"
;;                                     :type "asd"))
;;        )
;;   (setf *PROJ-ASDF* project-asdf))

;(asdf:initialize-source-registry *PROJ-ASDF*)

;(require :julius)
