#lang racket

(define (perfect-number n)
  (cond [(<= n 1) #f]
        [else
         (define (sum-divisors i total)
           (if (> i (sqrt n))
               total
               (if (= (modulo n i) 0)
                   (if (= i 1)
                       (sum-divisors (+ i 1) (+ total i))
                       (sum-divisors (+ i 1) (+ total i (/ n i))))
                   (sum-divisors (+ i 1) total))))
         (= (sum-divisors 2 1) n)]))