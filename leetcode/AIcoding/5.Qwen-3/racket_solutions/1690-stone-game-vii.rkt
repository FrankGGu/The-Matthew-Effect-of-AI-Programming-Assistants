#lang racket

(define (stone-game-vii stones)
  (define n (length stones))
  (define dp (make-vector n (make-vector n 0)))
  (for ([i (in-range (- n 1) -1 -1)])
    (for ([j (in-range (+ i 1) n)])
      (vector-set! (vector-ref dp i) j (- (- (vector-ref stones i) (vector-ref stones j)) (+ (vector-ref (vector-ref dp i) (+ j 1)) (vector-ref (vector-ref dp (+ i 1) j)))))))
  (vector-ref (vector-ref dp 0) (- n 1)))