#lang racket

(define (dfs node parent graph)
  (define (helper current depth)
    (if (null? (filter (lambda (x) (not (= x parent))) (hash-ref graph current)))
        (list depth)
        (map (lambda (neighbor)
               (if (= neighbor parent)
                   0
                   (helper neighbor current)))
             (hash-ref graph current))))
  (apply + (map (lambda (d) (expt 2 d)) (helper node -1))))

(define (count-coin n edges)
  (define graph (make-hash))
  (for ([i (in-range n)])
    (hash-set! graph i '()))
  (for ([edge (in-list edges)])
    (define u (car edge))
    (define v (cadr edge))
    (hash-set! graph u (cons v (hash-ref graph u)))
    (hash-set! graph v (cons u (hash-ref graph v))))
  (dfs 0 -1 graph))