(define (count-coin coins)
  (let loop ((coins coins) (count 0))
    (if (null? coins)
        count
        (loop (cdr coins) (+ count (car coins))))))

(define (min-count coins)
  (let ((total (count-coin coins)))
    (let loop ((coins coins) (count 0) (sum 0))
      (if (>= sum (/ total 2))
          count
          (loop (cdr coins) (+ count 1) (+ sum (car coins)))))))

(define (get-remaining-coins coins)
  (let loop ((coins coins) (count 0) (sum 0) (result '()))
    (if (>= sum (/ (count-coin coins) 2))
        (reverse result)
        (loop (cdr coins) (+ count 1) (+ sum (car coins)) (cons (car coins) result)))))

(define (get-min-operations coins)
  (let ((remaining (get-remaining-coins coins)))
    (let loop ((remaining remaining) (operations 0))
      (if (null? remaining)
          operations
          (loop (cdr remaining) (+ operations (quotient (car remaining) 2)))))))

(define (min-operations coins)
  (get-min-operations coins))