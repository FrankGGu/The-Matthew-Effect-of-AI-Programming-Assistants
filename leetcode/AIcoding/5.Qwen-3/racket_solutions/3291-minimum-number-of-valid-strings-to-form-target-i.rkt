(define (min-number-of-strings-to-form-target words target)
  (define dp (make-vector (+ (string-length target) 1) #f))
  (vector-set! dp 0 #t)
  (for ([i (in-range 1 (add1 (string-length target)))]
        [j (in-range 0 (sub1 (string-length target)))])
    (when (vector-ref dp j)
      (for ([word words])
        (when (and (<= (+ j (string-length word)) (string-length target))
                   (equal? (substring target j (+ j (string-length word))) word))
          (vector-set! dp (+ j (string-length word)) #t)))))
  (let loop ([i (string-length target)] [count 0])
    (if (= i 0)
        count
        (let ([prev (vector-ref dp i)])
          (if prev
              (loop (- i 1) (+ count 1))
              (loop (- i 1) count))))))