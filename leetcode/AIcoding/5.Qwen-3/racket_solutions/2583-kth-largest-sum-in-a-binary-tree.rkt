#lang racket

(define (kth-largest-sum root k)
  (define (bfs)
    (let loop ([queue (list root)] [sums '()])
      (if (null? queue)
          sums
          (let* ([size (length queue)]
                 [sum (apply + (map (lambda (node) (if node (node-val node) 0)) queue))]
                 [new-queue (append*
                             (map (lambda (node)
                                    (filter identity (list (if node (node-left node) #f)
                                                           (if node (node-right node) #f))))
                                  queue))])
            (loop new-queue (cons sum sums))))))

  (define sums (bfs))
  (list-ref (sort sums >) (sub1 k)))