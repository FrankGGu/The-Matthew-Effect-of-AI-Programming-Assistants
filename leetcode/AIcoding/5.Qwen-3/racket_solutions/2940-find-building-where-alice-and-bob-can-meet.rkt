(define (can-meet a b)
  (let ([len (length a)])
    (let loop ([i 0] [j 0] [res '()])
      (cond [(or (= i len) (= j len)) (reverse res)]
            [(= (list-ref a i) (list-ref b j))
             (loop (+ i 1) (+ j 1) (cons (list-ref a i) res))]
            [(< (list-ref a i) (list-ref b j))
             (loop (+ i 1) j res)]
            [else
             (loop i (+ j 1) res)]))))

(define (find-mid a b)
  (let ([common (can-meet a b)])
    (if (null? common)
        -1
        (let ([mid (quotient (length common) 2)])
          (list-ref common mid)))))