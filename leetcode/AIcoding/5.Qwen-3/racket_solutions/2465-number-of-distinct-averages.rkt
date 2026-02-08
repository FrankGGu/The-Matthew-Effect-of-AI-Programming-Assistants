(define (distinct-averages nums)
  (define (average a b)
    (/ (+ a b) 2))
  (define sorted (sort nums <))
  (define len (length sorted))
  (define (helper i j seen)
    (if (>= i j)
        (set-count seen)
        (let* ([a (list-ref sorted i)]
               [b (list-ref sorted j)]
               [avg (average a b)])
          (helper (add1 i) (sub1 j) (set-add seen avg)))))
  (helper 0 (sub1 len) (set)))