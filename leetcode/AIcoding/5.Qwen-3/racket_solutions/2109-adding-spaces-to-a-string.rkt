(define (add-spaces s words)
  (define word-set (list->set words))
  (define len (string-length s))
  (define result (make-string len #\space))
  (define (helper i j)
    (cond [(= i len) result]
          [(and (< j (length words)) (equal? (substring s i (+ i (string-length (list-ref words j)))) (list-ref words j)))
           (begin
             (string-set! result i #\space)
             (helper (+ i 1) (+ j 1)))
           ]
          [else
           (begin
             (string-set! result i (string-ref s i))
             (helper (+ i 1) j))]))
  (helper 0 0))