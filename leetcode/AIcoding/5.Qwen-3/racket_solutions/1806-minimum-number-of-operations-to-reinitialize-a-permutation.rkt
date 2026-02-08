(define (reinitialize-permutation n)
  (define (count-operations i visited)
    (if (vector-ref visited i)
        0
        (begin
          (vector-set! visited i #t)
          (+ 1 (count-operations (if (= i 0) 0 (if (= i (- n 1)) (- n 1) (+ i 1))) visited)))))
  (define visited (make-vector n #f))
  (for/sum ([i (in-range n)])
    (if (vector-ref visited i)
        0
        (count-operations i visited))))