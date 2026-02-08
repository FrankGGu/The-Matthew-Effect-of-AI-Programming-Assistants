(define (min-feeding-buckets s)
  (define len (string-length s))
  (define-values (res i)
    (for/fold ([res 0] [i 0])
              ([i (in-range len)])
      (cond
        [(char=? #\H (string-ref s i))
         (if (and (< (+ i 1) len) (char=? #\H (string-ref s (+ i 1))))
             (values res (+ i 2))
             (values (+ res 1) (+ i 1)))]
        [else
         (values res (+ i 1))])))
  res)