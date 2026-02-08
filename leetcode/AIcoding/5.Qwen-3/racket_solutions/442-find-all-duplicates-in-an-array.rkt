(define (find-duplicates nums)
  (define (helper nums seen result)
    (cond ((null? nums) result)
          ((member (car nums) seen)
           (helper (cdr nums) seen (cons (car nums) result)))
          (else
           (helper (cdr nums) (cons (car nums) seen) result))))
  (reverse (helper nums '() '())))