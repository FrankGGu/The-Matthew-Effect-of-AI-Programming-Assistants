(define (is-palindrome s start end)
  (let loop ([i start] [j end])
    (cond [(>= i j) #t]
          [(char=? (string-ref s i) (string-ref s j)) (loop (+ i 1) (- j 1))]
          [else #f])))

(define (partition s)
  (letrec ([result '()]
           [backtrack (lambda (start current)
                        (if (>= start (string-length s))
                            (set! result (cons (reverse current) result))
                            (let loop ([i start])
                              (when (<= i (string-length s))
                                (when (is-palindrome s start i)
                                  (backtrack (+ i 1) (cons (substring s start (+ i 1)) current)))
                                (loop (+ i 1))))))])
    (backtrack 0 '())
    (reverse result)))