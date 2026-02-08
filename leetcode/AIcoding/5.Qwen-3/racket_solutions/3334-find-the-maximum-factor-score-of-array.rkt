#lang racket

(define (max-factor-score nums)
  (define (factor-count n)
    (define (iter i count)
      (cond [(> i (sqrt n)) count]
            [(= (modulo n i) 0)
             (if (= i (/ n i))
                 (+ count 1)
                 (+ count 2))]
            [else (iter (+ i 1) count)]))
    (iter 1 0))

  (define (score n)
    (expt (factor-count n) 2))

  (apply max (map score nums)))