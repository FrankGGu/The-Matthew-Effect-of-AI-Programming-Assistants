#lang racket

(define (create-components-with-same-value root)
  (define (dfs node)
    (if (not node)
        (values 0 0)
        (let* ([left-sum (car (dfs (node-left node)))]
               [left-count (cadr (dfs (node-left node)))]
               [right-sum (car (dfs (node-right node)))]
               [right-count (cadr (dfs (node-right node)))]
               [total-sum (+ (node-val node) left-sum right-sum)]
               [total-count (+ 1 left-count right-count)]
               [current-avg (/ total-sum total-count)])
          (values total-sum total-count))))

  (define (count-components node)
    (if (not node)
        0
        (let* ([left-sum (car (dfs (node-left node)))]
               [left-count (cadr (dfs (node-left node)))]
               [right-sum (car (dfs (node-right node)))]
               [right-count (cadr (dfs (node-right node)))]
               [total-sum (+ (node-val node) left-sum right-sum)]
               [total-count (+ 1 left-count right-count)]
               [current-avg (/ total-sum total-count)])
          (+ (if (= (node-val node) current-avg) 1 0)
             (count-components (node-left node))
             (count-components (node-right node))))))

  (count-components root))