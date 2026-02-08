#lang racket

(define (rob nums)
  (cond [(null? nums) 0]
        [(null? (cdr nums)) (car nums)]
        [else
         (let loop ([i 0] [prev 0] [curr 0])
           (if (= i (length nums))
               curr
               (loop (+ i 1) curr (max (+ prev (list-ref nums i)) curr))))]))