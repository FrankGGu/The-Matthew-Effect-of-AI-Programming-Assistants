(define (coin-change coins amount)
  (define (helper amount memo)
    (cond [(= amount 0) 0]
          [(< amount 0) +inf.0]
          [else
           (let ((res (for/fold ([min-steps +inf.0])
                         ([c (in-list coins)])
                       (min min-steps (+ 1 (helper (- amount c) memo)))))
             (if (and (real? res) (not (infinite? res))) res +inf.0))]))
  (let ([result (helper amount (make-hash))])
    (if (infinite? result) -1 result)))