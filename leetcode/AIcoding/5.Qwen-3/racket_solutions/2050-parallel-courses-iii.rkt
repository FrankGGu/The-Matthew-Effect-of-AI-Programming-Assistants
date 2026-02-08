#lang racket

(define (parallel-courses-iii n dependencies)
  (define graph (make-hash))
  (define in-degree (make-vector n 0))
  (for ([dep dependencies])
    (define u (car dep))
    (define v (cadr dep))
    (hash-set! graph u (cons v (hash-ref graph u '())))
    (vector-set! in-degree v (+ (vector-ref in-degree v) 1)))

  (define q (queue))
  (for ([i (in-range n)])
    (when (= (vector-ref in-degree i) 0)
      (enqueue! q i)))

  (define dp (make-vector n 0))
  (define max-time 0)

  (while (not (queue-empty? q))
    (define u (dequeue! q))
    (set! max-time (max max-time (vector-ref dp u)))
    (for ([v (hash-ref graph u '())])
      (vector-set! dp v (max (vector-ref dp v) (+ (vector-ref dp u) 1)))
      (vector-set! in-degree v (- (vector-ref in-degree v) 1))
      (when (= (vector-ref in-degree v) 0)
        (enqueue! q v)))
  )
  max-time)