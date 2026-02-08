#lang racket

(define (min-weighted-subgraph n edges time limit)
  (define graph (make-hash))
  (for-each (lambda (e)
              (let ([u (car e)]
                    [v (cadr e)]
                    [w (caddr e)])
                (hash-set! graph u (cons (cons v w) (hash-ref graph u '())))))
            edges)
  (define (dijkstra start)
    (define dist (make-hash))
    (for-each (lambda (i) (hash-set! dist i +inf.0)) (range 1 (add1 n)))
    (hash-set! dist start 0)
    (define pq (list (cons 0 start)))
    (while (not (null? pq))
      (let* ([current (caar pq)]
             [node (cdar pq)]
             [new-pq (cdr pq)])
        (when (< current (hash-ref dist node))
          (set! new-pq pq)
          (for-each (lambda (neighbor)
                      (let ([nd (car neighbor)]
                            [nw (cdr neighbor)])
                        (when (< (+ current nw) (hash-ref dist nd))
                          (hash-set! dist nd (+ current nw))
                          (set! new-pq (cons (cons (+ current nw) nd) new-pq)))))
                    (hash-ref graph node 0)))
        (set! pq new-pq)))
    dist)
  (let* ([dist-start (dijkstra 1)]
         [dist-end (dijkstra n)]
         [total (hash-ref dist-start n)])
    (if (> total limit) -1
        (let ([min-ans +inf.0])
          (for-each (lambda (i)
                      (when (and (<= (hash-ref dist-start i) limit)
                                 (<= (hash-ref dist-end i) limit))
                        (let ([sum (+ (hash-ref dist-start i) (hash-ref dist-end i))])
                          (when (< sum min-ans)
                            (set! min-ans sum)))))
                    (range 1 (add1 n)))
          (if (= min-ans +inf.0) -1 min-ans)))))