#lang racket

(define (min-halls intervals)
  (define sorted-intervals (sort intervals (lambda (a b) (< (car a) (car b)))))
  (define (helper intervals heap)
    (cond [(null? intervals) (length heap)]
          [else
           (let* ([current (car intervals)]
                  [start (car current)]
                  [end (cadr current)])
             (if (and (not (null? heap)) (<= (heap-first heap) start))
                 (begin
                   (heap-pop! heap)
                   (heap-add! heap end)
                   (helper (cdr intervals) heap))
                 (begin
                   (heap-add! heap end)
                   (helper (cdr intervals) heap))))]))
  (helper sorted-intervals (make-heap <)))

(define (main)
  (define input (read))
  (display (min-halls input)))

(main)