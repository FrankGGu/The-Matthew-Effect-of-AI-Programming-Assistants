#lang racket

(define (min-time n edges start-node)
  (define tree (make-hash))
  (for-each
   (lambda (edge)
     (let ([u (car edge)]
           [v (cadr edge)])
       (hash-set! tree u (cons v (hash-ref tree u '())))
       (hash-set! tree v (cons u (hash-ref tree v '())))))
   edges)

  (define (dfs node parent)
    (let ([time 0])
      (for-each
       (lambda (child)
         (when (not (= child parent))
           (let ([child-time (dfs child node)])
             (when (> child-time 0)
               (set! time (+ time (+ child-time 2)))))))
       (hash-ref tree node '()))
      time))

  (dfs start-node -1))