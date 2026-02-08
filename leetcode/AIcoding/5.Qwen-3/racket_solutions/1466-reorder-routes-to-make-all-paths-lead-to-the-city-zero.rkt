#lang racket

(define (min-changes n connections)
  (define graph (make-hash))
  (for ([conn connections])
    (define u (car conn))
    (define v (cadr conn))
    (hash-update! graph u (λ (lst) (cons (cons v #t) lst)))
    (hash-update! graph v (λ (lst) (cons (cons u #f) lst))))

  (define visited (make-hash))
  (define (dfs node)
    (define res 0)
    (hash-set! visited node #t)
    (for ([neighbor (hash-ref graph node)])
      (define next-node (car neighbor))
      (define is-original (cdr neighbor))
      (when (not (hash-has-key? visited next-node))
        (set! res (+ res (if is-original 1 0) (dfs next-node)))))
    res)

  (dfs 0))

(define (main)
  (define input (current-input-port))
  (define n (read input))
  (define connections (read input))
  (display (min-changes n connections)))

(main)