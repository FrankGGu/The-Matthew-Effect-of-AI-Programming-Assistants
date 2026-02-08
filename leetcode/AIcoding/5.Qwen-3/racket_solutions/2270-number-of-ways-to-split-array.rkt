(define (num-ways nums)
  (let ((total (apply + nums)))
    (let loop ((i 0) (sum 0) (count 0))
      (if (= i (- (length nums) 1))
          count
          (let ((new-sum (+ sum (list-ref nums i))))
            (loop (+ i 1) new-sum (if (= new-sum (- total new-sum)) (+ count 1) count)))))))