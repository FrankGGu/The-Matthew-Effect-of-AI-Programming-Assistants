(define (find-repeated-dna-sequences s)
  (define (char->int c)
    (cond [(char=? c #\A) 0]
          [(char=? c #\C) 1]
          [(char=? c #\G) 2]
          [(char=? c #\T) 3]))

  (define (encode s)
    (let loop ([i 0] [acc 0])
      (if (= i 10)
          acc
          (loop (+ i 1) (+ (* acc 4) (char->int (string-ref s i)))))))

  (define seen (make-hash))
  (define result '())

  (let loop ([i 0])
    (when (< i (- (string-length s) 9))
      (let ([seq (substring s i (+ i 10))])
        (let ([code (encode seq)])
          (hash-set! seen code (+ (hash-ref seen code 0) 1))
          (when (= (hash-ref seen code 0) 2)
            (set! result (cons seq result)))))
      (loop (+ i 1))))

  (reverse result))