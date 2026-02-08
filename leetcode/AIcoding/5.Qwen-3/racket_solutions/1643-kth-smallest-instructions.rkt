#lang racket

(define (kth-smallest-instructions instructions k)
  (define len (string-length instructions))
  (define (comb n k)
    (define (fact x)
      (if (= x 0) 1 (* x (fact (- x 1)))))
    (/ (fact n) (* (fact k) (fact (- n k)))))

  (define (find-kth n m k)
    (cond [(= n 0) ""]
          [(= m 0) (make-string n #\I)]
          [else
           (define c (comb (+ n m -1) m))
           (if (< k c)
               (string-append "D" (find-kth (- n 1) m k))
               (string-append "I" (find-kth n (- m 1) (- k c))))]))

  (define d (count #\D instructions))
  (define i (- len d))
  (find-kth i d k))