(define (bulb-switcher n)
  (if (< n 2)
      n
      (let loop ([i 2] [count 1])
        (if (> i n)
            count
            (loop (+ i 2) (+ count 1))))))