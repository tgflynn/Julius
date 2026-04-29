(defsystem "julius"
  :version "0.0.1"
  :author "Timothy G. Flynn"
  :license ""
  :depends-on ()
  :components (
               (:module "src"
                        :components
                        ((:file "main")
                         (:file "macros")
                         (:file "common")
                         ))
               (:module "REPL"
                        :depends-on ("src")
                        :components
                        ((:file "repl")))
               )
  :description ""
  :in-order-to ((test-op (test-op "julius/tests"))))

(defsystem "julius/tests"
  :author ""
  :license ""
  :depends-on ("julius"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main")
                 (:file "common-tests")
                 (:file "repl-tests"))))
  :description "Test system for julius"
  :perform (test-op (op c) (symbol-call :rove :run c))
  ;:perform (test-op (op c) (symbol-call :rove :run-all-tests))

  )
