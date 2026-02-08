(define (easy-way nums)
  (let ((nums (sort nums <)))
    (for/sum ((i (in-range 0 (- (length nums) 1) 2)))
      (- (list-ref nums (+ i 1)) (list-ref nums i)))))

(define (main)
  (let ((input (read)))
    (display (easy-way input))))

(main)