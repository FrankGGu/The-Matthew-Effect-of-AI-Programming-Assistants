#lang racket

(define (is-prime n)
  (cond [(<= n 1) #f]
        [(= n 2) #t]
        [(even? n) #f]
        [else
         (define (check i)
           (if (> i (sqrt n))
               #t
               (if (= (modulo n i) 0)
                   #f
                   (check (+ i 2)))))
         (check 3)]))

(define (max-prime-difference nums)
  (define primes
    (filter is-prime nums))
  (- (apply max primes) (apply min primes)))