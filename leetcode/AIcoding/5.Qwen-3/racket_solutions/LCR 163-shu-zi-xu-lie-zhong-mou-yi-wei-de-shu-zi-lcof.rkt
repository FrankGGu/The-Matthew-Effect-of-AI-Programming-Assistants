(define (find-kth-number n k)
  (define (count-digits num)
    (let loop ([num num] [count 0])
      (if (= num 0)
          count
          (loop (quotient num 10) (+ count 1)))))

  (define (number-of-digits-in-range start end)
    (let loop ([start start] [end end] [total 0])
      (if (> start end)
          total
          (loop (+ start 1) end (+ total (count-digits start))))))

  (define (find-kth-number-helper n k)
    (let loop ([start 1] [k k])
      (if (= k 0)
          (- start 1)
          (let* ([digits (count-digits start)]
                 [next-start (+ start 1)]
                 [digits-count (* digits (max 0 (- next-start start)))]
                 [remaining (- k digits-count)])
            (if (<= remaining 0)
                start
                (loop next-start (- k digits-count)))))))

  (find-kth-number-helper n k))