#lang racket

(define (bst-to-greater-tree root)
  (define-values (current-sum)
    (let ([sum 0])
      (lambda ()
        (set! sum (+ sum (if (pair? root) (car root) 0)))
        sum)))
  (define (traverse node)
    (cond
      [(null? node) null]
      [else
       (traverse (caddr node))
       (set! (car node) (- (car node) (current-sum)))
       (traverse (cadr node))]))
  (traverse root)
  root)