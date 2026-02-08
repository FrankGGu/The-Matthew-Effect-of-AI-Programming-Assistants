#lang racket

(define (max-good-people statements)
  (define n (length statements))
  (define (check mask)
    (for/and ([i n])
      (if (bitwise-bit-set? mask i)
          (for/and ([j n])
            (if (bitwise-bit-set? mask j)
                (= (string-ref (list-ref statements i) j) (if (bitwise-bit-set? mask j) #\T #\F))
                #t))
          #t)))
  (define max-good
    (for/fold ([max 0]) ([mask (in-range (expt 2 n))])
      (if (check mask)
          (max max (bit-count mask))
          max)))
  max-good)