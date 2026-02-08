#lang racket

(define (smallest-k-length-subsequence s k letter)
  (define n (string-length s))
  (define cnt (make-hash))
  (for ([c (in-string s)])
    (hash-set! cnt c (+ (hash-ref cnt c 0) 1)))
  (define (count c)
    (hash-ref cnt c 0))
  (define (compare a b)
    (cond
      [(char=? a b) #f]
      [(and (char=? a letter) (not (char=? b letter))) #t]
      [(and (not (char=? a letter)) (char=? b letter)) #f]
      [else (< a b)]))
  (define (helper s k)
    (define len (string-length s))
    (if (= k 0)
        ""
        (let loop ([i 0] [res '()])
          (if (>= i len)
              (list->string (reverse res))
              (let* ([c (string-ref s i)]
                     [remaining (- len i)]
                     [need (- k 1)]
                     [have (count c)])
                (if (and (<= need remaining) (>= have 1))
                    (loop (+ i 1) (cons c res))
                    (loop (+ i 1) res)))))))
  (helper s k))