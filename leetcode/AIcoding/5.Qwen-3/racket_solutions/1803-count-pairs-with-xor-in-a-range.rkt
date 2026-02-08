#lang racket

(define (count-pairs nums low high)
  (define (count-less-than x)
    (define cnt 0)
    (define seen #hash())
    (for-each
     (lambda (num)
       (set! cnt (+ cnt (hash-ref seen (bitwise-xor num x) 0)))
       (hash-set! seen num (+ 1 (hash-ref seen num 0))))
     nums)
    cnt)
  (- (count-less-than high) (count-less-than (sub1 low))))

(define (main)
  (define input (current-input-port))
  (define nums (map string->number (string-split (read-line input) ",")))
  (define low (string->number (car (string-split (read-line input)))))
  (define high (string->number (cadr (string-split (read-line input)))))
  (display (count-pairs nums low high)))

(main)