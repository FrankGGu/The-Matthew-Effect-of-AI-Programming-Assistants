#lang racket

(define (max-profit-from-valid-topological-order graph prices)
  (define n (vector-length prices))
  (define in-degree (make-vector n 0))
  (define adj (make-vector n '()))
  (for ([u (in-range n)])
    (for ([v (vector-ref graph u)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! in-degree v (+ (vector-ref in-degree v) 1))))

  (define q (queue))
  (for ([i (in-range n)])
    (when (= (vector-ref in-degree i) 0)
      (queue-add! q i)))

  (define profit (make-vector n 0))
  (for ([i (in-range n)])
    (vector-set! profit i (vector-ref prices i)))

  (define result 0)
  (define visited (make-vector n #f))

  (define (topo-sort)
    (let loop ()
      (when (not (queue-empty? q))
        (define u (queue-remove! q))
        (vector-set! visited u #t)
        (set! result (max result (vector-ref profit u)))
        (for ([v (vector-ref adj u)])
          (vector-set! profit v (max (vector-ref profit v) (+ (vector-ref profit u) (vector-ref prices v))))
          (vector-set! in-degree v (- (vector-ref in-degree v) 1))
          (when (= (vector-ref in-degree v) 0)
            (queue-add! q v)))
        (loop))))

  (topo-sort)
  result)