#lang racket

(define (max-points n)  
  (define (dfs index points left)  
    (if (>= index n)  
        points  
        (let ((max-val 0))  
          (for ([i (in-range (min left 10) -1 -1)])  
            (set! max-val (max max-val (dfs (+ index 1) (+ points i) (- left i)))))  
          max-val)))  
  (dfs 0 0 11))