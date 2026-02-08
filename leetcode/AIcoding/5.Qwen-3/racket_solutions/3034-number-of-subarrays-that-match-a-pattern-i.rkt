(define (count-matching-subarrays nums pat)
  (define n (length nums))
  (define m (length pat))
  (define (match i j)
    (cond [(= j m) #t]
          [(and (< i n) (= (list-ref nums i) (list-ref pat j))) (match (+ i 1) (+ j 1))]
          [else #f]))
  (define (helper i res)
    (if (>= i n)
        res
        (helper (+ i 1) (if (match i 0) (+ res 1) res))))
  (helper 0 0))