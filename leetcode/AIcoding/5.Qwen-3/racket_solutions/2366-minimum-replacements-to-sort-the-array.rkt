#lang racket

(define (minimum-replacements nums)
  (define (f i)
    (if (= i (sub1 (length nums)))
        0
        (let ((current (list-ref nums i))
              (next (list-ref nums (add1 i))))
          (if (<= current next)
              (f (add1 i))
              (+ 1 (f (add1 i)))))))
  (f 0))