#lang racket

(define (max-frequency nums k)
  (define (count-freq nums)
    (for/fold ([freq (hash)])
              ([num nums])
      (hash-update freq num add1 0)))

  (define freq (count-freq nums))
  (define sorted (sort (hash-keys freq) >))

  (define (helper i max-freq)
    (if (>= i (length sorted))
        max-freq
        (let* ([num (list-ref sorted i)]
               [count (hash-ref freq num)]
               [remaining (- k (* count num))])
          (if (<= remaining 0)
              (helper (+ i 1) (max max-freq count))
              (let loop ([j (+ i 1)] [total 0] [max-count count])
                (if (>= j (length sorted))
                    (helper (+ i 1) (max max-freq max-count))
                    (let ([next-num (list-ref sorted j)])
                      (let ([add (min (- k total) (* (hash-ref freq next-num) next-num))])
                        (if (<= add 0)
                            (helper (+ i 1) (max max-freq max-count))
                            (loop (+ j 1) (+ total add) (max max-count (hash-ref freq next-num)))))))))))

  (helper 0 0))