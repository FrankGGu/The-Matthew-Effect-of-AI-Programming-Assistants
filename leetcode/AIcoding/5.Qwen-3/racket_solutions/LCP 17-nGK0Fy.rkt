(define (calculate s)
  (define (helper i num stack)
    (cond [(= i (string-length s)) (apply + stack)]
          [(char=? #\+ (string-ref s i)) (helper (+ i 1) (string->number (substring s i (+ i 1))) (cons num stack))]
          [(char=? #\- (string-ref s i)) (helper (+ i 1) (string->number (substring s i (+ i 1))) (cons (- 0 num) stack))]
          [else (helper (+ i 1) (+ (* num 10) (string->number (substring s i (+ i 1)))) stack)]))
  (helper 0 0 '()))