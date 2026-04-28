(defpackage julius/tests/main
  (:use :cl
        :julius
        :rove))
(in-package :julius/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :julius)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))

(deftest test-target-2
  (testing "should (= 1 1) to be true"
    (ok (= 1 (ic::kidentity 1)))))

