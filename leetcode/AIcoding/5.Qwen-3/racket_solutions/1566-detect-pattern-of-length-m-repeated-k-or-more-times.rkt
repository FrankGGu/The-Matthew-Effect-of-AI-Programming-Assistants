#lang racket

(define (has-pattern arr m k)
  (define len (length arr))
  (define (check i)
    (define (loop j count)
      (if (>= j len)
          (>= count k)
          (if (equal? (take arr (+ i (* j m))) (take arr i))
              (loop (+ j 1) (+ count 1))
              #f)))
    (loop 1 1))
  (for/first ([i (in-range 0 (- len (* m k) 1))]
              #:when (check i))
    #t)
  #f)

(define (find-k-repeated-pattern arr k)
  (define len (length arr))
  (for/or ([m (in-range 1 (add1 (quotient len k)))]
           #:when (has-pattern arr m k))
    m))