#lang racket

(define (ideal-arrays n)
  (define MOD 1000000007)
  (define max-n 100000)
  (define dp (make-vector (add1 max-n) 0))
  (vector-set! dp 1 1)
  (for ([i (in-range 2 (add1 max-n))])
    (vector-set! dp i (modulo (* (vector-ref dp (- i 1)) i) MOD)))
  (define (comb n k)
    (if (<= k 0) 1
        (modulo (* (comb n (- k 1)) (- n k 1)) MOD)))
  (define (factorial x) (vector-ref dp x))
  (define (inv x)
    (expt x (- MOD 2) MOD))
  (define (c n k)
    (if (or (< k 0) (> k n)) 0
        (modulo (* (factorial n) (inv (modulo (* (factorial k) (factorial (- n k)) MOD)) MOD)) MOD)))
  (define (solve n)
    (let loop ([i 1] [res 0])
      (if (> i n) res
          (loop (+ i 1) (modulo (+ res (* (c n i) (expt 2 (- i 1)))) MOD)))))
  (solve n))