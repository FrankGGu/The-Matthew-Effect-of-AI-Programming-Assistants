(define (sum-of-unique-elements nums)
  (define (count-freq lst)
    (let loop ((lst lst) (freq '()))
      (if (null? lst)
          freq
          (let* ((num (car lst))
                 (entry (assoc num freq)))
            (if entry
                (loop (cdr lst) (cons (cons num (+ 1 (cdr entry))) (remove entry freq)))
                (loop (cdr lst) (cons (cons num 1) freq)))))))
  (define (sum-unique freq)
    (foldl (lambda (pair sum)
             (if (= (cdr pair) 1)
                 (+ sum (car pair))
                 sum))
           0
           freq))
  (sum-unique (count-freq nums)))