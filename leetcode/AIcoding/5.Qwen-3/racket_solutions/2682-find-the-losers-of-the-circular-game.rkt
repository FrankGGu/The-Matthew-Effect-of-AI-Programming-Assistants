(define (find-losers n ands)
  (define (game n ands)
    (let loop ([players (range 1 (add1 n))]
               [current 0]
               [turn 0])
      (if (= (length players) 1)
          players
          (let* ([next (modulo (+ current 1) (length players))]
                 [loser (list-ref players next)])
            (loop (remove loser players) next (add1 turn))))))
  (let ([winners (game n ands)])
    (for/list ([i (in-range 1 (add1 n))])
      (if (member i winners) #f i))))