(define (max-profit prices fee)
  (define (helper cash hold prices)
    (cond [(null? prices) cash]
          [else
           (let* ([price (car prices)]
                  [cash-without-buy (max cash hold)]
                  [hold-with-buy (max hold (- cash price))]
                  [hold-with-sell (max hold (- hold price fee))])
             (helper cash-without-buy hold-with-sell (cdr prices)))]))
  (helper 0 (* -1 (car prices)) (cdr prices)))