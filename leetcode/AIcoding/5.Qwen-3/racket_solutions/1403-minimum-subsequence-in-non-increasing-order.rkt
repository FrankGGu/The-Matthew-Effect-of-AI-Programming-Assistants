(define (smaller-arrangement nums)
  (define (helper nums sorted)
    (if (null? nums)
        sorted
        (let ((max-val (apply max nums)))
          (helper (remove max-val nums) (cons max-val sorted)))))
  (reverse (helper nums '())))