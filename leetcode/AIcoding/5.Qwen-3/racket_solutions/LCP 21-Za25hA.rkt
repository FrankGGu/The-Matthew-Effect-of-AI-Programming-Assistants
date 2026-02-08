#lang racket

(define (is-reachable n edges start end)
  (define graph (make-hash))
  (for ([edge edges])
    (define u (car edge))
    (define v (cadr edge))
    (hash-set! graph u (cons v (hash-ref graph u '())))
    (hash-set! graph v (cons u (hash-ref graph v '()))))

  (define visited (make-hash))
  (define (dfs node)
    (when (not (hash-has-key? visited node))
      (hash-set! visited node #t)
      (for-each dfs (hash-ref graph node))))

  (dfs start)
  (hash-has-key? visited end))

(define (can-win n edges)
  (define (check k)
    (let ([start (add1 k)]
          [end (add1 (- n k))])
      (is-reachable n edges start end)))

  (if (<= n 2)
      #t
      (and (check 0) (check 1))))

(can-win 5 '((1 2) (2 3) (3 4) (4 5)))