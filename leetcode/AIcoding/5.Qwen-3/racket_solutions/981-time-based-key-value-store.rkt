#lang racket

(define-struct kv (key time value) #:transparent)

(define (make-time-map)
  (hash))

(define (insert time-map key time value)
  (hash-update time-map key (λ (lst) (cons (kv key time value) lst)) '()))

(define (get time-map key time)
  (define (helper lst)
    (cond [(null? lst) #f]
          [(<= (kv-time (car lst)) time) (kv-value (car lst))]
          [else (helper (cdr lst))]))
  (let ([lst (hash-ref time-map key '())])
    (if (null? lst)
        #f
        (helper lst))))

(define (time-map-operations operations)
  (define time-map (make-time-map))
  (for/list ([op (in-list operations)])
    (match op
      [`(insert ,key ,time ,value) (set! time-map (insert time-map key time value))]
      [`(get ,key ,time) (get time-map key time)])))