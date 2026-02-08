#lang racket

(define (max-target-nodes edges)
  (define n (length edges))
  (define adj (make-hash))
  (for-each
   (lambda (e)
     (let ([u (car e)] [v (cadr e)])
       (hash-set! adj u (cons v (hash-ref adj u '())))
       (hash-set! adj v (cons u (hash-ref adj v '())))))
   edges)

  (define (bfs start)
    (define visited (make-hash))
    (define queue (list start))
    (hash-set! visited start #t)
    (define count 0)
    (when (hash-has-key? adj start)
      (set! count 1)
      (for-each
       (lambda (neighbor)
         (when (not (hash-has-key? visited neighbor))
           (hash-set! visited neighbor #t)
           (set! count (+ count 1))
           (set! queue (append queue (list neighbor)))))
       (hash-ref adj start)))
    count)

  (define max-count 0)
  (for ([i (in-range n)])
    (define count (bfs i))
    (set! max-count (max max-count count)))
  max-count)