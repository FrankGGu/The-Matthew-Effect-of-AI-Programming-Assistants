#lang racket

(define (find-books-with-no-available-copies books)
  (filter (lambda (book) (= 0 (cadr book))) books))