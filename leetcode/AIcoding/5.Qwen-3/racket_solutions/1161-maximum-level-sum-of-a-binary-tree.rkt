#lang racket

(define (max-level-sum root)
  (define (bfs)
    (define (loop queue level-sums)
      (if (null? queue)
          (apply max level-sums)
          (let* ([current (car queue)]
                 [left (and current (node-left current))]
                 [right (and current (node-right current))]
                 [next-queue (append (filter values (list left right)) (cdr queue))]
                 [sum (+ (node-val current) (if (null? level-sums) 0 (car level-sums)))])
            (loop next-queue (cons sum (cdr level-sums))))))
    (loop (list root) '()))
  (bfs))