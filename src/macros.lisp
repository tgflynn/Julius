
(in-package :IC)

(defmacro keffacez (&optional (pas nil) &rest body)
  "Macro which removes s-expressions contained in body unless pas is t."
  ;; (declare (optimize
  ;;           (safety 0)
  ;;           (speed 0)
  ;;           (space 0)
  ;;           (debug 0)
  ;;           (compilation-speed 0)))
  ;; (declare (muffle-conditions style-warning))
  (if (equal (eval pas) t)
      `(progn ,@body)
      `(progn )))

(keffacez nil
(defmacro klambda (&whole form &rest bvl-decls-and-body)
  (declare (ignore bvl-decls-and-body))
  (quote (list form)))
)

(keffacez t
(defun test-keffacez-1 ()
(consp '()))
)

(keffacez nil
(defun test-keffacez-1 ()
(consp '()))
)

(keffacez
(defun test-keffacez-1 ()
(consp '()))
)


