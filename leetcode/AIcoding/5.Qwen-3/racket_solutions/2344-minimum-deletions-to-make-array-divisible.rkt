#lang racket

(define (min-deletions nums divisors)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

  (define (lcm a b)
    (/ (* a b) (gcd a b)))

  (define (get-lcm-of-divisors divisors)
    (foldl lcm (car divisors) (cdr divisors)))

  (define target-lcm (get-lcm-of-divisors divisors))

  (define (divisible? num)
    (= (remainder num target-lcm) 0))

  (define count (length (filter divisible? nums)))

  (- (length nums) count))