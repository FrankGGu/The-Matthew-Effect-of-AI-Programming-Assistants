#lang racket

(define (find-consecutive-integers data-stream)
  (define (helper stream seen result)
    (cond [(null? stream) result]
          [else
           (let ([num (car stream)])
             (if (set-member? seen num)
                 (helper (cdr stream) seen result)
                 (let ([new-seen (set-add seen num)]
                       [new-result (cons num result)])
                   (helper (cdr stream) new-seen new-result))))]))
  (reverse (helper data-stream (set) '())))