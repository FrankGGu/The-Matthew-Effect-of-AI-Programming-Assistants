#lang racket

(define (count-arrays n k)
  (define MOD 1000000007)
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 1 1)
  (for ([i (in-range 2 (+ n 1))])
    (vector-set! dp i (modulo (* (vector-ref dp (- i 1)) (max 1 (- i 1))) MOD)))
  (if (< k 1)
      0
      (modulo (vector-ref dp n) MOD)))

(define (main)
  (let* ([input (current-command-line-arguments)]
         [n (string->number (vector-ref input 0))]
         [k (string->number (vector-ref input 1))])
    (printf "~a\n" (count-arrays n k))))

(main)