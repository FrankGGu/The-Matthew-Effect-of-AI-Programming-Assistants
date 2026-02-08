#lang racket

(define (are-nums-ascending s)
  (define (is-number? str)
    (and (not (string=? "" str)) (string->number str #f)))

  (define nums
    (filter values
            (map is-number? (string-split s))))

  (and (= (length nums) (length (remove-duplicates nums)))
       (apply < nums)))