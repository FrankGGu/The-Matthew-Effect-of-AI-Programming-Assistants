#lang racket

(define (solve)
  (define input (current-input-port))
  (define n (read input))
  (define times (map (lambda (x) (string->number x)) (string-split (read-line))))
  (define dp (make-vector n #f))
  (vector-set! dp 0 0)
  (for ([i (in-range 1 n)])
    (define t (list-ref times i))
    (define prev (vector-ref dp (sub1 i)))
    (when prev
      (define new-val (+ prev t))
      (vector-set! dp i new-val)))
  (displayln (vector-ref dp (sub1 n))))

(solve)