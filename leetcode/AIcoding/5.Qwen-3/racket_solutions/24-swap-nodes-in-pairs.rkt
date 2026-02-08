#lang racket

(define (swap-nodes-in-pairs head)
  (if (or (null? head) (null? (cdr head)))
      head
      (let ((next (cddr head)))
        (set-cdr! head (swap-nodes-in-pairs next))
        (let ((new-head (car head)))
          (set-car! head (cadr head))
          (set-cdr! (cdr head) new-head)
          head))))