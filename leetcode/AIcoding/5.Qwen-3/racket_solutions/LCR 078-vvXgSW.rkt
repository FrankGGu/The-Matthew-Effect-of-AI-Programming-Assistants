#lang racket

(define (merge-k-sorted-lists lists)
  (define (merge-two l1 l2)
    (cond [(null? l1) l2]
          [(null? l2) l1]
          [(<= (car l1) (car l2))
           (cons (car l1) (merge-two (cdr l1) l2))]
          [else (cons (car l2) (merge-two l1 (cdr l2)))]))

  (define (merge-helper lsts)
    (if (null? lsts)
        null
        (if (null? (cdr lsts))
            (car lsts)
            (merge-two (car lsts) (merge-helper (cdr lsts)))))

  (merge-helper lists))