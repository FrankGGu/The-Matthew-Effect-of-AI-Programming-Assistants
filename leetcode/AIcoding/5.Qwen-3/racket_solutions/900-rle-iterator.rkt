#lang racket

(define (rle-iterator (nums . args) (pos 0))
  (define (next)
    (if (>= pos (length nums))
        -1
        (let* ((count (list-ref nums pos))
               (val (list-ref nums (+ pos 1))))
          (set! pos (+ pos 2))
          val)))
  (define (has-next)
    (< pos (length nums)))
  (lambda (m) (if (eq? m 'next) (next) (has-next))))