#lang racket

(define (my-atoi s)
  (define (helper s i sign)
    (cond [(>= i (string-length s)) 0]
          [(char=? #\space (string-ref s i)) (helper s (+ i 1) sign)]
          [(and (= sign 0) (char=? #\- (string-ref s i))) (helper s (+ i 1) -1)]
          [(and (= sign 0) (char=? #\+ (string-ref s i))) (helper s (+ i 1) 1)]
          [(not (char-numeric? (string-ref s i))) 0]
          [else
           (let ([digit (- (char->integer (string-ref s i)) 48)])
             (+ (* digit (expt 10 (- (string-length s) i 1)))
                (helper s (+ i 1) sign)))]))
  (define (clamp x)
    (if (> x 2147483647) 2147483647 (if (< x -2147483648) -2147483648 x)))
  (clamp (helper s 0 0)))