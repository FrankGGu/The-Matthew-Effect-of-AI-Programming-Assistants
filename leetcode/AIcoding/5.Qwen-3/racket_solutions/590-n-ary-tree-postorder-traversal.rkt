#lang racket

(define (postorder root)
  (define (traverse node result)
    (if (not node)
        result
        (begin
          (for-each (lambda (child) (traverse child result)) (node-children node))
          (set! result (append result (list (node-val node))))
          result)))
  (traverse root '()))