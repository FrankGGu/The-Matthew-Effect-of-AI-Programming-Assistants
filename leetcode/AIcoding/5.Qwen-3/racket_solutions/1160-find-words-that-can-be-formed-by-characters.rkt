(define (count-words-by-characters words chars)
  (define (char-count s)
    (for/fold ([cnt (hash)]) ([c s])
      (hash-update cnt c add1 0)))
  (define chars-count (char-count chars))
  (for/sum ([word words]
            #:when (andmap (lambda (k) (<= (hash-ref (char-count word) k 0) (hash-ref chars-count k 0))) (hash-keys (char-count word))))
    1))

(define (main)
  (let* ([input (read-line)]
         [words (map (lambda (s) (substring s 1 (- (string-length s) 1))) (string-split input #\,))]
         [chars (read-line)])
    (display (count-words-by-characters words chars))))

(main)