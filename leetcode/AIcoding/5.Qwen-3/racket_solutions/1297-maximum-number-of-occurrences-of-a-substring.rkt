#lang racket

(define (max-occurrences s sub)
  (define (count-substring s sub)
    (define len-sub (string-length sub))
    (define len-s (string-length s))
    (if (< len-s len-sub) 0
        (let loop ((i 0) (count 0))
          (if (>= i (- len-s len-sub)) count
              (if (equal? (substring s i (+ i len-sub)) sub)
                  (loop (+ i 1) (+ count 1))
                  (loop (+ i 1) count))))))
  (define (get-max-occurrences s sub)
    (define len-sub (string-length sub))
    (define len-s (string-length s))
    (if (< len-s len-sub) 0
        (let loop ((i 0) (max-count 0))
          (if (>= i (- len-s len-sub)) max-count
              (let ((current-count (count-substring s sub)))
                (loop (+ i 1) (max max-count current-count)))))))
  (get-max-occurrences s sub))