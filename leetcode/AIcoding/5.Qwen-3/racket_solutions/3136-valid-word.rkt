#lang racket

(define (valid-word? word)
  (define (is-letter c)
    (and (char>=? c #\a) (char<=? c #\z)))
  (define (is-digit c)
    (and (char>=? c #\0) (char<=? c #\9)))
  (define (is-valid-char c)
    (or (is-letter c) (is-digit c)))
  (define (count-letters-and-digits s)
    (for/fold ([letters 0] [digits 0])
              ([c (in-string s)])
      (cond [(is-letter c) (values (+ letters 1) digits)]
            [(is-digit c) (values letters (+ digits 1))]
            [else (values -1 -1)])))
  (define-values (letters digits) (count-letters-and-digits word))
  (and (>= letters 1)
       (>= digits 1)
       (not (equal? (string-ref word 0) #\0))
       (not (equal? (string-ref word (sub1 (string-length word))) #\0))))