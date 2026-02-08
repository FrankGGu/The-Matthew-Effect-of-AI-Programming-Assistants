#lang racket

(define (is-symmetric root)
  (define (is-same left right)
    (cond [(and (not left) (not right)) #t]
          [(or (not left) (not right)) #f]
          [else (and (= (car left) (car right))
                     (is-same (cadr left) (caddr right))
                     (is-same (caddr left) (cadr right)))]))
  (if (not root)
      #t
      (is-same (cdr root) (cdr root))))