(define (product-of-the-last-k-numbers)
  (let ((nums '()))
    (lambda (x)
      (set! nums (append nums (list x)))
      (let loop ((i (- (length nums) 1)) (prod 1))
        (if (or (< i (- (length nums) (if (<= (length nums) 1000) (length nums) 1000))) (= i -1))
            prod
            (loop (- i 1) (* prod (list-ref nums i))))))))