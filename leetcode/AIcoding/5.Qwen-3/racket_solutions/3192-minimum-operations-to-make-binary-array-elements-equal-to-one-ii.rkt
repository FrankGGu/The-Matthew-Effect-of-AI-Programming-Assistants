(define (min-operations nums)
  (define (count-ones lst)
    (cond ((null? lst) 0)
          ((= (car lst) 1) (+ 1 (count-ones (cdr lst))))
          (else (count-ones (cdr lst)))))

  (define (process lst ops)
    (cond ((null? lst) ops)
          ((= (car lst) 1) (process (cdr lst) ops))
          (else
           (let ((next (cadr lst)))
             (if (null? (cdr lst))
                 (process (cdr lst) (+ ops 1))
                 (process (cddr lst) (+ ops 1)))))))

  (if (= (count-ones nums) 0)
      (if (= (length nums) 1)
          0
          (if (= (modulo (length nums) 2) 0)
              -1
              0))
      (process nums 0)))