#lang racket

(define (min-operations nums)
  (define n (length nums))
  (define sorted (sort nums <))
  (define (find-lower idx val)
    (let loop ([i 0] [j (- n 1)])
      (cond [(> i j) -1]
            [(<= (list-ref sorted i) val) (loop (+ i 1) j)]
            [else (loop i (- j 1))])))
  (define (find-upper idx val)
    (let loop ([i 0] [j (- n 1)])
      (cond [(> i j) -1]
            [(>= (list-ref sorted j) val) (loop i (- j 1))]
            [else (loop (+ i 1) j)])))
  (define (count-in-range l r)
    (- r l 1))
  (define res (make-vector n 0))
  (for ([i (in-range n)])
    (define target (list-ref sorted i))
    (define left (find-lower 0 (- target 1)))
    (define right (find-upper 0 (+ target 1)))
    (vector-set! res i (- n (+ (- right left) 1))))
  (apply min (vector->list res)))