#lang racket
(define (create-dataframe names departments)
  (define names-col (map list names))
  (define departments-col (map list departments))
  (apply map list (append names-col departments-col)))