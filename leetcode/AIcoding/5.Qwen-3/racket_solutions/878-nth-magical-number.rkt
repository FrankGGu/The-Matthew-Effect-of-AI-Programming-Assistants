#lang racket

(define (nth-magical-number n k)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))
  (define (lcm a b)
    (/ (* a b) (gcd a b)))
  (define MOD 1000000007)
  (define low 1)
  (define high (* k 1000000000))
  (define (count-multiples x)
    (- (+ (quotient x k) (quotient x k)) (quotient x (lcm k k))))
  (let loop ([low low] [high high])
    (if (> low high)
        (modulo low MOD)
        (let* ([mid (quotient (+ low high) 2)]
               [cnt (count-multiples mid)])
          (if (< cnt n)
              (loop (+ mid 1) high)
              (loop low (- mid 1)))))))