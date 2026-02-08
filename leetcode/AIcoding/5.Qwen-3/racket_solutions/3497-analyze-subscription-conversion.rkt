#lang racket

(define (convert-subscription)
  (let ([input (read-line)])
    (cond [(string=? input "1") (display "Yes")]
          [(string=? input "0") (display "No")]
          [else (display "Invalid input")])))

(convert-subscription)