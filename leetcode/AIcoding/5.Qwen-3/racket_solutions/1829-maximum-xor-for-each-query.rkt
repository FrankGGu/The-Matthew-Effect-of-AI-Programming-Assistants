(define (find-max-xor n queries)
  (define (max-xor a b)
    (let loop ([a a] [b b] [res 0] [i 30])
      (if (< i 0)
          res
          (let ([bit-a (bitwise-and (arithmetic-shift a i) 1)]
                [bit-b (bitwise-and (arithmetic-shift b i) 1)])
            (if (= bit-a bit-b)
                (loop (arithmetic-shift a -1) (arithmetic-shift b -1) res (- i 1))
                (loop (arithmetic-shift a -1) (arithmetic-shift b -1) (arithmetic-shift res 1) (- i 1)))))))
  (map (lambda (q) (max-xor (car q) (cadr q))) queries))