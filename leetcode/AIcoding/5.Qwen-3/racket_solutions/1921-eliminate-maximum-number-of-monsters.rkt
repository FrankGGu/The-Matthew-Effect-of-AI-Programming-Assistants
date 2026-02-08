#lang racket

(define (eliminate-maximum dist speed)
  (define (cmp a b)
    (< (car a) (car b)))
  (define times (map (lambda (d s) (/ d s)) dist speed))
  (define sorted-times (sort times cmp))
  (define (loop i lst count)
    (cond [(null? lst) count]
          [(<= (car lst) i) (loop (+ i 1) (cdr lst) (+ count 1))]
          [else (loop (+ i 1) (cdr lst) count)]))
  (loop 0 sorted-times 0))