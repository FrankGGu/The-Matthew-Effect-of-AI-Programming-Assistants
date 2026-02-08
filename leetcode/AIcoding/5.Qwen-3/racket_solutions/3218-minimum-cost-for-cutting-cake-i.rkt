#lang racket

(define (min-cost-for-cutting-cake horizontal-cuts vertical-cuts)
  (define (max-rectangle cuts)
    (let ([cuts (sort cuts <)])
      (let loop ([prev 0] [max-area 0] [i 0])
        (if (= i (length cuts))
            max-area
            (let ([current (list-ref cuts i)])
              (loop current (max max-area (- current prev)) (+ i 1)))))))
  (let ([h (max-rectangle horizontal-cuts)]
        [v (max-rectangle vertical-cuts)])
    (* h v)))