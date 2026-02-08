(define (minimum-length-of-string-after-deleting-similar-ends s)
  (define (helper left right)
    (cond [(> left right) 0]
          [(char=? (string-ref s left) (string-ref s right))
           (let loop ([l left] [r right])
             (if (and (<= l r) (char=? (string-ref s l) (string-ref s r)))
                 (loop (+ l 1) (- r 1))
                 (- r l 1)))]
          [else (- right left 1)]))
  (helper 0 (- (string-length s) 1)))