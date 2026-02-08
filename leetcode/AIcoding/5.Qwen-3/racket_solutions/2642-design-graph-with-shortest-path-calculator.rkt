#lang racket

(define-struct edge (to weight))
(define-struct graph (adj))

(define (make-graph n edges)
  (let ([adj (make-vector n '())])
    (for-each
     (lambda (e)
       (vector-set! adj (car e) (cons (edge (cadr e) (caddr e)) (vector-ref adj (car e)))))
     edges)
    (graph adj)))

(define (shortest-path g start end)
  (define adj (graph-adj g))
  (define n (vector-length adj))
  (define dist (make-vector n +inf.0))
  (vector-set! dist start 0)
  (define pq (list (cons 0 start)))
  (define (relax u v w)
    (when (< (+ (vector-ref dist u) w) (vector-ref dist v))
      (vector-set! dist v (+ (vector-ref dist u) w))
      (set! pq (cons (cons (vector-ref dist v) v) pq))))
  (let loop ()
    (when (not (null? pq))
      (let* ([min-pair (apply min-key (lambda (p) (car p)) pq)]
             [d (car min-pair)]
             [u (cdr min-pair)])
        (set! pq (remove min-pair pq))
        (when (not (= d (vector-ref dist u)))
          (loop))
        (for-each
         (lambda (e)
           (relax u (edge-to e) (edge-weight e)))
         (vector-ref adj u))
        (loop))))
  (if (infinite? (vector-ref dist end)) -1 (vector-ref dist end)))