(define (sort-even-odd nums)
  (let* ([even (filter (lambda (x) (= (remainder x 2) 0)) (range (length nums)))]
         [odd (filter (lambda (x) (= (remainder x 2) 1)) (range (length nums)))]
         [even-values (map (lambda (i) (list-ref nums i)) even)]
         [odd-values (map (lambda (i) (list-ref nums i)) odd)]
         [sorted-even (sort even-values <)]
         [sorted-odd (sort odd-values <)]
         [result (make-list (length nums) 0)])
    (for-each (lambda (i v) (set! result (list-set result i v)) ) even sorted-even)
    (for-each (lambda (i v) (set! result (list-set result i v)) ) odd sorted-odd)
    result))