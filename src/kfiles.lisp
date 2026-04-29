
(in-package :IC)

(defun kfile-size (path)
  "Returns size of file: path."
  (let ((fsize 0))
  (with-open-file (is path :direction :input)
    (setf fsize (file-length is)))
    )
  )

(defun kfile-read (path)
  "Returns an array containing the contents of file: path."
  (let* ((fsize (kfile-size path))
         (flines (make-array fsize :initial-element nil)))
    (with-open-file (is path :direction :input)
      (read-sequence flines is)
      )
    flines
    )
  )

(defun kfile-read-txt (path)
  "Returns the contents of text file: path."
  (concatenate 'string (kfile-read path)))

(defun kfile-write (seq path &optional (when-there :error))
  "Writes the contents of sequence seq to file: path."
  (with-open-file (os path :direction :output :if-exists when-there)
    (write-sequence seq os)
    )
  )

(defun kfile-write-txt (txt path &optional (when-there :error))
  "Writes the contents of string txt to file: path."
  (with-open-file (os path :direction :output :if-exists when-there)
    (write-string txt os)
    )
  )


