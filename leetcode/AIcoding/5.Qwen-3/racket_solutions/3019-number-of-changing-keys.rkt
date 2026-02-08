#lang racket

(define (count-changes s)
  (define (helper prev c count)
    (if (null? c)
        count
        (let ((current (string-ref (car c) 0)))
          (if (and (not (char=? prev current))
                   (or (char=? prev #\a) (char=? prev #\d) (char=? prev #\g)
                       (char=? current #\a) (char=? current #\d) (char=? current #\g)))
              (helper current (cdr c) (+ count 1))
              (helper current (cdr c) count)))))
  (if (null? s)
      0
      (helper (string-ref (car s) 0) (cdr s) 0)))