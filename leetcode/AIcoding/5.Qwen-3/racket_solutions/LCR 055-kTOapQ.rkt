#lang racket

(define (make-iterator root)
  (define stack '())
  (define (push-left node)
    (when node
      (set! stack (cons node stack))
      (push-left (node-left node))))
  (push-left root)
  (lambda ()
    (if (null? stack)
        #f
        (let* ((node (car stack))
               (val (node-val node)))
          (set! stack (cdr stack))
          (push-left (node-right node))
          val))))

(define (node-val node) (car node))
(define (node-left node) (cadr node))
(define (node-right node) (caddr node))