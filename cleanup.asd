
;; (defsystem "k-clean"
;;   ;:class
;;   ;:precompiled-system
;;   ;:fasl (truename "klean.fasl")

;;   )

(defsystem "k-clean"
  :description "k-clean:"
  :version "0.0.1"
  :author "Joe User <joe@example.com>"
  :licence "Public Domain"
  :components ((:file "klean.lisp"))
  )

  ;; :depends-on ("optima.ppcre" "command-line-arguments")
  ;; :components ((:file "packages")
  ;;              (:file "macros" :depends-on ("packages"))
  ;;              (:file "hello" :depends-on ("macros"))))
