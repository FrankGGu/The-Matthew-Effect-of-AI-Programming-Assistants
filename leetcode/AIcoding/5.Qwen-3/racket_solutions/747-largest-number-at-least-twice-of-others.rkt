(define (largest-number-at-least-twice-of-others nums)
  (let* ([max-num (apply max nums)]
         [count (length (filter (lambda (x) (>= (* 2 x) max-num)) nums))])
    (if (= count 1) max-num -1)))