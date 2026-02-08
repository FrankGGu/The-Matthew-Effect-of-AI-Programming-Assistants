#lang racket

(define (max-candies candies)
  (define (helper lst)
    (if (null? lst)
        0
        (let ((max-val (apply max lst)))
          (+ (count (lambda (x) (= x max-val)) lst)
             (helper (map (lambda (x) (- x max-val)) (filter (lambda (x) (> x max-val)) lst)))))))
  (helper candies))

(define (minimum-operations candies)
  (define (helper lst)
    (if (null? lst)
        0
        (let ((max-val (apply max lst)))
          (+ (count (lambda (x) (= x max-val)) lst)
             (helper (map (lambda (x) (- x max-val)) (filter (lambda (x) (> x max-val)) lst)))))))
  (helper candies))