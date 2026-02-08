#lang racket

(define (subtree-sum root)
  (if (not root)
      0
      (+ (car root) (subtree-sum (cadr root)) (subtree-sum (caddr root)))))

(define (most-frequent-subtree-sum root)
  (define freq (make-hash))
  (define max-count 0)
  (define result '())

  (define (dfs node)
    (when node
      (define sum (subtree-sum node))
      (hash-set! freq sum (+ (hash-ref freq sum 0) 1))
      (when (> (hash-ref freq sum) max-count)
        (set! max-count (hash-ref freq sum))
        (set! result (list sum)))
      (when (= (hash-ref freq sum) max-count)
        (set! result (cons sum result)))
      (dfs (cadr node))
      (dfs (caddr node))))

  (dfs root)
  (reverse result))