(define (distinct-numbers-on-board n)
  (define (helper count seen)
    (if (= count n)
        (length seen)
        (let* ([new-count (+ count 1)]
               [new-seen (set-add seen new-count)])
          (helper new-count new-seen))))
  (helper 1 (set)))