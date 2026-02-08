#lang racket

(define (maximum-score-after-applying-operations n edges)
  (define graph (make-hash))
  (for-each (lambda (e)
              (let ([u (car e)] [v (cadr e)])
                (hash-set! graph u (cons v (hash-ref graph u '())))
                (hash-set! graph v (cons u (hash-ref graph v '())))))
            edges)

  (define (dfs node parent)
    (define sum (vector-ref (vector 0) 0))
    (for-each (lambda (child)
                (when (not (= child parent))
                  (set! sum (+ sum (dfs child node)))))
              (hash-ref graph node '()))
    sum)

  (define total (dfs 0 -1))

  (define max-score 0)
  (define (dfs2 node parent)
    (define current-sum 0)
    (for-each (lambda (child)
                (when (not (= child parent))
                  (set! current-sum (+ current-sum (dfs2 child node)))))
              (hash-ref graph node '()))
    (set! max-score (max max-score (* (- total current-sum) current-sum)))
    current-sum)

  (dfs2 0 -1)
  max-score)