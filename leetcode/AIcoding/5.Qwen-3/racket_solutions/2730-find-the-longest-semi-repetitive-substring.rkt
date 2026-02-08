#lang racket

(define (longest-substring s)
  (define n (string-length s))
  (define dp (make-vector n (make-vector n 0)))
  (for ([i (in-range n)])
    (vector-set! (vector-ref dp i) i 1))
  (for ([i (in-range (- n 1))]
        [j (in-range 1 n)])
    (when (= (string-ref s i) (string-ref s j))
      (vector-set! (vector-ref dp i) j (+ (vector-ref (vector-ref dp i) (- j 1)) 1))))
  (for ([i (in-range n)]
        [j (in-range 1 n)])
    (when (and (< i (- j 1)) (= (string-ref s i) (string-ref s j)))
      (vector-set! (vector-ref dp i) j (+ (vector-ref (vector-ref dp i) (- j 1)) 1))))
  (apply max (for/list ([i (in-range n)])
               (apply max (vector->list (vector-ref dp i)))))

(define (main)
  (define s (read-line))
  (printf "~a\n" (longest-substring s)))

(main)