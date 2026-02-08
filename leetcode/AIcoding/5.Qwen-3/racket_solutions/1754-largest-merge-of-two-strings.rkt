(define (largest-merge a b)
  (define (compare i j)
    (let loop ()
      (cond
        [(= i (string-length a)) #t]
        [(= j (string-length b)) #f]
        [(char<? (string-ref a i) (string-ref b j)) #f]
        [(char>? (string-ref a i) (string-ref b j)) #t]
        [else (loop (+ i 1) (+ j 1))])))
  (define (merge a b)
    (let loop ([a a] [b b] [res ""])
      (cond
        [(string=? a "") res]
        [(string=? b "") res]
        [(compare 0 0) (loop (substring a 1) b (string-append res (string (string-ref a 0))))]
        [else (loop a (substring b 1) (string-append res (string (string-ref b 0))))])))
  (merge a b))