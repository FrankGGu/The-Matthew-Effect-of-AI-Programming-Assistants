(define (xor-game nums)
  (let loop ([i 0] [res 0])
    (if (= i (length nums))
        res
        (loop (+ i 1) (bitwise-xor res (list-ref nums i))))))