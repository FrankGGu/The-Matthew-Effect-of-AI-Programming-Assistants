(define (max-subsequence-sum nums)
  (define (helper prev curr index)
    (if (>= index (length nums))
        curr
        (let ((new-curr (max curr (+ prev (list-ref nums index)))))
          (helper curr new-curr (+ index 1)))))
  (if (null? nums)
      0
      (helper 0 0 0)))