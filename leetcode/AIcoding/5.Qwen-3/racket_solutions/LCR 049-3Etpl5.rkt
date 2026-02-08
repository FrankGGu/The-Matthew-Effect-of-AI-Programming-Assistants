#lang racket

(define (sum-numbers root)
  (define (helper node path)
    (if (not node)
        0
        (let ([new-path (* path 10)]
              [val (car node)])
          (if (and (null? (cadr node)) (null? (caddr node)))
              (+ new-path val)
              (+ (helper (cadr node) (+ new-path val))
                 (helper (caddr node) (+ new-path val))))))
  (helper root 0))