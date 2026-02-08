#lang racket

(define (length-of-longest-substring s)
  (define (helper i j seen max-len)
    (if (>= i (string-length s))
        max-len
        (let ((c (string-ref s i)))
          (if (and (hash-has-key? seen c) (>= (hash-ref seen c) j))
              (helper (+ i 1) (+ j 1) (hash-set seen c i) max-len)
              (helper (+ i 1) j (hash-set seen c i) (max max-len (- i j +1)))))))
  (helper 0 0 (make-hash) 0))