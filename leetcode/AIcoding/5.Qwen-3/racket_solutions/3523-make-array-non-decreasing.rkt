#lang racket

(define (canBeNonDecreasing nums)
  (define (check lst)
    (or (null? lst)
        (null? (cdr lst))
        (<= (car lst) (cadr lst)) (check (cdr lst))))
  (let loop ([i 0] [prev -inf.0])
    (cond [(= i (length nums)) #t]
          [(<= (list-ref nums i) prev) (loop (+ i 1) prev)]
          [else (check (append (take nums i) (drop nums (+ i 1))))])))