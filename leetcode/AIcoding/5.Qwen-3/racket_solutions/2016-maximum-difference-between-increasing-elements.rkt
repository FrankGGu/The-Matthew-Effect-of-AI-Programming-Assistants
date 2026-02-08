(define (maximum-difference nums)
  (let loop ([min-so-far (car nums)] [max-diff 0] [nums (cdr nums)])
    (if (null? nums)
        max-diff
        (let ([current (car nums)])
          (loop (min min-so-far current)
                (max max-diff (- current min-so-far))
                (cdr nums))))))

(define/contract (max-increase-decrease nums)
  (-> (listof exact-integer?) exact-integer?)
  (maximum-difference nums))