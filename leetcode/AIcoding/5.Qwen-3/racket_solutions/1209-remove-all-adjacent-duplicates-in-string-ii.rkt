#lang racket

(define/contract (remove-adjacent-duplicates s k)
  (-> string? exact-integer? string?)
  (define stack (list))
  (for ([c (in-string s)])
    (if (and (not (null? stack)) (= (car (last stack)) k) (= (char->integer c) (char->integer (caar stack))))
        (set! stack (reverse (cdr (reverse stack))))
        (set! stack (cons (cons c 1) stack))))
  (apply string (map car (reverse stack))))