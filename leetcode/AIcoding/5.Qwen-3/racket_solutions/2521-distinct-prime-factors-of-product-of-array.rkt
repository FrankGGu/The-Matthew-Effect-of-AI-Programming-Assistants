#lang racket

(define (distinct-prime-factors nums)
  (define (prime? n)
    (cond [(<= n 1) #f]
          [(= n 2) #t]
          [(even? n) #f]
          [else
           (let loop ([i 3])
             (if (> i (sqrt n))
                 #t
                 (if (= (modulo n i) 0)
                     #f
                     (loop (+ i 2)))))]))

  (define (get-primes n)
    (let loop ([i 2] [primes '()])
      (if (> i n)
          primes
          (if (and (prime? i) (= (modulo n i) 0))
              (loop (+ i 1) (cons i primes))
              (loop (+ i 1) primes)))))

  (define product (apply * nums))
  (length (remove-duplicates (get-primes product))))