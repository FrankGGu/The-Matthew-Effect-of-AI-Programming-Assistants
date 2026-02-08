#lang racket

(define (get-ksorted arr k)
  (define (median lst)
    (define len (length lst))
    (list-ref (sort lst <) (quotient len 2)))
  (define sorted (sort arr >))
  (define (compare a b)
    (let ([m (median sorted)])
      (if (= (abs (- a m)) (abs (- b m)))
          (> a b)
          (> (abs (- a m)) (abs (- b m))))))
  (take (sort arr compare) k))