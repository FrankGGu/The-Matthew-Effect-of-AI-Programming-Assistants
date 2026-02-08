#lang racket

(define (is-symmetric root)
  (define (is-palindrome lst)
    (equal? lst (reverse lst)))
  (define (traverse node lst)
    (if (not node)
        (cons '() lst)
        (append (traverse (node-left node) (cons (node-val node) lst))
                (traverse (node-right node) (cons (node-val node) lst)))))
  (is-palindrome (traverse root '())))

(define-struct node (val left right))