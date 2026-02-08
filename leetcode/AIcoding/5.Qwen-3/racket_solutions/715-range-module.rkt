#lang racket

(define (make-range-module)
  (let ((intervals '()))
    (define (insert new-start new-end)
      (define (merge lst)
        (cond [(null? lst) '()]
              [(null? (cdr lst)) lst]
              [else
               (let* ([current (car lst)]
                      [next (cadr lst)])
                 (if (<= (cdr current) (car next))
                     (merge (cons (cons (car current) (max (cdr current) (cdr next))) (cddr lst)))
                     (cons current (merge (cdr lst)))))]))
      (set! intervals (merge (cons (cons new-start new-end) intervals))))
    (define (query start end)
      (for/first ([interval intervals]
                  #:when (and (<= start (cdr interval)) (<= (car interval) end)))
        #t)
      #f)
    (define (remove start end)
      (define (filter lst)
        (cond [(null? lst) '()]
              [else
               (let ([current (car lst)])
                 (if (or (> (cdr current) end) (< (car current) start))
                     (cons current (filter (cdr lst)))
                     (let ([new-interval (filter (cdr lst))]
                           [s (max (car current) start)]
                           [e (min (cdr current) end)])
                       (if (> s e)
                           new-interval
                           (append (if (> (car current) start) (list (cons (car current) (1- s))) '())
                                   new-interval)))))]))
      (set! intervals (filter intervals)))
    (lambda (op start end)
      (case op
        ['insert (insert start end)]
        ['query (query start end)]
        ['remove (remove start end)]))))