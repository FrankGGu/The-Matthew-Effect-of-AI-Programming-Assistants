#lang racket

(define (can-measure? x y z)
  (if (or (= z x) (= z y) (= z (+ x y)))
      #t
      (let ((g (gcd x y)))
        (and (<= z (+ x y)) (= (modulo z g) 0)))))