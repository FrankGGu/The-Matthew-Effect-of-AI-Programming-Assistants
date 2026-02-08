#lang racket

(define (find-key nums)
  (define (helper i)
    (if (= i (length nums))
        #f
        (let ((sum (apply + (take nums i))))
          (if (= sum (list-ref nums i))
              i
              (helper (+ i 1))))))
  (helper 0))