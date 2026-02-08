#lang racket

(define (reachable-nodes edges max-nodes)
  (define graph (make-hash))
  (for ([edge (in-list edges)])
    (let ([u (car edge)]
          [v (cadr edge)]
          [w (caddr edge)])
      (hash-set! graph u (cons (cons v w) (hash-ref graph u '())))
      (hash-set! graph v (cons (cons u w) (hash-ref graph v '())))))

  (define pq (list (cons 0 0)))
  (define visited (make-hash))

  (define (heap? lst) (not (null? lst)))
  (define (heap-top lst) (car lst))
  (define (heap-pop lst) (cdr lst))
  (define (heap-push lst val) (sort (cons val lst) (lambda (a b) (< (car a) (car b)))))

  (let loop ()
    (when (heap? pq)
      (let* ([current (heap-top pq)]
             [dist (car current)]
             [node (cdr current)])
        (set! pq (heap-pop pq))
        (when (or (not (hash-has-key? visited node)) (> (hash-ref visited node) dist))
          (hash-set! visited node dist)
          (for ([neighbor (in-list (hash-ref graph node '()))])
            (let ([next-node (car neighbor)]
                  [weight (cdr neighbor)])
              (heap-push pq (cons (+ dist weight) next-node)))))
        (loop))))

  (for/sum ([k (in-hash-keys visited)]) 1))