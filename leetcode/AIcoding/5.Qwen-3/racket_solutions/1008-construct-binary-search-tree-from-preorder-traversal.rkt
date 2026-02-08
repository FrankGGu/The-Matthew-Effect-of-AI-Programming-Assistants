#lang racket

(define (bst-from-preorder preorder)
  (define (build l r)
    (if (>= l r)
        #f
        (let* ((val (list-ref preorder l))
               (root (cons val '()))
               (i (for/first ([j (in-range (add1 l) r)]
                              #:when (> (list-ref preorder j) val))
                    j)))
          (if i
              (begin
                (set-cdr! root (build (add1 l) i))
                (set-cdr! (cdr root) (build (add1 i) r))
                root)
              (begin
                (set-cdr! root (build (add1 l) r))
                root)))))
  (build 0 (length preorder)))