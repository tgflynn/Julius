
(defparameter *PROJ-ROOT* (truename "."))
(defparameter *PROJ-ASDF-FILE* (format nil "~a~a" *PROJ-ROOT* "julius.asd"))

(format t "*PROJ-ASDF-FILE* = ~a~%" *PROJ-ASDF-FILE*)

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

(asdf:initialize-source-registry *PROJ-ASDF-FILE*)

(asdf:load-system :julius)

;(require :julius)
