#lang racket

(define (is-prime n)
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

(define (num-primes up-to)
  (let loop ([n 2] [count 0])
    (if (> n up-to)
        count
        (loop (+ n 1) (+ count (if (is-prime n) 1 0))))))

(define (prime-arrangements n)
  (let ([primes (num-primes n)])
    (let ([non-primes (- n primes)])
      (let ([factorial (lambda (x) (if (= x 0) 1 (* x (factorial (- x 1)))))]
        (* (factorial primes) (factorial non-primes))))))