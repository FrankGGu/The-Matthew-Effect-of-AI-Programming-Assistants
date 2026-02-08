#lang racket

(define (kth-ancestor-of-a-tree-node root k)
  (define (build-parents n)
    (let ([parents (make-vector n -1)])
      (define (dfs node depth)
        (when node
          (vector-set! parents (car node) depth)
          (for-each dfs (cdr node) (map add1 (make-list (length (cdr node)) depth)))))
      (dfs root 0)
      parents))

  (define (get-kth-ancestor node k)
    (let loop ([node node] [k k])
      (if (or (= k 0) (< node 0)) node
          (loop (vector-ref (build-parents (vector-length root)) node) (sub1 k)))))

  (get-kth-ancestor 0 k))