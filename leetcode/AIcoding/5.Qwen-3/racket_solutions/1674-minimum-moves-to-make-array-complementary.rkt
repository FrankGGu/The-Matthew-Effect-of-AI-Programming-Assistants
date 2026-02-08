#lang racket

(define (min-moves nums limit)
  (define n (length nums))
  (define freq (make-vector (* 2 limit) 0))
  (for ([i (in-range n)])
    (define a (list-ref nums i))
    (define b (list-ref nums (- n 1 i)))
    (vector-set! freq (+ a b) (+ (vector-ref freq (+ a b)) 1)))

  (define (get-min-moves target)
    (define count (vector-ref freq target))
    (- n count))

  (define min-moves (apply min (map get-min-moves (range 1 (+ limit 1)))))
  min-moves)

(define (main)
  (define input (read))
  (define limit (read))
  (display (min-moves input limit)))

(main)