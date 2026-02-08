#lang racket

(define (TreeNode val left right)
  (list 'TreeNode val left right))

(define (serialize root)
  (if (null? root)
      (list "null")
      (append (list (car root))
              (serialize (cadr root))
              (serialize (caddr root)))))

(define (deserialize data)
  (define (helper lst)
    (if (null? lst)
        (values #f '())
        (let ((val (car lst)))
          (if (equal? val "null")
              (values #f (cdr lst))
              (let-values (((left rest) (helper (cdr lst))))
                (let-values (((right rest) (helper rest)))
                  (values (TreeNode val left right) rest)))))))
  (car (helper data)))