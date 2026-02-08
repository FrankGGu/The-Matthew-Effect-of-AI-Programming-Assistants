#lang racket

(define-struct event (start end))

(define (book start end)
  (define events (make-hash))
  (define (add-event s e)
    (hash-set! events s (add1 (hash-ref events s 0)))
    (hash-set! events e (sub1 (hash-ref events e 0))))
  (define (query)
    (define sorted (sort (hash-keys events) <))
    (define-values (max-occurrence current-occurrence)
      (for/fold ([max 0] [current 0]) ([k sorted])
        (values (max max (+ current (hash-ref events k)))
                (+ current (hash-ref events k)))))
    max-occurrence)
  (add-event start end)
  (query))