#lang racket

(define (max-path-quality n edges max-time)
  (define graph (make-hash))
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (define w (caddr edge))
              (hash-set! graph u (cons (list v w) (hash-ref graph u '())))
              (hash-set! graph v (cons (list u w) (hash-ref graph v '()))))
            edges)

  (define values (make-vector n 0))
  (for-each (lambda (i) (vector-set! values i (list-ref (list-ref edges 0) 2))) (range n))

  (define max-qual 0)

  (define (dfs node time path-vals)
    (when (<= time max-time)
      (set! max-qual (max max-qual (apply + path-vals)))
      (for-each (lambda (neighbor-w)
                  (define neighbor (car neighbor-w))
                  (define weight (cadr neighbor-w))
                  (when (<= (+ time weight) max-time)
                    (dfs neighbor (+ time weight) (append path-vals (list (vector-ref values neighbor)))))) 
                (hash-ref graph node '())))

  (dfs 0 0 (list (vector-ref values 0)))
  max-qual)