#lang racket

(define (number-of-ways-to-earn-points points)
  (define dp (make-hash))
  (define (dfs i target)
    (cond [(hash-has-key? dp (cons i target)) (hash-ref dp (cons i target))]
          [(= target 0) 1]
          [(>= i (length points)) 0]
          [else
           (define count (dfs (+ i 1) target))
           (define new-target (- target (list-ref points i)))
           (if (>= new-target 0)
               (begin
                 (hash-set! dp (cons i target) (+ count (dfs i new-target)))
                 (+ count (dfs i new-target)))
               (begin
                 (hash-set! dp (cons i target) count)
                 count))]))
  (dfs 0 (apply + points)))