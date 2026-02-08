#lang racket

(define (make-magic-dictionary)
  (let ((words '()))
    (lambda (op . args)
      (cond
        [(equal? op "buildDict") 
         (set! words (car args))]
        [(equal? op "search")
         (let ((target (car args)))
           (for/or ([word words])
             (and (= (string-length word) (string-length target))
                   (for/and ([i (in-range (string-length target))])
                     (or (char=? (string-ref word i) (string-ref target i))
                         (and (char=? (string-ref word i) #\*) (char=? (string-ref target i) #\*)))))))]))))

(define magic-dictionary (make-magic-dictionary))

(define (build-dict dict)
  (magic-dictionary "buildDict" dict))

(define (search target)
  (magic-dictionary "search" target))