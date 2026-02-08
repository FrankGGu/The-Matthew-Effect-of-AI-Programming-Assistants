#lang racket

(define (is-odd? x) (= (modulo x 2) 1))

(define (max-groups root)
  (define (bfs node)
    (define levels (make-hash))
    (define queue (list node))
    (define (loop q level)
      (cond [(null? q) #t]
            [else
             (for-each (lambda (n)
                         (when (hash-has-key? levels (car n))
                           (if (is-odd? level)
                               (when (is-odd? (hash-ref levels (car n)))
                                 (error "Not a bipartite graph"))
                               (when (not (is-odd? (hash-ref levels (car n))))
                                 (error "Not a bipartite graph"))))
                         (when (not (hash-has-key? levels (car n)))
                           (hash-set! levels (car n) level)
                           (set! q (append q (cdr n)))))
                       q)
             (loop q (+ level 1))]))
    (if (loop queue 0)
        (apply max (hash-values levels))
        -1))
  (bfs root))