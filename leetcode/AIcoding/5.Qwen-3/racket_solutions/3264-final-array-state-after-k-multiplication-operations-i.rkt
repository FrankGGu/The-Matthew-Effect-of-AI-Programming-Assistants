(define (get-final-array-state nums k)
  (define (helper nums k)
    (if (= k 0)
        nums
        (let* ([n (length nums)]
               [new-nums (make-vector n 0)])
          (for ([i (in-range n)])
            (vector-set! new-nums i (* (vector-ref nums i) (vector-ref nums (- n 1)))))
          (helper (vector->list new-nums) (- k 1)))))
  (list->vector (helper (list->vector nums) k)))