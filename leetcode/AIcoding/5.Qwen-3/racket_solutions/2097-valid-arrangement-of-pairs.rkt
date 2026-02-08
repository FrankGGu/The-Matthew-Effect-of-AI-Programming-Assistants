#lang racket

(define (valid-arrangement-of-pairs pairs)
  (define graph (make-hash))
  (define in-degree (make-hash))
  (define out-degree (make-hash))
  (for ([p pairs])
    (define u (car p))
    (define v (cadr p))
    (hash-set! graph u (cons v (hash-ref graph u '())))
    (hash-set! out-degree u (+ 1 (hash-ref out-degree u 0)))
    (hash-set! in-degree v (+ 1 (hash-ref in-degree v 0))))

  (define (find-start-node)
    (for/first ([node (in-hash-keys graph)]
                #:when (= (hash-ref out-degree node 0) (+ 1 (hash-ref in-degree node 0))))
      node)
    (or (and (hash-has-key? graph (car pairs)) (car pairs))
        (car (hash-keys graph))))

  (define (dfs u result)
    (let loop ()
      (when (and (hash-has-key? graph u) (> (length (hash-ref graph u)) 0))
        (define v (caar (hash-ref graph u)))
        (set! (hash-ref graph u) (cdar (hash-ref graph u)))
        (dfs v result)
        (set! result (cons (cons u v) result))))
    result)

  (define start (find-start-node))
  (define result (dfs start '()))
  (reverse result))