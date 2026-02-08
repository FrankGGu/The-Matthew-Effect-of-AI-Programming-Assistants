#lang racket

(define (count-covered-buildings buildings)
  (define (compare a b)
    (if (= (car a) (car b))
        (> (cadr a) (cadr b))
        (< (car a) (car b))))
  (define sorted (sort buildings compare))
  (define (helper lst max-height count)
    (cond [(null? lst) count]
          [else
           (let ([h (cadr (car lst))])
             (if (> h max-height)
                 (helper (cdr lst) h (+ count 1))
                 (helper (cdr lst) max-height count)))]))
  (helper sorted 0 0))