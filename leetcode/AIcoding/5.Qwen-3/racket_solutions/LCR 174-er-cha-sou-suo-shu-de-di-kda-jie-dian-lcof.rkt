#lang racket

(define (search-bst root val)
  (cond [(null? root) #f]
        [(= (car root) val) #t]
        [(< val (car root)) (search-bst (cadr root) val)]
        [else (search-bst (caddr root) val)]))