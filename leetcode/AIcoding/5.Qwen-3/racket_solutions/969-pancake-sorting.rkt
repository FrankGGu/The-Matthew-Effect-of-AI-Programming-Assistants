(define (pancake-sort arr)
  (define (flip! arr k)
    (let loop ((i 0) (j (sub1 k)))
      (when (<= i j)
        (let ((temp (vector-ref arr i)))
          (vector-set! arr i (vector-ref arr j))
          (vector-set! arr j temp)
          (loop (add1 i) (sub1 j)))))
    arr)

  (define (find-max-index arr n)
    (let loop ((i 0) (max-index 0))
      (if (= i n)
          max-index
          (loop (add1 i) (if (> (vector-ref arr i) (vector-ref arr max-index)) i max-index)))))

  (let loop ((n (vector-length arr)) (result '()))
    (if (= n 1)
        result
        (let* ((max-index (find-max-index arr (sub1 n)))
               (result (if (= max-index (sub1 n))
                           result
                           (cons (add1 (add1 max-index)) result)))
               (arr (flip! arr (add1 max-index)))
               (result (if (= max-index (sub1 n))
                           result
                           (cons (add1 n) result)))
               (arr (flip! arr n)))
          (loop (sub1 n) result))))
  )