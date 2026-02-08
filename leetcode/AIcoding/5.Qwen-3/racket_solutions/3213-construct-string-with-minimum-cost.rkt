#lang racket

(define (build-string cost s)
  (define len (string-length s))
  (define dp (make-vector len 0))
  (vector-set! dp 0 (if (= (string-ref s 0) #\a) (vector-ref cost 0) (vector-ref cost 1)))
  (for ([i (in-range 1 len)])
    (vector-set! dp i (+ (vector-ref dp (- i 1)) (if (= (string-ref s i) #\a) (vector-ref cost 0) (vector-ref cost 1)))))
  (vector-ref dp (- len 1)))

(define (main)
  (define input (read-line))
  (define cost (map string->number (string-split (read-line))))
  (define s (read-line))
  (display (build-string cost s)))

(main)