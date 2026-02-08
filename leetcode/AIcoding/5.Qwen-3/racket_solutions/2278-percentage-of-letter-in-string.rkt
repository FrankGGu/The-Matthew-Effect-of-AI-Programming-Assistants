#lang racket

(define (percentage-of-letter s letter)
  (let* ([total (string-length s)]
         [count (for/sum ([c s]) (if (char=? c letter) 1 0))])
    (exact-round (* (/ count total) 100))))