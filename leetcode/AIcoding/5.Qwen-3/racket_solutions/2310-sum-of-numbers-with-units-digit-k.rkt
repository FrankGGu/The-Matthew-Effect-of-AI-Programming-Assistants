(define (get-money-spent k)
  (let loop ((n 0) (sum 0))
    (if (> sum 1000000)
        (- sum k)
        (loop (+ n 1) (+ sum (if (= (modulo n 10) k) n 0))))))

(define (main)
  (define k (read))
  (display (get-money-spent k)))

(main)