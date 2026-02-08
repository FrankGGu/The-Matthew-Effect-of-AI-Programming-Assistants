#lang racket

(define (max-non-overlapping-palindromes s)
  (define n (string-length s))
  (define dp (make-vector n 0))
  (define (is-palindrome? l r)
    (let loop ([l l] [r r])
      (cond [(>= l r) #t]
            [(char=? (string-ref s l) (string-ref s r)) (loop (+ l 1) (- r 1))]
            [else #f])))
  (for ([i (in-range n)])
    (when (is-palindrome? i i)
      (vector-set! dp i 1))
    (when (and (< i (- n 1)) (is-palindrome? i (+ i 1)))
      (vector-set! dp i 1))
    (when (> i 0)
      (when (is-palindrome? (- i 1) i)
        (vector-set! dp i (+ (vector-ref dp (- i 1)) 1))))
    (when (> i 1)
      (when (is-palindrome? (- i 2) i)
        (vector-set! dp i (+ (vector-ref dp (- i 2)) 1)))))
  (vector-ref dp (- n 1)))