#lang racket

(define (freq s)
  (define (helper s freqs)
    (if (null? s)
        freqs
        (let ((c (car s)))
          (helper (cdr s) (cons (cons c (+ 1 (cdr (assoc c freqs)))) (remove (assoc c freqs) freqs))))))
  (helper (string->list s) '()))

(define (kth-unique-char s k)
  (define (helper s count)
    (if (null? s)
        #f
        (let ((c (car s)))
          (if (= (cdr (assoc c (freq s))) k)
              c
              (helper (cdr s) (+ count 1))))))
  (helper (string->list s) 0))

(define (first-letter-appear-twice s)
  (kth-unique-char s 2))