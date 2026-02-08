(define (can-make-amount coins)
  (let loop ((sum 0) (coins coins))
    (cond ((null? coins) #t)
          ((<= (car coins) (+ sum 1)) (loop (+ sum (car coins)) (cdr coins)))
          (else #f))))

(define (maximum-consecutive-values coins)
  (let loop ((sum 0) (coins coins))
    (cond ((null? coins) sum)
          ((<= (car coins) (+ sum 1)) (loop (+ sum (car coins)) (cdr coins)))
          (else sum))))

(define (main)
  (let ((input (read)))
    (display (maximum-consecutive-values input))
    (newline)))

(main)