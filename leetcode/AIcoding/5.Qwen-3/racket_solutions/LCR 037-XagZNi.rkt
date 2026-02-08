#lang racket

(define (asteroid-direction x)
  (if (> x 0) 'right 'left))

(define (collision? a b)
  (and (eq? (asteroid-direction a) 'right)
       (eq? (asteroid-direction b) 'left)))

(define (asteroid-collision asteroids)
  (define (helper stack remaining)
    (cond [(null? remaining) stack]
          [else
           (let ([current (car remaining)])
             (if (null? stack)
                 (helper (list current) (cdr remaining))
                 (let ([last (car stack)])
                   (if (collision? last current)
                       (if (> (abs last) (abs current))
                           (helper stack (cdr remaining))
                           (if (= (abs last) (abs current))
                               (helper (cdr stack) (cdr remaining))
                               (helper (cdr stack) (cons current (cdr remaining)))))
                       (helper (cons current stack) (cdr remaining))))))]))
  (reverse (helper '() asteroids)))

(define/contract (asteroids-destroyed asteroids)
  (-> (listof exact-integer?) (listof exact-integer?))
  (asteroid-collision asteroids))