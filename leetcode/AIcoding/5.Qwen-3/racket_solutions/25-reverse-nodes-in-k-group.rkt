#lang racket

(define (reverse-k-group head k)
  (define (reverse a b)
    (let loop ([prev null] [curr a] [next null])
      (if (null? curr)
          (values prev b)
          (begin
            (set! next (cdr curr))
            (set! (cdr curr) prev)
            (loop curr next next)))))

  (define (get-length node)
    (if (null? node)
        0
        (+ 1 (get-length (cdr node)))))

  (define (helper node)
    (let ((len (get-length node)))
      (if (< len k)
          node
          (let-values (((new-head new-tail) (reverse node (list-ref (take node k) (- k 1))))
                       ((rest-head rest-tail) (helper (list-ref (take node k) (- k 1))))
            (set! (cdr new-tail) rest-head)
            new-head))))

  (helper head))