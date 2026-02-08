#lang racket

(define (smallest-subsequence s)
  (define (helper s stack)
    (cond [(null? s) stack]
          [(member (car s) stack) (helper (cdr s) stack)]
          [else
           (let ([last (last stack)])
             (if (and (not (null? stack)) (< (char->integer (car s)) (char->integer last)))
                 (helper s (reverse (cdr (reverse stack))))
                 (helper (cdr s) (append stack (list (car s))))))]))
  (list->string (helper (string->list s) '())))