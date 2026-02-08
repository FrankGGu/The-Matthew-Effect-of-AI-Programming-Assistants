(define (num-of-minutes n head-id manager-employee-time)
  (define graph (make-hash))
  (for ([i (in-range n)])
    (hash-set! graph i '()))
  (for ([i (in-range (length manager-employee-time))]
        [manager (in-list (map car manager-employee-time))]
        [time (in-list (map cadr manager-employee-time))])
    (hash-set! graph manager (cons i (hash-ref graph manager))))
  (define (dfs node)
    (if (null? (hash-ref graph node))
        0
        (apply max (map (lambda (child) (+ (hash-ref graph node) (dfs child))) (hash-ref graph node)))))
  (dfs head-id))