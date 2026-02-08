#lang racket

(define (max-subarrays s)
  (define n (string-length s))
  (define dp (make-vector n 0))
  (define last (make-hash))
  (define (max-subarrays-helper i)
    (if (= i n) 0
        (let ((c (string-ref s i)))
          (if (hash-has-key? last c)
              (let ((prev (hash-ref last c)))
                (vector-set! dp i (+ (vector-ref dp prev) 1))
                (hash-set! last c i)
                (max (vector-ref dp i) (max-subarrays-helper (add1 i))))
              (begin
                (vector-set! dp i (if (zero? i) 1 (add1 (vector-ref dp (sub1 i)))))
                (hash-set! last c i)
                (max (vector-ref dp i) (max-subarrays-helper (add1 i)))))))
  (max-subarrays-helper 0))