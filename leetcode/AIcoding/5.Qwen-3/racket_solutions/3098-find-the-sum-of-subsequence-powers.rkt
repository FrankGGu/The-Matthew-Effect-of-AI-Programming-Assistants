(define (sum-subsequence-powers nums)
  (define (pow x y)
    (expt x y))
  (define (helper nums index power sum)
    (if (= index (length nums))
        sum
        (let ((num (list-ref nums index)))
          (helper nums (+ index 1) (+ power 1) (+ sum (pow num power))))))
  (helper nums 0 1 0))