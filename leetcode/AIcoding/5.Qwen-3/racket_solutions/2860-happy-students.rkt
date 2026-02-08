(define (happy-students nums)
  (define (helper i cnt)
    (if (>= i (length nums))
        cnt
        (let ((n (list-ref nums i)))
          (if (and (<= 1 n) (<= n (length nums)) (not (= n i)))
              (helper (+ i 1) (+ cnt 1))
              (helper (+ i 1) cnt)))))
  (helper 0 0))