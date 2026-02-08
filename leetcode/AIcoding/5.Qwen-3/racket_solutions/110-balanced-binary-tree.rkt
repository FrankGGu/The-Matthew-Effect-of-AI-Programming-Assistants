#lang racket

(define (balanced? tree)
  (cond
    [(null? tree) #t]
    [else
     (let* ([left (car tree)]
            [right (cadr tree)]
            [left-balance (balanced? left)]
            [right-balance (balanced? right)]
            [left-height (if left-balance (height left) -1)]
            [right-height (if right-balance (height right) -1)])
       (and left-balance
            right-balance
            (<= (abs (- left-height right-height)) 1)))]))

(define (height tree)
  (if (null? tree)
      0
      (+ 1 (max (height (car tree)) (height (cadr tree)))))

(define (is-balanced root)
  (balanced? root))