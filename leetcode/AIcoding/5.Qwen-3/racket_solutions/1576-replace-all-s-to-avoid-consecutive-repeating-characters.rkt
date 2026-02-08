(define (modify-string s)
  (define (f i)
    (cond [(>= i (string-length s)) ""]
          [(char=? #\? (string-ref s i))
           (let ([c (if (and (>= i 1) (char=? #\? (string-ref s (- i 1))))
                        (if (and (< i (sub1 (string-length s))) (char=? #\? (string-ref s (+ i 1))))
                            #\a
                            #\a)
                        (if (and (< i (sub1 (string-length s))) (char=? #\? (string-ref s (+ i 1))))
                            #\a
                            #\a)))]
             (string-append (string c) (f (+ i 1))))]
          [else (string-append (string (string-ref s i)) (f (+ i 1)))]))
  (f 0))