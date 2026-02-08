#lang racket

(define (sum-root-to-leaf-numbers root)
  (define (helper node current-sum)
    (if (not node)
        0
        (let ((current-sum (+ (* current-sum 10) (node-val node))))
          (if (and (not (node-left node)) (not (node-right node)))
              current-sum
              (+ (helper (node-left node) current-sum)
                 (helper (node-right node) current-sum))))))
  (helper root 0))

(define (node-val n) (car n))
(define (node-left n) (cadr n))
(define (node-right n) (caddr n))