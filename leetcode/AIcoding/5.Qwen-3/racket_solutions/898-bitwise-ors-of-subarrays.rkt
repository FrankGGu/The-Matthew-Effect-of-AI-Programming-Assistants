(define (subarray-ors nums)
  (define (helper prev res)
    (if (null? nums)
        res
        (let* ((new-prev (map (lambda (x) (bitwise-ior x (car nums))) prev))
              (new-res (cons (car nums) (append new-prev res))))
          (helper (append new-prev (list (car nums))) new-res))))
  (length (remove-duplicates (helper '() '()))))