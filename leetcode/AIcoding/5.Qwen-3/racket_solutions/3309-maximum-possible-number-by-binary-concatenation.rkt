#lang racket

(define (max-number-by-concatenation nums)
  (define (compare a b)
    (if (> (string-length (number->string a)) (string-length (number->string b)))
        -1
        (if (< (string-length (number->string a)) (string-length (number->string b)))
            1
            (if (> (string-append (number->string a) (number->string b))
                   (string-append (number->string b) (number->string a)))
                -1
                1))))
  (define sorted (sort nums compare))
  (if (and (equal? (car sorted) 0) (= (length sorted) 1))
      "0"
      (apply string-append (map number->string sorted))))