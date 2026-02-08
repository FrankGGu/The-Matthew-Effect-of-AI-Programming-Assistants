#lang racket

(define (max-length-equal-subsequence s t)
  (define n (string-length s))
  (define m (string-length t))
  (define dp (make-vector (+ n 1) (make-vector (+ m 1) 0)))
  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 1 (+ m 1))])
      (if (char=? (string-ref s (- i 1)) (string-ref t (- j 1)))
          (vector-set! (vector-ref dp i) j (+ 1 (vector-ref (vector-ref dp (- i 1)) (- j 1))))
          (vector-set! (vector-ref dp i) j (max (vector-ref (vector-ref dp (- i 1)) j)
                                               (vector-ref (vector-ref dp i) (- j 1)))))))
  (vector-ref (vector-ref dp n) m))