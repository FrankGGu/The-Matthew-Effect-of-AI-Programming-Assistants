(define (longest-1s-subarray arr)
  (let loop ([left 0] [right 0] [count 0] [max-len 0])
    (if (= right (length arr))
        max-len
        (let ([current (list-ref arr right)])
          (if (= current 1)
              (loop left (+ right 1) count (max max-len (- right left)))
              (loop (if (> count 0) (+ left 1) left) (+ right 1) (+ count 1) max-len)))))))