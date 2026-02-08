(define (can-escape s t)
  (define (helper s t)
    (let loop ([i 0] [j 0])
      (cond [(and (= i (string-length s)) (= j (string-length t))) #t]
            [(or (= i (string-length s)) (= j (string-length t))) #f]
            [(char=? (string-ref s i) (string-ref t j))
             (loop (+ i 1) (+ j 1))]
            [(char=? (string-ref s i) #\L)
             (and (char=? (string-ref t j) #\L)
                  (loop (+ i 1) (+ j 1)))]
            [(char=? (string-ref s i) #\R)
             (and (char=? (string-ref t j) #\R)
                  (loop (+ i 1) (+ j 1)))]
            [else #f])))
  (helper s t))