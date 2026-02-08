#lang racket

(define (maximum-star-sum edges k)
  (define graph (make-hash))
  (for-each
   (lambda (edge)
     (let ([u (car edge)]
           [v (cadr edge)]
           [w (caddr edge)])
       (hash-set! graph u (cons w (hash-ref graph u '())))
       (hash-set! graph v (cons w (hash-ref graph v '())))))
   edges)
  (define (sort-desc lst)
    (sort lst >))
  (define max-sum 0)
  (for-each
   (lambda (node)
     (let* ([neighbors (sort-desc (hash-ref graph node '()))]
            [sum (apply + (take neighbors k))])
       (when (> sum max-sum)
         (set! max-sum sum))))
   (hash-keys graph))
  max-sum)