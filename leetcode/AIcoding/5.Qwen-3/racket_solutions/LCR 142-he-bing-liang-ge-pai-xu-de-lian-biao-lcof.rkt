(define (trainning-plan-iv nums)
  (define (dfs idx path sum)
    (cond [(= idx (length nums)) (if (= sum 0) 1 0)]
          [else
           (let ([a (dfs (+ idx 1) path (+ sum (list-ref nums idx)))]
                 [b (dfs (+ idx 1) path sum)])
             (+ a b))]))
  (dfs 0 '() 0))