(define (count-substrings s t)
  (define (diff-one? a b)
    (let loop ([i 0] [diff 0])
      (cond [(= i (string-length a)) (= diff 1)]
            [(and (= i (string-length b)) (< diff 1)) #f]
            [(char=? (string-ref a i) (string-ref b i)) (loop (+ i 1) diff)]
            [else (if (= diff 0)
                      (loop (+ i 1) 1)
                      #f)])))
  (define len (string-length s))
  (define total 0)
  (for ([i (in-range len)])
    (for ([j (in-range i len)])
      (when (diff-one? (substring s i (+ j 1)) (substring t i (+ j 1)))
        (set! total (+ total 1)))))
  total)