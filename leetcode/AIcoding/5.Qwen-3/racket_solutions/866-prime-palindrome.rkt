#lang racket

(define (is-palindrome? n)
  (define s (number->string n))
  (equal? s (reverse s)))

(define (is-prime? n)
  (cond [(<= n 1) #f]
        [(= n 2) #t]
        [(even? n) #f]
        [else
         (define sqrt-n (sqrt n))
         (for/and ([i (in-range 3 (add1 (floor sqrt-n)) 2)])
           (not (= (modulo n i) 0)))]))

(define (prime-palindrome n)
  (let loop ([i (if (< n 2) 2 n)])
    (if (and (is-palindrome? i) (is-prime? i))
        i
        (loop (add1 i)))))