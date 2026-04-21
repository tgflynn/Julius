(defmacro alpha (x y) `(beta ,x ,y))   ; =>  ALPHA
 (defmacro beta (x y) `(gamma ,x ,y))  ; =>  BETA
 (defmacro delta (x y) `(gamma ,x ,y)) ;  =>  EPSILON
