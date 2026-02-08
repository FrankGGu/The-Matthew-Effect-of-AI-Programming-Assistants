(define (add-digits num)
  (if (= num 0)
      0
      (let loop ((n num))
        (if (< n 10)
            n
            (loop (+ (remainder n 10) (quotient n 10)))))))