
(in-package :IC)

(defun kdocgen-copy-txt-file (from-path to-path)
  (let ((txt (kfile-read-txt from-path)))
    (kfile-write-txt txt to-path :overwrite)
    )
  )

(defun kdocgen-parse-md-file (path)
  "Parses md file: path into an AST implemented by nested lists and returns this tree."
  (let ((ast '())
        (txt (kfile-read-txt path)))
    (kunused txt)
    ast
    )
  )
