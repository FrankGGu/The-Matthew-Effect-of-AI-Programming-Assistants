#lang racket

(define (max-min-price-sum prices)
  (define (dfs node parent)
    (let loop ([node node] [parent parent] [sum 0])
      (if (null? node)
          sum
          (let* ([current (car node)]
                 [left (cadr node)]
                 [right (caddr node)])
            (let ([new-sum (+ sum current)])
              (if (and (null? left) (null? right))
                  new-sum
                  (let ([left-sum (if (null? left) 0 (loop left node new-sum))]
                        [right-sum (if (null? right) 0 (loop right node new-sum))])
                    (max left-sum right-sum)))))))
  (define (dfs2 node parent)
    (let loop ([node node] [parent parent] [sum 0])
      (if (null? node)
          sum
          (let* ([current (car node)]
                 [left (cadr node)]
                 [right (caddr node)])
            (let ([new-sum (+ sum current)])
              (if (and (null? left) (null? right))
                  new-sum
                  (let ([left-sum (if (null? left) 0 (loop left node new-sum))]
                        [right-sum (if (null? right) 0 (loop right node new-sum))])
                    (min left-sum right-sum)))))))
  (- (dfs (car prices) #f) (dfs2 (car prices) #f)))