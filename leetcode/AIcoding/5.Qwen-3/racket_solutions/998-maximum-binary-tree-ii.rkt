#lang racket

(define (construct-max-tree nums)
  (define (build nums start end)
    (cond [(> start end) #f]
          [else
           (define max-val (apply max (take nums (- end start +1))))
           (define index (for/first ([i (in-range start (+ end 1))]
                                    #:when (= (list-ref nums i) max-val))
                             i)
           (make-node max-val (build nums start (- index 1)) (build nums (+ index 1) end))]))
  (build nums 0 (- (length nums) 1)))

(define (make-node val left right)
  (cons val (cons left right)))

(define (node-val node) (car node))
(define (node-left node) (cadr node))
(define (node-right node) (caddr node))

(define (maximum-binary-tree nums)
  (construct-max-tree nums))