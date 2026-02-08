#lang racket

(define (count-anagrams s)
  (define mod 1000000007)
  (define len (string-length s))
  (define fact (make-vector (+ len 1) 1))
  (for ([i (in-range 1 (add1 len))])
    (vector-set! fact i (* (vector-ref fact (sub1 i)) i)))
  (define inv-fact (make-vector (+ len 1) 1))
  (vector-set! inv-fact len (pow (vector-ref fact len) (- mod 2) mod))
  (for ([i (in-range (sub1 len) -1 -1)])
    (vector-set! inv-fact i (* (vector-ref inv-fact (add1 i)) (add1 i))))
  (define cnt (make-hash))
  (for ([c (in-string s)])
    (hash-update! cnt c add1 0))
  (define total (apply + (hash-values cnt)))
  (define res (vector-ref fact total))
  (for ([v (hash-values cnt)])
    (set! res (* res (vector-ref inv-fact v))))
  res)

(define (pow a b mod)
  (cond [(= b 0) 1]
        [(even? b) (let ([x (pow a (/ b 2) mod)]) (* x x))]
        [else (* a (pow a (sub1 b) mod))]))