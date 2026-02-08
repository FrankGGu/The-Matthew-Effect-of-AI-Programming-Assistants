(define (find-unique-value nums)
  (let ([min-val (apply min nums)]
        [max-val (apply max nums)])
    (for/first ([n nums] #:unless (or (= n min-val) (= n max-val))) n)))