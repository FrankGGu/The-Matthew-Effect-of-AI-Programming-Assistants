#lang racket

(define (find-students-improved students)
  (filter (lambda (s) (> (cadr s) (car s))) students))