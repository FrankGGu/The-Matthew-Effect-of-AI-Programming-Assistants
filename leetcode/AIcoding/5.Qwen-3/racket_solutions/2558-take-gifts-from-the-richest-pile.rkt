(define/contract (pick-gifts gifts k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define (sqrt-floor n)
    (floor (sqrt n)))
  (define (take-gifts-helper gifts k)
    (if (= k 0)
        (apply + gifts)
        (let* ([max-val (apply max gifts)]
               [index (for/first ([i (in-range (length gifts))] #:when (= (list-ref gifts i) max-val) #:break #t) i)]
               [new-val (sqrt-floor max-val)])
          (take-gifts-helper (list-set gifts index new-val) (- k 1)))))
  (take-gifts-helper gifts k))