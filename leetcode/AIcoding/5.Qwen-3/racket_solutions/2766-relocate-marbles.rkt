(define (can-apply? pos moves)
  (and (>= pos 0) (<= pos (length moves))))

(define (relocate-marbles position move)
  (let loop ([pos position] [moves move] [res '()])
    (cond
      [(null? moves) (reverse res)]
      [else
       (let* ([m (car moves)]
              [new-pos (+ pos m)])
         (if (can-apply? new-pos (cdr moves))
             (loop new-pos (cdr moves) (cons new-pos res))
             (loop pos (cdr moves) res)))])))