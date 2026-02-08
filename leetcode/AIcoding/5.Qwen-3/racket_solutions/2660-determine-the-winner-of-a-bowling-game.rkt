(define (is-integer? x)
  (and (number? x) (integer? x)))

(define (is-strike? roll)
  (= roll 10))

(define (is-spare? rolls i)
  (and (< i (- (length rolls) 1))
       (= (+ (list-ref rolls i) (list-ref rolls (+ i 1))) 10)))

(define (score-game rolls)
  (define (score-helper i score)
    (cond [(= i (length rolls)) score]
          [(is-strike? (list-ref rolls i))
           (score-helper (+ i 1) (+ score 10 (list-ref rolls (+ i 1)) (list-ref rolls (+ i 2))))]
          [(is-spare? rolls i)
           (score-helper (+ i 2) (+ score 10 (list-ref rolls (+ i 2))))]
          [else
           (score-helper (+ i 1) (+ score (list-ref rolls i)))]))
  (score-helper 0 0))

(define (is-better? player1 player2)
  (> (score-game player1) (score-game player2)))

(define (winner player1 player2)
  (if (is-better? player1 player2) "Player 1" "Player 2"))