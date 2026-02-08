(define (min-swaps s)
  (define (count-chars target)
    (define (helper i cnt)
      (if (= i (string-length s))
          cnt
          (helper (+ i 1) (+ cnt (if (char=? (string-ref s i) target) 0 1)))))
    (helper 0 0))
  (let* ([even (count-chars #\0)]
         [odd (count-chars #\1)])
    (if (even? (string-length s))
        (min even odd)
        (if (even? even)
            odd
            even))))