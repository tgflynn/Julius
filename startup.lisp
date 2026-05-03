
(defparameter *PROJ-ROOT* (truename "."))
(defparameter *PROJ-ASDF-FILE* (format nil "~a~a" *PROJ-ROOT* "julius.asd"))

(format t "*PROJ-ASDF-FILE* = ~a~%" *PROJ-ASDF-FILE*)

(asdf:initialize-source-registry *PROJ-ASDF-FILE*)

(asdf:load-system :julius)

