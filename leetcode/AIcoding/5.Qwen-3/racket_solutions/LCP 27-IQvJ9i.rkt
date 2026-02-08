#lang racket

(define (mirrorReflection height width)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))
  (define g (gcd height width))
  (define h (/ height g))
  (define w (/ width g))
  (cond
    [(= (modulo h 2) 0) 2]
    [(= (modulo w 2) 0) 1]
    [else 0]))