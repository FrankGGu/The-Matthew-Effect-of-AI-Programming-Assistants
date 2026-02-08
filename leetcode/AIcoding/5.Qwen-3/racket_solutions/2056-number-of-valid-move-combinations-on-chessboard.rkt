#lang racket

(define (number-of-valid-move-combinations)
  (define (dfs x y steps visited)
    (if (= steps 10)
        1
        (for/sum ([dx '(-2 -1 1 2)]
                  [dy '(-2 -1 1 2)]
                  #:when (and (not (= dx 0))
                              (not (= dy 0))
                              (<= 0 (+ x dx) 7)
                              (<= 0 (+ y dy) 7)
                              (not (member (list (+ x dx) (+ y dy)) visited))))
          (dfs (+ x dx) (+ y dy) (+ steps 1) (cons (list (+ x dx) (+ y dy)) visited)))))
  (for/sum ([x (in-range 8)]
            [y (in-range 8)])
    (dfs x y 1 (list (list x y)))))