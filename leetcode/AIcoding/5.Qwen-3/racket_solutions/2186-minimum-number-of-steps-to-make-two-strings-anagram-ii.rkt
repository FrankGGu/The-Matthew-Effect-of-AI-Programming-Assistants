#lang racket

(define (count-characters s)
  (define (helper s counts)
    (if (string=? s "")
        counts
        (let* ([c (string-ref s 0)]
               [new-counts (hash-set counts c (+ 1 (hash-ref counts c 0)))])
          (helper (substring s 1) new-counts))))
  (helper s (make-hash)))

(define (min-steps-to-make-two-strings-anagram-two s t)
  (define s-counts (count-characters s))
  (define t-counts (count-characters t))
  (define (get-diff counts1 counts2)
    (for/fold ([diff 0]) ([char (in-hash-keys counts1)])
      (+ diff (abs (- (hash-ref counts1 char 0) (hash-ref counts2 char 0))))))
  (+ (get-diff s-counts t-counts) (get-diff t-counts s-counts)))