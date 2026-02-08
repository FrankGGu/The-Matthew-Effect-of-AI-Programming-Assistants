#lang racket

(define (lexicographically-smallest-string s)
  (define (helper s)
    (if (equal? s "")
        ""
        (let* ((min-char (apply min (string->list s)))
               (index (string-index s min-char))
               (rest (substring s (add1 index))))
          (string-append (string min-char) (helper rest)))))
  (helper s))