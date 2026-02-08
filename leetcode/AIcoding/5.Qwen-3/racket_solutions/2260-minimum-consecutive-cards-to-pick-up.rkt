(define/contract (minimum-card-pick-up cards)
  (-> (listof exact-integer?) exact-integer?)
  (let ([map (make-hash)])
    (let loop ([i 0] [min-len +inf.0])
      (if (= i (length cards))
          min-len
          (let ([card (list-ref cards i)])
            (if (hash-has-key? map card)
                (loop (+ i 1) (min min-len (- i (hash-ref map card))))
                (begin
                  (hash-set! map card i)
                  (loop (+ i 1) min-len)))))))
  )