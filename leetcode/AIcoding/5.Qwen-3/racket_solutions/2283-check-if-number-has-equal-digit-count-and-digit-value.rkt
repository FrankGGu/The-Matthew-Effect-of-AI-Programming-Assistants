(define (digit-count num)
  (define (count-digits n)
    (let loop ([n n] [counts (make-hash)])
      (if (= n 0)
          counts
          (let* ([d (modulo n 10)]
                 [c (hash-ref counts d 0)])
            (loop (quotient n 10) (hash-set counts d (+ c 1)))))))
  (define counts (count-digits num))
  (for/and ([i (in-range 1 10)])
    (= (hash-ref counts i 0) i)))