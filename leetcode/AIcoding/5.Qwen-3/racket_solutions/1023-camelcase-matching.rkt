#lang racket

(define (camelcase-matching queries pattern)
  (define (match query)
    (define (loop q p)
      (cond [(and (null? q) (null? p)) #t]
            [(null? p) #f]
            [(null? q) #f]
            [(char=? (car q) (car p)) (loop (cdr q) (cdr p))]
            [(char-upper-case? (car q)) #f]
            [else (loop (cdr q) p)]))
    (loop (string->list query) (string->list pattern)))
  (map match queries))