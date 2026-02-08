#lang racket

(define (max-ports capacity)
  (define (helper lst res)
    (cond [(null? lst) res]
          [(> (car lst) capacity) (helper (cdr lst) res)]
          [else (helper (cdr lst) (cons (car lst) res))]))
  (reverse (helper '(1 2 3 4 5 6 7 8 9 10) '())))

(define (delivering-boxes storage-areas ports)
  (define (helper sa p res)
    (cond [(null? sa) res]
          [(null? p) res]
          [else (helper (cdr sa) (cdr p) (append res (list (car sa) (car p))))]))
  (helper storage-areas ports '()))

(define (solve)
  (let ([capacity (read)])
    (let ([storage (map (lambda (x) (read)) (range capacity))])
      (let ([ports (map (lambda (x) (read)) (range capacity))])
        (delivering-boxes storage ports)))))