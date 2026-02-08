#lang racket

(define (count-alternating-subarrays nums)
  (define len (length nums))
  (if (= len 0) 0
      (let loop ([i 1] [count 1] [prev (car nums)])
        (if (= i len) count
            (let ([current (list-ref nums i)])
              (if (not (= current prev))
                  (loop (+ i 1) (+ count (- i 1)) current)
                  (loop (+ i 1) count current)))))))