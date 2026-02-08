(define (can-reach arr start)
  (define visited (make-hash))
  (define (dfs i)
    (if (or (< i 0) (>= i (length arr)) (hash-has-key? visited i)) #f
        (begin
          (hash-set! visited i #t)
          (if (= (vector-ref arr i) 0) #t
              (or (dfs (+ i (vector-ref arr i))) (dfs (- i (vector-ref arr i))))))))
  (dfs start))