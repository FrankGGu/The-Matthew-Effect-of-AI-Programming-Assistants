#lang racket

(define (max-amount-of-cookies cookies)
  (define (dfs idx cnt)
    (cond [(= idx (length cookies)) cnt]
          [else
           (for/fold ([max-cnt -inf.0])
                     ([i (in-range (length cnt))])
             (if (= (list-ref cnt i) 0)
                 (max max-cnt (dfs (add1 idx) (append (take cnt i) (list 1) (drop cnt (add1 i)))))
                 (max max-cnt (dfs (add1 idx) (append (take cnt i) (list (+ 1 (list-ref cnt i))) (drop cnt (add1 i))))))]))
  (dfs 0 (make-list (length cookies) 0)))

(define (distribute-cookies cookies)
  (define (helper idx people)
    (cond [(= idx (length cookies)) (apply min people)]
          [else
           (for/fold ([res +inf.0])
                     ([i (in-range (length people))])
             (if (= (list-ref people i) 0)
                 (min res (helper (add1 idx) (append (take people i) (list 1) (drop people (add1 i)))))
                 (min res (helper (add1 idx) (append (take people i) (list (+ 1 (list-ref people i))) (drop people (add1 i))))))]))
  (helper 0 (make-list (length cookies) 0)))

(define (fair-distribution-of-cookies cookies)
  (define (backtrack idx people)
    (cond [(= idx (length cookies)) (apply min people)]
          [else
           (for/fold ([res +inf.0])
                     ([i (in-range (length people))])
             (if (= (list-ref people i) 0)
                 (min res (backtrack (add1 idx) (append (take people i) (list 1) (drop people (add1 i)))))
                 (min res (backtrack (add1 idx) (append (take people i) (list (+ 1 (list-ref people i))) (drop people (add1 i))))))]))
  (backtrack 0 (make-list (length cookies) 0)))