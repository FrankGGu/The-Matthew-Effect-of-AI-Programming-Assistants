(define (rotated-digits n)
  (define (valid? s)
    (let loop ([i 0] [has-rotated #f])
      (if (= i (string-length s))
          has-rotated
          (let ([c (string-ref s i)])
            (cond [(char=? c #\0) (loop (+ i 1) has-rotated)]
                  [(char=? c #\1) (loop (+ i 1) has-rotated)]
                  [(char=? c #\8) (loop (+ i 1) has-rotated)]
                  [(char=? c #\2) (loop (+ i 1) #t)]
                  [(char=? c #\5) (loop (+ i 1) #t)]
                  [(char=? c #\6) (loop (+ i 1) #t)]
                  [(char=? c #\9) (loop (+ i 1) #t)]
                  [else #f])))))
  (define (rotated-digit? x)
    (valid? (number->string x)))
  (define (count n)
    (if (> n 0)
        (+ (if (rotated-digit? n) 1 0) (count (- n 1)))
        0))
  (count n))