#lang racket

(define (eval-rpn tokens)
  (define stack (list))
  (for ([token tokens])
    (cond
      [(equal? token "+") (set! stack (cons (+ (cadr stack) (car stack)) (cddr stack)))]
      [(equal? token "-") (set! stack (cons (- (cadr stack) (car stack)) (cddr stack)))]
      [(equal? token "*") (set! stack (cons (* (cadr stack) (car stack)) (cddr stack)))]
      [(equal? token "/") (set! stack (cons (quotient (cadr stack) (car stack)) (cddr stack)))]
      [else (set! stack (cons (string->number token) stack))]))
  (car stack))