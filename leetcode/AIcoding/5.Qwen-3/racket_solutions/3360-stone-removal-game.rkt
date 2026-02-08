(define (can-lose n)
  (if (<= n 1)
      #t
      (not (can-lose (- n 1)))))

(define (can-lose? n)
  (if (<= n 1)
      #t
      (not (can-lose? (- n 1)))))

(define (stone-removal-game n)
  (if (even? n)
      #f
      #t))