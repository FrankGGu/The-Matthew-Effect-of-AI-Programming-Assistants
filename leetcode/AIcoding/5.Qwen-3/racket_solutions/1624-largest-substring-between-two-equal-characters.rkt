#lang racket

(define (largest-substring-between-two-equal-characters s)
  (define (loop i max-len)
    (if (= i (string-length s))
        max-len
        (let ((c (string-ref s i)))
          (let ((last-index (string-last-index-of s c)))
            (if (= last-index i)
                (loop (+ i 1) max-len)
                (loop (+ i 1) (max max-len (- last-index i 1))))))))
  (loop 0 0))