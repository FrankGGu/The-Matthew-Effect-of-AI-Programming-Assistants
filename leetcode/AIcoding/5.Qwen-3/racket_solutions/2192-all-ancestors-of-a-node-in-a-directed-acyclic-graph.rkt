#lang racket

(define (get-ancestors n edges)
  (define graph (make-hash))
  (for ([i (in-range n)])
    (hash-set! graph i '()))
  (for ([edge (in-list edges)])
    (define u (car edge))
    (define v (cadr edge))
    (hash-set! graph v (cons u (hash-ref graph v))))

  (define (dfs node visited)
    (for/fold ([visited visited]) ([neighbor (hash-ref graph node)])
      (if (set-member? visited neighbor)
          visited
          (set-add visited neighbor (dfs neighbor visited)))))

  (for/list ([i (in-range n)])
    (sort (set->list (dfs i (set))) <)))