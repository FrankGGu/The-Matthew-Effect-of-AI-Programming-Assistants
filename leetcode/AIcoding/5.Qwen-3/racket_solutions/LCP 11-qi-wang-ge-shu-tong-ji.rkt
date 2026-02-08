(define (num-expected nums)
  (define count (make-hash))
  (for-each (lambda (n) (hash-set! count n (+ 1 (hash-ref count n 0)))) nums)
  (define (dfs n)
    (if (<= n 0) 0
        (+ (hash-ref count n 0) (dfs (- n 1)))))
  (dfs (apply max nums)))