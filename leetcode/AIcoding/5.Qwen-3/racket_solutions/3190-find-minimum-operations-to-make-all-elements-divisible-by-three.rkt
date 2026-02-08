(define (minimum-operations nums)
  (define (count-mod m)
    (length (filter (lambda (x) (= (modulo x 3) m)) nums)))
  (let ([c0 (count-mod 0)]
        [c1 (count-mod 1)]
        [c2 (count-mod 2)])
    (cond [(= c0 (length nums)) 0]
          [(and (= c1 0) (= c2 0)) 0]
          [(and (= c1 0) (> c2 0)) (+ c2 1)]
          [(and (= c2 0) (> c1 0)) (+ c1 1)]
          [else (min (+ c1 1) (+ c2 1))])))