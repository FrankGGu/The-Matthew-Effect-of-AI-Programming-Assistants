#lang racket

(define (find-occurrences text key)
  (define lst (string-split text))
  (define len (length lst))
  (define (helper i res)
    (if (>= i (- len 2))
        res
        (let ([a (list-ref lst i)]
              [b (list-ref lst (+ i 1))]
              [c (list-ref lst (+ i 2))])
          (if (and (equal? a key) (equal? b key))
              (helper (+ i 1) (append res (list c)))
              (helper (+ i 1) res)))))
  (helper 0 '()))