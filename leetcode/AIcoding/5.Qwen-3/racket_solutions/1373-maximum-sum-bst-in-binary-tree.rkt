#lang racket

(define (max-sum-bst root)
  (define (helper node)
    (if (not node)
        (list 0 #t 0 0)
        (let* ([left (helper (car node))]
               [right (helper (cadr node))]
               [is-bst? (and (cadr left) (cadr right) (> (caddr left) (cadar node)) (< (caddr right) (cadar node)))]
               [sum (if is-bst?
                        (+ (caddr left) (caddr right) (cadar node))
                        0)]
               [max-val (if is-bst?
                            (max (caddr left) (caddr right) (cadar node))
                            (max (caddr left) (caddr right)))
               ]
               [min-val (if is-bst?
                            (min (caddr left) (caddr right) (cadar node))
                            (min (caddr left) (caddr right)))])
          (list sum is-bst? min-val max-val))))

  (define (get-max-sum lst)
    (if (null? lst)
        0
        (max (caar lst) (get-max-sum (cdr lst))))

  (define result (helper root))
  (if (cadr result)
      (carr result)
      0))