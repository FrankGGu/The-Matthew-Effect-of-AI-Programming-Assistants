#lang racket

(define-struct seat-manager (available))

(define (make-seat-manager n)
  (let ([heap (list->heap (range 1 (add1 n)) <)])
    (make-seat-manager heap)))

(define (reserve sm)
  (let ([seat (heap-min (seat-manager-available sm))])
    (heap-remove! (seat-manager-available sm) seat)
    seat))

(define (unreserve sm seat)
  (heap-add! (seat-manager-available sm) seat))