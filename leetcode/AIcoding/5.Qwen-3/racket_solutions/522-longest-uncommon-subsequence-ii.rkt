(define (find-longest-uncommon-subsequence strs)
  (define (is-subsequence s t)
    (define (helper i j)
      (cond [(= i (string-length s)) #t]
            [(= j (string-length t)) #f]
            [(char=? (string-ref s i) (string-ref t j))
             (helper (+ i 1) (+ j 1))]
            [else (helper i (+ j 1))]))
    (helper 0 0))

  (define (longest-uncommon-subsequence strs)
    (define (check s)
      (for/and ([t strs])
        (not (is-subsequence s t))))
    (for/fold ([max-len -1] [max-str ""])
              ([s strs])
      (if (check s)
          (if (> (string-length s) max-len)
              (values (string-length s) s)
              (values max-len max-str))
          (values max-len max-str))))

  (define-values (len str) (longest-uncommon-subsequence strs))
  str)