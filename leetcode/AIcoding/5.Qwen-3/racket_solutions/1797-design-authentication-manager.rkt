#lang racket

(define-struct auth-manager (time-to-live items))

(define (make-auth-manager time-to-live)
  (make-auth-manager time-to-live (hash)))

(define (generate auth-manager token)
  (define time-to-live (auth-manager-time-to-live auth-manager))
  (define now (current-seconds))
  (hash-set! (auth-manager-items auth-manager) token (+ now time-to-live)))

(define (renew auth-manager token)
  (define items (auth-manager-items auth-manager))
  (when (hash-has-key? items token)
    (define time-to-live (auth-manager-time-to-live auth-manager))
    (define now (current-seconds))
    (hash-set! items token (+ now time-to-live))))

(define (count-unexpired-tokens auth-manager)
  (define now (current-seconds))
  (define items (auth-manager-items auth-manager))
  (for/sum ([t (in-hash-values items)]
            #:when (< t now))
    1))

(define (get-time-to-live auth-manager)
  (auth-manager-time-to-live auth-manager))