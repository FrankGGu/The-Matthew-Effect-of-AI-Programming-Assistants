(define (get-target-clone original target)
  (cond [(null? original) #f]
        [(equal? original target) original]
        [else (let ([left (get-target-clone (original-left original) (target-left target))])
                (if left left (get-target-clone (original-right original) (target-right target))))]))