#lang racket

(define (find-the-difference s t)
  (define (char->int c) (- (char->integer c) (char->integer #\a)))
  (define cnt (make-vector 26 0))
  (for ([c t])
    (vector-set! cnt (char->int c) (+ (vector-ref cnt (char->int c)) 1)))
  (for ([c s])
    (vector-set! cnt (char->int c) (- (vector-ref cnt (char->int c)) 1)))
  (let loop ([i 0])
    (if (= (vector-ref cnt i) 1)
        (integer->char (+ i (char->integer #\a)))
        (loop (+ i 1)))))