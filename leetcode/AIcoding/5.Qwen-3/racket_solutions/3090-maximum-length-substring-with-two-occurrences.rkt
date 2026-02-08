#lang racket

(define (max-length-substring s)
  (define (helper i count)
    (if (>= i (string-length s))
        0
        (let ((current (string-ref s i)))
          (let ((new-count (if (= (hash-ref count current 0) 1)
                               (add1 (hash-ref count current 0))
                               (hash-ref count current 0))))
            (if (= new-count 2)
                (max (- i (hash-ref count current 0)) (helper (add1 i) (hash-set count current 2)))
                (helper (add1 i) (hash-set count current new-count)))))))
  (helper 0 (make-hash)))