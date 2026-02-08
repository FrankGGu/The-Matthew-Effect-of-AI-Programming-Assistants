(define (min-array-length nums)
  (define (count-freq nums)
    (let loop ([nums nums] [freq (hash)])
      (if (null? nums)
          freq
          (loop (cdr nums) (hash-update freq (car nums) add1 0)))))

  (define freq (count-freq nums))
  (define keys (hash-keys freq))
  (define-values (odd even) (for/fold ([odd 0] [even 0]) ([k keys])
                              (define cnt (hash-ref freq k))
                              (if (odd? cnt)
                                  (values (+ odd 1) even)
                                  (values odd (+ even 1)))))

  (min (length nums) (- (length nums) (* 2 (min odd even)))))