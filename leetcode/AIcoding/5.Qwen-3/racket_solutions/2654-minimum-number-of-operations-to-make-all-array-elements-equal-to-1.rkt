(define (min-operations nums)
  (define (count-ones lst)
    (cond ((null? lst) 0)
          ((= (car lst) 1) (+ 1 (count-ones (cdr lst))))
          (else (count-ones (cdr lst)))))
  (define (count-gcd lst)
    (if (null? lst)
        0
        (let ((g (gcd (car lst) (cadr lst))))
          (if (null? (cddr lst))
              g
              (count-gcd (cons g (cddr lst)))))))
  (let ((ones (count-ones nums)))
    (if (= ones (length nums))
        0
        (let ((gcd-val (count-gcd nums)))
          (+ (- (length nums) ones) (if (= gcd-val 1) 0 (- (log (abs gcd-val)) (log 2)) ))))))

(define (log x)
  (exact-floor (log x 2)))