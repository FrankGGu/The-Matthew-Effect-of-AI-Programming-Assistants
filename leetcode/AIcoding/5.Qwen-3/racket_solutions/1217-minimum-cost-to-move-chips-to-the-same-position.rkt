(define (min-cost-to-move-chips positions)
  (let loop ([even 0] [odd 0] [positions positions])
    (cond [(null? positions) (min even odd)]
          [(even? (car positions)) (loop (+ even 1) odd (cdr positions))]
          [else (loop even (+ odd 1) (cdr positions))])))