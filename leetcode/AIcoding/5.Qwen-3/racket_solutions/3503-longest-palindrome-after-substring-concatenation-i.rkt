#lang racket

(define (longest-palindrome s)
  (define (expand-around-center left right)
    (let loop ([l left] [r right])
      (if (and (>= l 0) (< r (string-length s)) (char=? (string-ref s l) (string-ref s r)))
          (loop (- l 1) (+ r 1))
          (- r l))))
  (define (max-length)
    (let loop ([i 0] [max-len 0])
      (if (= i (string-length s))
          max-len
          (let ([len1 (expand-around-center i i)]
                [len2 (expand-around-center i (+ i 1))])
            (loop (+ i 1) (max max-len (max len1 len2)))))))
  (let ([len (max-length)])
    (if (even? len)
        (substring s 0 len)
        (substring s 0 (+ len 1)))))