#lang racket

(define (min-score-edges n edges)
  (define graph (make-hash))
  (for-each (lambda (e)
              (let ([u (car e)] [v (cadr e)] [w (caddr e)])
                (hash-set! graph u (cons (cons v w) (hash-ref graph u '())))
                (hash-set! graph v (cons (cons u w) (hash-ref graph v '())))))
            edges)

  (define visited (make-hash))
  (define min-score 1000000)

  (define (dfs node)
    (when (not (hash-has-key? visited node))
      (hash-set! visited node #t)
      (for-each (lambda (neighbor)
                  (let ([n-node (car neighbor)] [weight (cdr neighbor)])
                    (set! min-score (min min-score weight))
                    (dfs n-node)))
                (hash-ref graph node))))

  (dfs 1)
  min-score)

(define (main)
  (define input (current-input-port))
  (define n (read input))
  (define edges (read input))
  (display (min-score-edges n edges)))

(main)