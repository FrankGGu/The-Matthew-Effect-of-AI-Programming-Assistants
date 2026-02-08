#lang racket

(define (largest-outlier nums)
  (define freq (make-hash))
  (for-each (lambda (n) (hash-set! freq n (+ (hash-ref freq n 0) 1))) nums)
  (define max-outlier -inf.0)
  (for-each
   (lambda (n)
     (when (and (> (hash-ref freq n 0) 0)
                (>= (hash-ref freq (- (+ (apply + (remove n nums)) n)) 0) 1))
       (set! max-outlier (max max-outlier n))))
   nums)
  max-outlier)

(define (remove x lst)
  (cond ((null? lst) '())
        ((equal? x (car lst)) (remove x (cdr lst)))
        (else (cons (car lst) (remove x (cdr lst))))))