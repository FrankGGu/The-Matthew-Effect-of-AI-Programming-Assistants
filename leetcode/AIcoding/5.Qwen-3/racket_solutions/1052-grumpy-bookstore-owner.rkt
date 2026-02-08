(define (max-attended-customers customers waiting-time)
  (define n (length customers))
  (define initial (apply + (map * customers waiting-time)))
  (define max-add (let loop ([i 0] [current 0] [max-add 0])
                    (if (= i n)
                        max-add
                        (let ([new-current (+ current (if (= (list-ref waiting-time i) 0) (list-ref customers i) 0))])
                          (loop (+ i 1) new-current (max max-add new-current))))))
  (max initial max-add))