(define/contract (can-reach-end nums)
  (-> (listof exact-integer?) boolean?)
  (let loop ([i 0] [max-reach 0])
    (cond [(>= i (length nums)) #t]
          [(> i max-reach) #f]
          [else (loop (+ i 1) (max max-reach (+ i (list-ref nums i))))])))