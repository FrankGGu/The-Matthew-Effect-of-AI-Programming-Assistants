#lang racket

(define (max-palindrome-length s)
  (define n (string-length s))
  (define dp (make-vector n (lambda () (make-vector n 0))))

  (for ([i (in-range n)])
    (vector-set! (vector-ref dp i) i 1))

  (for ([length (in-range 2 n)]
        [i (in-range 0 (- n length +1))])
    (define j (+ i length -1))
    (if (= (string-ref s i) (string-ref s j))
        (vector-set! (vector-ref dp i) j (+ 2 (vector-ref (vector-ref dp (+ i 1)) (- j 1))))
        (vector-set! (vector-ref dp i) j (max (vector-ref (vector-ref dp i) (- j 1))
                                             (vector-ref (vector-ref dp (+ i 1)) j)))))

  (vector-ref (vector-ref dp 0) (- n 1)))