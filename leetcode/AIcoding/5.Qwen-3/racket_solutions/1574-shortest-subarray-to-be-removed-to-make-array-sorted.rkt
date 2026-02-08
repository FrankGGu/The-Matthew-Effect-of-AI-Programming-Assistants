#lang racket

(define (shortest-subarray-to-be-removed-to-make-array-sorted arr)
  (define n (length arr))
  (define left (box 0))
  (define right (box (- n 1)))
  (let loop ()
    (when (and (< (unbox left) n) (<= (unbox left) (unbox right)) (<= (list-ref arr (unbox left)) (list-ref arr (+ 1 (unbox left))))
      (set-box! left (+ 1 (unbox left))))
    (when (and (> (unbox right) -1) (>= (unbox left) (unbox right)) (<= (list-ref arr (unbox right)) (list-ref arr (- (unbox right) 1))))
      (set-box! right (- (unbox right) 1))))
  (- n (+ (unbox right) 1 - (unbox left))))