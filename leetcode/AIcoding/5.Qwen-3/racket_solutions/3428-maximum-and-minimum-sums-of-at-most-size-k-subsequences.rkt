#lang racket

(define (max-min-subsequence-sum nums k)
  (define (sum lst)
    (apply + lst))

  (define (sort-desc lst)
    (sort lst >))

  (define (sort-asc lst)
    (sort lst <))

  (define (take lst n)
    (take-right lst n))

  (define (drop lst n)
    (drop-right lst n))

  (define sorted-nums (sort-desc nums))
  (define max-sum (sum (take sorted-nums k)))

  (define sorted-nums-asc (sort-asc nums))
  (define min-sum (sum (take sorted-nums-asc k)))

  (list max-sum min-sum))