#lang racket

(define (evaluate-tree root)
  (if (not (pair? root))
      root
      (let ([val (car root)]
            [left (cadr root)]
            [right (caddr root)])
        (if (= val 2)
            (or (evaluate-tree left) (evaluate-tree right))
            (and (evaluate-tree left) (evaluate-tree right))))))