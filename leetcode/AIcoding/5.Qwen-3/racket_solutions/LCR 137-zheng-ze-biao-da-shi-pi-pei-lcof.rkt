#lang racket

(define (valid-phonenumbers numbers)
  (define (is-valid? s)
    (define (helper i count)
      (cond [(= i (string-length s)) (= count 10)]
            [(char-numeric? (string-ref s i))
             (if (= count 10)
                 #f
                 (helper (+ i 1) (+ count 1)))]
            [(or (char=? (string-ref s i) #\() (char=? (string-ref s i) #\))
                 (char=? (string-ref s i) #\-)
                 (char=? (string-ref s i) #\.))
             (helper (+ i 1) count)]
            [else #f]))
    (and (>= (string-length s) 10)
         (helper 0 0)))
  (filter is-valid? numbers))