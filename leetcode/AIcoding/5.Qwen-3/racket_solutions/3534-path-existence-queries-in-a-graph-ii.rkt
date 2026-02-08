#lang racket

(define (make-adj-list n edges)
  (define adj (make-vector n '()))
  (for-each
   (lambda (e)
     (let ([u (car e)] [v (cadr e)])
       (vector-set! adj u (cons v (vector-ref adj u)))
       (vector-set! adj v (cons u (vector-ref adj v)))))
   edges)
  adj)

(define (bfs adj start end)
  (define visited (make-vector (vector-length adj) #f))
  (define q (queue start))
  (vector-set! visited start #t)
  (let loop ()
    (when (not (queue-empty? q))
      (let ([current (queue-front q)])
        (if (= current end)
            #t
            (begin
              (for-each
               (lambda (neighbor)
                 (when (not (vector-ref visited neighbor))
                   (vector-set! visited neighbor #t)
                   (queue-enqueue! q neighbor)))
               (vector-ref adj current))
              (queue-dequeue! q)
              (loop))))))
  #f)

(define (path-existence-queries n edges queries)
  (define adj (make-adj-list n edges))
  (map (lambda (q) (bfs adj (car q) (cadr q))) queries))