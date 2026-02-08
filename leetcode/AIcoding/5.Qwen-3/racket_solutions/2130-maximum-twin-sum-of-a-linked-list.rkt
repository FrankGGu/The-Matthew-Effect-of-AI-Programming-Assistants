#lang racket

(define (pair-sum head)
  (define (reverse-list node)
    (let loop ([prev #f] [curr node])
      (if (not curr) prev
          (loop curr (cdr curr)))))

  (define (get-middle node)
    (let loop ([slow node] [fast node])
      (if (or (not fast) (not (cdr fast))) slow
          (loop (cdr slow) (cddr fast)))))

  (define (sum-pairs head1 head2)
    (if (not head1) 0
        (max (+ (car head1) (car head2))
             (sum-pairs (cdr head1) (cdr head2)))))

  (let* ([mid (get-middle head)]
         [second-half (reverse-list mid)])
    (sum-pairs head second-half)))