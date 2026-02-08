#lang racket

(define (max-sum-of-weights-after-edge-removals n edges)
  (define graph (make-hash))
  (for ([e edges])
    (define u (car e))
    (define v (cadr e))
    (define w (caddr e))
    (hash-set! graph u (cons (cons v w) (hash-ref graph u '())))
    (hash-set! graph v (cons (cons u w) (hash-ref graph v '()))))

  (define (dfs node parent)
    (define total 0)
    (for ([neighbor (hash-ref graph node)])
      (define next-node (car neighbor))
      (define weight (cdr neighbor))
      (when (not (= next-node parent))
        (define child-sum (dfs next-node node))
        (set! total (+ total weight child-sum))))
    total)

  (dfs 0 -1))