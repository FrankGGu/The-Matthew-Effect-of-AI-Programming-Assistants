(define (substrings s)
  (define len (string-length s))
  (for/list ([i (in-range len)])
    (for/list ([j (in-range i len)])
      (substring s i (add1 j)))))

(define (beauty s)
  (define len (string-length s))
  (define-values (min1 min2) (values #f #f))
  (for ([c (in-string s)])
    (cond
      [(or (not min1) (< c min1)) (set! min2 min1) (set! min1 c)]
      [(or (not min2) (< c min2)) (set! min2 c)]))
  (if (and min1 min2)
      (- min2 min1)
      0))

(define (sum-of-beauty s)
  (define subs (substrings s))
  (apply + (map beauty subs)))