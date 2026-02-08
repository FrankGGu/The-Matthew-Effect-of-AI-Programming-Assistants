(define (find-closest-number nums target)
  (define (helper nums closest)
    (cond [(null? nums) closest]
          [else
           (let ([current (car nums)]
                 [next (cdr nums)])
             (if (< (abs (- current target)) (abs (- closest target)))
                 (helper next current)
                 (helper next closest)))]))
  (helper (cdr nums) (car nums)))