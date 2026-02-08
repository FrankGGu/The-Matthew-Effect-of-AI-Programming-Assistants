#lang racket

(define (remove-trailing-zeros num)
  (if (string=? num "")
      ""
      (let loop ([s (string->list num)])
        (if (or (null? s) (not (char=? (car s) #\0)))
            (list->string (reverse s))
            (loop (cdr s))))))
(define/contract (remove-trailing-zeros num)
  (-> string? string?)
  (remove-trailing-zeros num))