#lang racket

(define (capitalize-title s)
  (define (capitalize-word word)
    (if (<= (string-length word) 2)
        (string-downcase word)
        (string-upcase (substring word 0 1))
        (string-append (string-upcase (substring word 0 1)) (string-downcase (substring word 1)))))
  (string-join (map capitalize-word (string-split s)) " "))