(define (min-operations nums)
  (define freq (make-hash))
  (for-each (lambda (n) (hash-set! freq n (+ 1 (hash-ref freq n 0)))) nums)
  (define sorted-freq (sort (hash-values freq) >))
  (let loop ((sum 0) (i 0))
    (if (>= sum (/ (length nums) 2))
        i
        (loop (+ sum (list-ref sorted-freq i)) (+ i 1)))))