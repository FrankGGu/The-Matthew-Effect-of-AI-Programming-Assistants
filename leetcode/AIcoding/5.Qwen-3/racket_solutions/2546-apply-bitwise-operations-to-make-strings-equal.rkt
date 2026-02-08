#lang racket

(define/contract (min-operations s t)
  (-> string? string? exact-nonnegative-integer?)
  (define (count-bits str)
    (for/sum ([c str]) (if (char=? c #\1) 1 0)))
  (define s1 (count-bits s))
  (define t1 (count-bits t))
  (if (= s1 t1)
      (let loop ([i 0] [s s] [t t] [res 0])
        (if (= i (string-length s))
            res
            (let ([s-bit (char->digit (string-ref s i))]
                  [t-bit (char->digit (string-ref t i))])
              (if (= s-bit t-bit)
                  (loop (+ i 1) s t res)
                  (loop (+ i 1) s t (+ res 1))))))
      (error "Strings cannot be made equal")))