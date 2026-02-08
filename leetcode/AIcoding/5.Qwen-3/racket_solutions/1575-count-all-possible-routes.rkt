(define (count-all-routes n locations)
  (define memo (make-hash))
  (define (dfs i j)
    (cond [(and (= i j) (< j n)) 1]
          [(>= i n) 0]
          [else
           (hash-ref memo (cons i j) #f)
           (let ([res 0])
             (for ([k (in-range n)])
               (when (not (= k j))
                 (set! res (+ res (dfs k j)))))
             (hash-set! memo (cons i j) res)
             res)]))
  (define (solve)
    (let ([res 0])
      (for ([i (in-range n)])
        (set! res (+ res (dfs i i))))
      res))
  (solve))