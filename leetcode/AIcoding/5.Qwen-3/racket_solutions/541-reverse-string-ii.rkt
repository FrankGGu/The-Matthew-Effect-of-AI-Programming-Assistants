#lang racket

(define (reverse-string s)
  (define (reverse-helper s i)
    (if (>= i (string-length s))
        s
        (let* ((j (min (+ i 2) (string-length s)))
               (sub (substring s i j))
               (reversed (list->string (reverse (string->list sub)))))
          (string-append (substring s 0 i) reversed (reverse-helper s j)))))
  (reverse-helper s 0))