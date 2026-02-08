#lang racket

(define/contract (validate-stack-sequences pushed popped)
  (-> (listof exact-integer?) (listof exact-integer?) boolean?)
  (let ([stack '()]
        [i 0])
    (for-each
     (lambda (x)
       (set! stack (cons x stack))
       (while (and (not (null? stack)) (= (car stack) (list-ref popped i)))
         (set! stack (cdr stack))
         (set! i (+ i 1))))
     pushed)
    (= i (length popped))))