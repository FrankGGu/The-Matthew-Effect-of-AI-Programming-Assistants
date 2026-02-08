(define/contract (find-longest-chain pairs)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([sorted-pairs (sort pairs (lambda (a b) (< (car a) (car b))))]
         [n (length sorted-pairs)]
         [dp (make-vector n 1)])
    (for ([i (in-range n)])
      (for ([j (in-range i)])
        (when (< (list-ref sorted-pairs j 1) (list-ref sorted-pairs i 0))
          (vector-set! dp i (max (vector-ref dp i) (+ (vector-ref dp j) 1))))))
    (apply max (vector->list dp))))