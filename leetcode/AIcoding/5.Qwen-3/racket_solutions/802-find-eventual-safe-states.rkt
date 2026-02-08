#lang racket

(define/contract (eventual-safe-states graph)
  (-> (listof (listof exact-integer?)) (listof exact-integer?))
  (define n (length graph))
  (define color (make-vector n 0))
  (define result '())

  (define (dfs u)
    (cond [(= (vector-ref color u) 2) #t]
          [(= (vector-ref color u) 1) #f]
          [else
           (vector-set! color u 1)
           (for/and ([v (in-list (list-ref graph u))])
             (dfs v))
           (vector-set! color u 2)
           #t]))

  (for ([i (in-range n)])
    (when (dfs i)
      (set! result (cons i result))))

  (reverse result))