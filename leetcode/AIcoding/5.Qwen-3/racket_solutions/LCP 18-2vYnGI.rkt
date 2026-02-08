(define (max-amount menu cost)
  (define (dfs index remaining)
    (if (<= remaining 0)
        (- cost remaining)
        (if (>= index (length menu))
            0
            (max (dfs (+ index 1) (- remaining (list-ref menu index)))
                 (dfs (+ index 1) remaining)))))
  (dfs 0 cost))