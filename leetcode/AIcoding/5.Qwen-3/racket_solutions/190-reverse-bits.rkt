(define (reverse-bits n)
  (define (reverse-helper n count)
    (if (= count 32)
        n
        (let* ([bit (bitwise-and n 1)]
               [n (arithmetic-shift n -1)]
               [n (bitwise-ior (arithmetic-shift n 1) bit)])
          (reverse-helper n (+ count 1)))))
  (reverse-helper n 0))