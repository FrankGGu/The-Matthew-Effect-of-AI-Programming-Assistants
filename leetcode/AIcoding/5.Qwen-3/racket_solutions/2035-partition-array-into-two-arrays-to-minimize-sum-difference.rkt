(define (can-reach target dp i nums)
  (cond
    [(= i (length nums)) (= target 0)]
    [else
     (or (can-reach target dp (add1 i) nums)
         (and (>= target (list-ref nums i))
              (can-reach (- target (list-ref nums i)) dp (add1 i) nums)))]))

(define (min-sum-difference nums)
  (let* ([total (apply + nums)]
         [target (quotient total 2)]
         [n (length nums)]
         [dp (make-vector (+ n 1) #f)])
    (vector-set! dp 0 #t)
    (for-each
     (lambda (num)
       (for ([i (in-range n -1 -1)])
         (when (vector-ref dp i)
           (vector-set! dp (+ i num) #t))))
     nums)
    (let loop ([i target])
      (if (vector-ref dp i)
          (- total (* 2 i))
          (loop (sub1 i))))))

(define (partition-array-into-two-arrays-to-minimize-sum-difference nums)
  (min-sum-difference nums))