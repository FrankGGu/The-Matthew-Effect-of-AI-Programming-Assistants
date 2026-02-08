(define (remove-duplicates nums)
  (if (null? nums)
      0
      (let loop ([i 1] [count 1] [prev (car nums)] [nums (cdr nums)])
        (if (null? nums)
            count
            (let ([current (car nums)])
              (if (= current prev)
                  (loop (+ i 1) count prev (cdr nums))
                  (begin
                    (set! nums (cons current (cdr nums)))
                    (loop (+ i 1) (+ count 1) current (cdr nums)))))))))