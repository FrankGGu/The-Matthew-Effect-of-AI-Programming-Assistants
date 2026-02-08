#lang racket

(define/contract (sum lst start end)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (if (> start end)
      0
      (+ (list-ref lst start) (sum lst (add1 start) end))))

(define/contract (defuse-the-bomb code time)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let* ((n (length code))
         (result (make-vector n 0)))
    (for ([i (in-range n)])
      (vector-set! result i 
        (sum code 
             (modulo (- i time) n) 
             (modulo (+ i time) n))))
    (vector->list result)))