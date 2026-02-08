#lang racket

(define (count-substrings-divisible-by-last-digit s)
  (define len (string-length s))
  (define last-digit (string-ref s (sub1 len)))
  (define last-digit-int (- (char->integer last-digit) (char->integer #\0)))
  (define count 0)
  (for ([i (in-range len)])
    (when (and (not (= i (sub1 len)))
               (let ([substring (substring s i (sub1 len))])
                 (let ([num (string->number substring)])
                   (and num (= (modulo num last-digit-int) 0))))))
    (set! count (+ count 1)))
  count)