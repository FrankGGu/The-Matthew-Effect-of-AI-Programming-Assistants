(define (max-satisfaction satisfaction)
  (define (helper s lst)
    (if (null? lst)
        0
        (+ (* (length lst) (car lst)) (helper (add1 s) (cdr lst)))))
  (let loop ((satisfaction (sort satisfaction <)))
    (if (null? satisfaction)
        0
        (max (helper 0 satisfaction) (loop (cdr satisfaction))))))