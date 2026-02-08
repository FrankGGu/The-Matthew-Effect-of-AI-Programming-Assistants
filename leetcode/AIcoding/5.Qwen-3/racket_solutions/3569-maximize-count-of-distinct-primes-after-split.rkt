#lang racket

(define (is-prime n)
  (cond [(<= n 1) #f]
        [(= n 2) #t]
        [(even? n) #f]
        [else
         (define sqrt-n (sqrt n))
         (for/first ([i (in-range 3 (add1 (floor sqrt-n)) 2)]
                     #:when (= (modulo n i) 0))
           #f)
         #t]))

(define (prime-factors n)
  (let loop ([n n] [factors '()])
    (if (= n 1)
        factors
        (let ([i (for/first ([i (in-range 2 (add1 (sqrt n)))]
                             #:when (= (modulo n i) 0))
                   i)])
          (if i
              (loop (/ n i) (cons i factors))
              (cons n factors))))))

(define (distinct-primes-count n)
  (length (remove-duplicates (prime-factors n))))

(define (maximize-count-of-distinct-primes-after-split n)
  (if (< n 2)
      0
      (let ([factors (prime-factors n)])
        (if (= (length factors) 1)
            0
            (distinct-primes-count (car factors))
            ))))