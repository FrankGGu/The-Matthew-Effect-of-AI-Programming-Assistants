#lang racket

(define (max-edge-score nums)
  (define n (length nums))
  (define scores (make-vector n 0))
  (for ([i (in-range n)])
    (define j (vector-ref nums i))
    (when (< j n)
      (vector-set! scores j (+ (vector-ref scores j) i))))
  (argmax (lambda (i) (vector-ref scores i)) (range n)))