(define (array-rank-transform arr)
  (define sorted (sort (remove-duplicates arr) <))
  (define rank-map (for/hash ((i (in-range (length sorted))) (x sorted)) (values x (add1 i))))
  (map (lambda (x) (hash-ref rank-map x)) arr))