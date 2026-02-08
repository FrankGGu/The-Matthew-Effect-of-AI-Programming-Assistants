#lang racket

(define (allocate-mailboxes houses cost)
  (define n (length houses))
  (define dp (make-vector n (make-vector n 0)))
  (define (distance i j)
    (if (= i j)
        0
        (let loop ([k i] [sum 0])
          (if (> k j)
              sum
              (loop (+ k 1) (+ sum (abs (- (list-ref houses k) (list-ref houses i)))))))))
  (for ([i (in-range n)])
    (for ([j (in-range i n)])
      (vector-set! (vector-ref dp i) j (distance i j))))
  (for ([i (in-range n)])
    (vector-set! (vector-ref dp i) i 0))
  (for ([i (in-range n)])
    (for ([j (in-range i n)])
      (when (> j i)
        (vector-set! (vector-ref dp i) j (distance i j)))))
  (define (min-cost i j)
    (if (>= i j)
        0
        (let ([res (vector-ref (vector-ref dp i) j)])
          (for ([k (in-range i j)])
            (set! res (min res (+ (min-cost i k) (min-cost (+ k 1) j)))))
          res)))
  (min-cost 0 (- n 1)))