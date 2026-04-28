
(in-package :IC)

(defmacro keffacez (&optional (pas nil) &rest body)
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



