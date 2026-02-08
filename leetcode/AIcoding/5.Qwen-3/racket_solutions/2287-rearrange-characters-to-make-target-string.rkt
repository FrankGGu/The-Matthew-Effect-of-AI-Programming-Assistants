#lang racket

(define (count-characters s)
  (for/fold ([counts (hash)])
            ([c (in-string s)])
    (hash-update counts c add1 0)))

(define (can-construct-target target chars)
  (let* ([target-counts (count-characters target)]
         [chars-counts (count-characters chars)])
    (for/and ([char (in-hash-keys target-counts)])
      (<= (hash-ref target-counts char) (hash-ref chars-counts char 0)))))

(define (rearrange-characters s target)
  (if (can-construct-target target s)
      (string-length target)
      -1))