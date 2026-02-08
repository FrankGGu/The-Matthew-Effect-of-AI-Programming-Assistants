#lang racket

(define (next-balanced n)
  (define (is-balanced? num)
    (define digits (string->list (number->string num)))
    (define count (make-hash))
    (for-each (lambda (d) (hash-set! count d (+ (hash-ref count d 0) 1))) digits)
    (for/and ([i (in-range 1 (add1 (length digits)))])
      (= (hash-ref count (number->string i) 0) 1)))

  (define (next-number n)
    (let loop ([num (add1 n)])
      (if (is-balanced? num)
          num
          (loop (add1 num)))))

  (next-number n))

(define (main)
  (define input (read-line))
  (define n (string->number input))
  (displayln (next-balanced n)))

(main)