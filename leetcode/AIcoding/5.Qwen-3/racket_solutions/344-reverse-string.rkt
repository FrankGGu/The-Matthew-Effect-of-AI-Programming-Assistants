#lang racket

(define (reverse-string s)
  (list->string (reverse (string->list s))))