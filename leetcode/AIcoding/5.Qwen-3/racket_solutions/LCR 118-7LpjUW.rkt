#lang racket

(define (find-connection edges)
  (define parent (make-hash))
  (define (find x)
    (if (equal? (hash-ref parent x) x)
        x
        (find (hash-ref parent x))))
  (define (union x y)
    (let ([root-x (find x)]
          [root-y (find y)])
      (when (not (equal? root-x root-y))
        (hash-set! parent root-y root-x))))
  (for-each (lambda (edge)
              (let ([u (car edge)]
                    [v (cadr edge)])
                (when (not (hash-has-key? parent u))
                  (hash-set! parent u u))
                (when (not (hash-has-key? parent v))
                  (hash-set! parent v v))
                (union u v)))
            edges)
  (for/first ([edge edges]
              #:when (equal? (find (car edge)) (find (cadr edge))))
    edge))