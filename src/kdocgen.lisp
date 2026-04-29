
(in-package :IC)

(defun kdocgen-copy-txt-file (from-path to-path)
  (let ((txt (kfile-read-txt from-path)))
    (kfile-write-txt txt to-path :overwrite)
    )
  )
