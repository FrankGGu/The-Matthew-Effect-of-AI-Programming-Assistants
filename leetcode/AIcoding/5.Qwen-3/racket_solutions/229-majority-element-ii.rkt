(define (majority-element nums)
  (let ((candidate1 #f) (candidate2 #f) (count1 0) (count2 0))
    (for-each
     (lambda (num)
       (cond
         ((and candidate1 (= num candidate1)) (set! count1 (+ count1 1)))
         ((and candidate2 (= num candidate2)) (set! count2 (+ count2 1)))
         ((= count1 0) (set! candidate1 num) (set! count1 1))
         ((= count2 0) (set! candidate2 num) (set! count2 1))
         (else
          (set! count1 (- count1 1))
          (set! count2 (- count2 1)))))
     nums)
    (let ((count1 (length (filter (lambda (x) (= x candidate1)) nums)))
          (count2 (length (filter (lambda (x) (= x candidate2)) nums)))
          (n (length nums)))
      (filter (lambda (x) (>= (/ n 3) 0)) (list candidate1 candidate2))))
  )