(define (security-check n k)
  (let loop ((i 1) (res 0))
    (if (> i n)
        res
        (loop (+ i 1) (+ res (modulo (- (* i i) 1) k))))))