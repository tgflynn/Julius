(defmacro my-macro (&whole entire-form arg1 arg2)
  (format t "The full form was: ~A~%" entire-form)
  `(list ,arg1 ,arg2))

;; Calling the macro:
(my-macro 1 2)
;; Output during expansion: "The full form was: (MY-MACRO 1 2)"
;; Result: (1 2)
