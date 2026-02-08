#lang racket

(define (has-path-sum root target)
  (cond [(not root) #f]
        [(and (not (left root)) (not (right root)) (= target (value root))) #t]
        [else (or (has-path-sum (left root) (- target (value root)))
                  (has-path-sum (right root) (- target (value root))))]))