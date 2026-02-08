#lang racket

(define/contract (results-array nums k)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let ([n (length nums)])
    (if (<= k 0)
        nums
        (let ([res (make-vector n -1)]
              [sum (make-vector (+ n 1) 0)])
          (for ([i (in-range n)])
            (vector-set! sum i (+ (vector-ref sum (- i 1)) (list-ref nums i))))
          (for ([i (in-range n)])
            (let ([l (max 0 (- i k))]
                  [r (min (- n 1) (+ i k))])
              (when (<= l r)
                (vector-set! res i (/ (- (vector-ref sum (+ r 1)) (vector-ref sum l)) (+ (- r l) 1))))))
          (vector->list res))))))