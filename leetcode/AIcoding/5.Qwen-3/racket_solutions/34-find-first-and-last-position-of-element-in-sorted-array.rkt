(define (search-range nums target)
  (define (binary-search left right first?)
    (let loop ([l left] [r right] [res -1])
      (cond [(> l r) res]
            [else
             (let* ([mid (quotient (+ l r) 2)]
                    [val (list-ref nums mid)])
               (if (= val target)
                   (if first?
                       (loop l (- mid 1) mid)
                       (loop (+ mid 1) r mid))
                   (if (< val target)
                       (loop (+ mid 1) r res)
                       (loop l (- mid 1) res))))])))
  (let ([left (binary-search 0 (- (length nums) 1) #t)])
    (if (= left -1)
        '(-1 -1)
        (let ([right (binary-search left (- (length nums) 1) #f)])
          (list left right)))))

(define/contract (search-insert-position nums target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([l 0] [r (- (length nums) 1)])
    (cond [(> l r) l]
          [else
           (let* ([mid (quotient (+ l r) 2)]
                  [val (list-ref nums mid)])
             (if (< val target)
                 (loop (+ mid 1) r)
                 (loop l (- mid 1))))])))

(define/contract (search-range-wrapper nums target)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (search-range nums target))