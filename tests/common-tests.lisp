(defpackage julius/tests/common
  (:use :cl
        :julius
        :rove))
(in-package :julius/tests/common)

(deftest test-target-common-1
  {let* ((tlst '(1 2 3 :tsym))
         (texp '(T T T NIL)))
  (testing "List of tests"
           (ok (= 1 (ic::kidentity 1)))
           (ok (= 255 #XFF))
           (ok (equal "kerror: \"kerror test\"" (ic::kerror "kerror test" nil)))
           (ok (signals (ic::kerror (error "kerror test") t)))
           (ok (equal t (ic::katomp :ksym-test-julius-1)))
           (ok (equal t (ic::katomp #\|)))
           (ok (equal t (ic::katomp '())))
           (ok (equal t (ic::katomp "a test string")))
           (ok (equal t ((equal (ic::kfilter #'(lambda (x) (numberp x))
                                             tlst) texp))))
           )
  )
