(define (min-swaps-same s1 s2)
  (define (count-chars str)
    (let ([a 0] [b 0])
      (for-each (lambda (c)
                  (cond [(char=? c #\a) (set! a (+ a 1))]
                        [(char=? c #\b) (set! b (+ b 1))]))
                (string->list str))
      (cons a b)))
  (let* ([cnt1 (count-chars s1)]
         [cnt2 (count-chars s2)]
         [diff-a (- (car cnt1) (car cnt2))]
         [diff-b (- (cadr cnt1) (cadr cnt2))])
    (if (or (not (zero? diff-a)) (not (zero? diff-b)))
        -1
        (let ([swap-a (quotient (abs diff-a) 2)])
          (if (even? (abs diff-a))
              swap-a
              (+ swap-a 1))))))

(define (min-swaps-strings s1 s2)
  (if (equal? s1 s2)
      0
      (let ([diff-a (string-length (string-filter (lambda (c) (char=? c #\a)) (string-map (lambda (c1 c2) (if (char=? c1 c2) #\0 c1)) s1 s2)))]
            [diff-b (string-length (string-filter (lambda (c) (char=? c #\b)) (string-map (lambda (c1 c2) (if (char=? c1 c2) #\0 c1)) s1 s2)))])
        (if (or (odd? diff-a) (odd? diff-b))
            -1
            (quotient (+ diff-a diff-b) 2)))))

(define (string-filter pred str)
  (list->string (filter pred (string->list str))))

(define (string-map f s1 s2)
  (list->string (map f (string->list s1) (string->list s2))))