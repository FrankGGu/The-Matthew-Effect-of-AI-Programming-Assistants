#lang racket

(define (num-ways n edges)
  (define adj (make-hash))
  (for-each (lambda (e)
              (let ([u (car e)] [v (cadr e)])
                (hash-set! adj u (cons v (hash-ref adj u '())))
                (hash-set! adj v (cons u (hash-ref adj v '())))))
            edges)

  (define (dfs node parent)
    (let ([children (filter (lambda (x) (not (= x parent))) (hash-ref adj node))])
      (if (null? children)
          1
          (let ([res 1])
            (for-each (lambda (child)
                        (set! res (* res (dfs child node))))
                      children)
            res))))

  (dfs 1 -1))