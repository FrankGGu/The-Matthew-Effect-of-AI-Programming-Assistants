(define (most-words-found sentences)
  (define (count-words s)
    (length (string-split s)))
  (apply max (map count-words sentences)))