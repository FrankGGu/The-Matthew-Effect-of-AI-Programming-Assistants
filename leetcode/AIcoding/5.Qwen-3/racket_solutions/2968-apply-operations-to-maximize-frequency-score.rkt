(define (max-frequency nums k)
  (define (score freq)
    (let loop ([i 0] [total 0] [max-score 0])
      (if (= i (vector-length freq))
          max-score
          (let* ([count (vector-ref freq i)]
                 [cost (* count (- i (vector-ref freq 0)))]
                 [new-total (+ total cost)])
            (if (> new-total k)
                (loop (+ i 1) (- total (vector-ref freq 0)) max-score)
                (loop (+ i 1) new-total (max max-score count)))))))
  (define freq (make-vector 100001 0))
  (for-each (lambda (n) (vector-set! freq n (+ (vector-ref freq n) 1))) nums)
  (score freq))