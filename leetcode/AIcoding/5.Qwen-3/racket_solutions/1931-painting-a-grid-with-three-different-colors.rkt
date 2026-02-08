(define (min-paint-operations n)
  (define (pow a b)
    (expt a b))
  (define (comb a b)
    (/ (factorial a) (* (factorial b) (factorial (- a b)))))
  (define (factorial x)
    (if (= x 0)
        1
        (* x (factorial (- x 1)))))
  (define dp
    (make-vector (+ n 1) 0))
  (vector-set! dp 0 1)
  (for ([i (in-range 1 (+ n 1))])
    (vector-set! dp i
                 (modulo
                  (for/sum ([k (in-range 1 (+ i 1))])
                    (* (vector-ref dp (- i k))
                       (comb (+ i k) k)))
                  1000000007)))
  (vector-ref dp n))