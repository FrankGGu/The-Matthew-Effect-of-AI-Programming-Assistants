#lang racket

(define (find-k-closest arr k x)
  (define (abs-cmpr a b)
    (if (= (abs (- a x)) (abs (- b x)))
        (<= a b)
        (<= (abs (- a x)) (abs (- b x)))))
  (define (cmp a b)
    (if (= (abs (- a x)) (abs (- b x)))
        (<= a b)
        (< (abs (- a x)) (abs (- b x)))))
  (define sorted (sort arr cmp))
  (take sorted k))