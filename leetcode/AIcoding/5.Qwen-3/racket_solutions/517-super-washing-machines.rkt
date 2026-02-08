(define (super-washing-machines coins)
  (let loop ([i 0] [sum 0] [res 0] [max-imbalance 0])
    (if (= i (length coins))
        res
        (let* ([coin (list-ref coins i)]
               [sum (+ sum coin)]
               [balance (- sum (* (add1 i) (quotient (apply + coins) (length coins))))]
               [max-imbalance (max max-imbalance (abs balance))])
          (loop (add1 i) sum res max-imbalance)))))