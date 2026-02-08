(define (min-moves-to-seat-everyone seats people)
  (define (sort-list lst) (sort lst <))
  (define sorted-seats (sort-list seats))
  (define sorted-people (sort-list people))
  (define (sum-diffs s p)
    (if (null? s)
        0
        (+ (abs (- (car s) (car p))) (sum-diffs (cdr s) (cdr p)))))
  (sum-diffs sorted-seats sorted-people))