#lang racket

(define (find-good-subset matrix)
  (define rows (length matrix))
  (define cols (if (> rows 0) (length (car matrix)) 0))
  (define (all-zero? row)
    (andmap (lambda (x) (= x 0)) row))
  (define (any-zero? row)
    (ormap (lambda (x) (= x 0)) row))
  (define (good-subset?)
    (let loop ([i 0] [j 0])
      (cond [(>= i rows) #t]
            [(>= j cols) (loop (+ i 1) 0)]
            [else
             (if (and (all-zero? (list-ref matrix i))
                      (any-zero? (list-ref matrix j)))
                 #t
                 (loop i (+ j 1)))])))
  (if (good-subset?) '() '()))