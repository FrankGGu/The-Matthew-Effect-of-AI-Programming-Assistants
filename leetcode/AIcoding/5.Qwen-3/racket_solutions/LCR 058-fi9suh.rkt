#lang racket

(define-struct event (start end))

(define (new-calendar)
  '())

(define (book calendar start end)
  (define (helper events)
    (cond [(null? events) #t]
          [(or (<= end (event-start (car events)))
               (>= start (event-end (car events))))
           (helper (cdr events))]
          [else #f]))
  (if (helper calendar)
      (cons (make-event start end) calendar)
      calendar))