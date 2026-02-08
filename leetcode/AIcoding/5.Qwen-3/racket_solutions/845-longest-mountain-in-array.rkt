(define (longest-mountain arr)
  (define n (length arr))
  (if (< n 3) 0
      (let loop ([i 1] [max-length 0] [up #f] [current-length 0])
        (cond [(= i n) max-length]
              [(and up (> (list-ref arr i) (list-ref arr (sub1 i)))) (loop (add1 i) max-length up (add1 current-length))]
              [(and up (= (list-ref arr i) (list-ref arr (sub1 i)))) (loop (add1 i) (max max-length current-length) #f 0)]
              [(and up (< (list-ref arr i) (list-ref arr (sub1 i)))) (loop (add1 i) (max max-length current-length) #f 0)]
              [(< (list-ref arr i) (list-ref arr (sub1 i))) (loop (add1 i) max-length #f 0)]
              [(> (list-ref arr i) (list-ref arr (sub1 i))) (loop (add1 i) max-length #t 1)]
              [else (loop (add1 i) max-length #f 0)]))))