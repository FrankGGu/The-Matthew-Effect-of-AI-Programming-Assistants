#lang racket

(define (flip-btree-to-match-preorder root target)
  (define (helper node path)
    (cond
      [(null? node) #t]
      [(not (= (car path) (node-val node))) #f]
      [else
       (let ([new-path (cdr path)])
         (if (null? new-path)
             #t
             (or (helper (node-left node) new-path)
                 (helper (node-right node) new-path)))]))
  (helper root target))

(struct node (val left right) #:mutable)