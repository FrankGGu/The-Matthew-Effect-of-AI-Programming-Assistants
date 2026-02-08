#lang racket

(define (minimum-operations s)
  (define n (string-length s))
  (define-values (red green) (values 0 0))
  (for ([c (in-string s)])
    (when (char=? c #\R) (set! red (+ red 1)))
    (when (char=? c #\G) (set! green (+ green 1))))
  (if (or (= red 0) (= green 0)) 0
      (let loop ([i 0] [r 0] [g 0] [min-ops +inf.0])
        (cond [(= i n) min-ops]
              [else
               (cond [(char=? (string-ref s i) #\R) (loop (+ i 1) (+ r 1) g (min min-ops (- g r)))]
                     [(char=? (string-ref s i) #\G) (loop (+ i 1) r (+ g 1) (min min-ops (- r g)))]
                     [else (loop (+ i 1) r g min-ops)])]))))