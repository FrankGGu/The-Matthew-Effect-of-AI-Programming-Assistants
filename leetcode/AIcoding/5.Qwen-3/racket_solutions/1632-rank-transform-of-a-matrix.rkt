#lang racket

(define (array-map f arr)
  (for/vector #:length (vector-length arr)
    ([x arr])
    (f x)))

(define (array-sort arr)
  (vector-sort arr <))

(define (rank-transform matrix)
  (define n (vector-length matrix))
  (define m (if (> n 0) (vector-length (vector-ref matrix 0)) 0))
  (define values (for*/vector ([i (in-range n)] [j (in-range m)]) (vector-ref (vector-ref matrix i) j)))
  (define sorted-values (array-sort values))
  (define unique-values (let loop ([prev #f] [i 0] [res '()])
                          (cond [(= i (vector-length sorted-values)) (reverse res)]
                                [(or (not prev) (not (= (vector-ref sorted-values i) prev)))
                                 (loop (vector-ref sorted-values i) (+ i 1) (cons (vector-ref sorted-values i) res))]
                                [else (loop prev (+ i 1) res)])))
  (define value->rank (for/hash ([v unique-values] [i (in-range (vector-length unique-values))]) (values v i)))
  (define result (make-vector n (make-vector m 0)))
  (for ([i (in-range n)])
    (for ([j (in-range m)])
      (vector-set! (vector-ref result i) j (add1 (hash-ref value->rank (vector-ref (vector-ref matrix i) j))))))
  result)