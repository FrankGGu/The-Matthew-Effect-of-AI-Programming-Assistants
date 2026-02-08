(define (longest-continuous-increasing-subsequence nums)
  (define len (length nums))
  (if (= len 0) 0
      (let loop ([i 1] [current 1] [max-len 1])
        (if (= i len)
            max-len
            (if (> (list-ref nums i) (list-ref nums (- i 1)))
                (loop (+ i 1) (+ current 1) (max max-len (+ current 1)))
                (loop (+ i 1) 1 max-len))))))