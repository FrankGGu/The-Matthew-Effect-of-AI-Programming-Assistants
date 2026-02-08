(define (max-profit prices)
  (define (helper i prev-cooldown)
    (cond [(>= i (length prices)) 0]
          [else
           (let ([current-price (list-ref prices i)])
             (if prev-cooldown
                 (max (+ (helper (+ i 1) #f) (- current-price (list-ref prices (- i 1))))
                      (helper (+ i 1) #f))
                 (max (helper (+ i 1) #f)
                      (+ (helper (+ i 1) #t) (- current-price (list-ref prices (- i 1)))))))]))
  (helper 0 #f))