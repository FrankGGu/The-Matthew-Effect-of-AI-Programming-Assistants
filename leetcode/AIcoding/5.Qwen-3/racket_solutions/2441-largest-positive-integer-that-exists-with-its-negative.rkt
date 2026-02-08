#lang racket

(define/contract (get-integer-with-negative nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([num-set (set . map . (lambda (x) x) nums)])
    (let loop ([i (apply max nums)])
      (if (and (positive? i) (set-member? num-set (- i)))
          i
          (loop (- i 1))))))