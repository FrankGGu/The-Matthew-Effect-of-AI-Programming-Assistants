(define (min-camera a)
  (define (dfs node)
    (cond [(not node) 0]
          [else
           (let ([left (dfs (car node))]
                 [right (dfs (cadr node))])
             (if (or (= left 1) (= right 1))
                 (add1 (max left right))
                 (if (or (= left 2) (= right 2))
                     (max left right)
                     (begin
                       (set! ans (add1 ans))
                       0))))]))
  (define ans 0)
  (when (= (dfs a) 0)
    (set! ans (add1 ans)))
  ans)