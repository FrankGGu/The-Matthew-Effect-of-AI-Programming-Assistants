(define (min-subarray-scores nums)
  (define (score lst)
    (- (apply max lst) (apply min lst)))
  (define (subarrays lst)
    (let loop ((i 0) (res '()))
      (if (>= i (length lst))
          res
          (loop (+ i 1) (append res (map (lambda (j) (take lst j)) (range i (+ i 4))))))))
  (define (min-diff lst)
    (let ((n (length lst)))
      (if (< n 3)
          #f
          (let ((min-val (apply min lst))
                (max-val (apply max lst)))
            (if (<= (- max-val min-val) 0)
                0
                (let ((subarrs (subarrays lst)))
                  (apply min (map score subarrs))))))))
  (min-diff nums))