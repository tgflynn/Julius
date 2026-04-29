(defpackage julius/tests/repl
  (:use :cl
        :julius
        :rove))
(in-package :julius/tests/repl)

(deftest test-target-repl-1
  (testing "List of tests"
           (ok (= 1 1))
           (ok (= 1 (ic::kidentity 1)))
           )
  )


