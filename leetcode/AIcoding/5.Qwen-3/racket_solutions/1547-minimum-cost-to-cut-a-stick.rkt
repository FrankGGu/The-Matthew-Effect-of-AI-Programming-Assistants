#lang racket

(define (min-cost-to-cut-stick n cuts)
  (define cuts (sort cuts <))
  (define (helper left right)
    (cond [(>= left right) 0]
          [else
           (let ([cost 0])
             (for-each (lambda (cut)
                         (when (and (> cut left) (< cut right))
                           (set! cost (+ cost (+ (helper left cut) (helper cut right))))))
                       cuts)
             cost)]))
  (helper 0 n))