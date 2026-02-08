#lang racket

(define-struct node (val next) #:mutable)

(define (reorder-list head)
  (define (reverse-list head)
    (let loop ([prev #f] [curr head])
      (if (not curr)
          prev
          (let ([next (node-next curr)])
            (set-node-next! curr prev)
            (loop curr next)))))

  (define (get-middle head)
    (let loop ([slow head] [fast head])
      (if (or (not fast) (not (node-next fast)))
          slow
          (loop (node-next slow) (node-next (node-next fast))))))

  (define (merge-list a b)
    (let loop ([a a] [b b] [prev #f])
      (if (not a)
          prev
          (begin
            (set-node-next! a b)
            (loop (node-next b) (node-next a) a)))))

  (when (or (not head) (not (node-next head)))
    (void))

  (define mid (get-middle head))
  (define right (reverse-list (node-next mid)))
  (set-node-next! mid #f)
  (merge-list head right))