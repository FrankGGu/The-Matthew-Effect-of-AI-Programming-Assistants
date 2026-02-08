(define (min-array-sum nums a b)
  (define (f x)
    (if (<= x a) x (+ x b)))
  (apply + (map f nums)))