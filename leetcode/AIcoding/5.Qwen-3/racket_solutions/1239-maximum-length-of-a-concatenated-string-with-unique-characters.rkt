(define (max-length-unique-characters strings)
  (define (has-unique-chars s)
    (= (length (remove-duplicates (string->list s))) (string-length s)))

  (define (combine a b)
    (if (has-unique-chars (string-append a b))
        (string-append a b)
        #f))

  (define (backtrack idx current)
    (if (>= idx (length strings))
        (string-length current)
        (let ((option1 (backtrack (+ idx 1) current)))
          (if (has-unique-chars (string-append current (list-ref strings idx)))
              (max option1 (backtrack (+ idx 1) (string-append current (list-ref strings idx))))
              option1))))

  (backtrack 0 ""))