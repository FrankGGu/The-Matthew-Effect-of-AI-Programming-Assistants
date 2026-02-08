(define (make-rand-pick weights)
  (let* ([prefix-sum (foldl (lambda (w acc) (cons (+ (car acc) w) acc)) '(0) weights)]
         [total (last prefix-sum)])
    (lambda ()
      (let loop ([i 0])
        (if (<= (random total) (list-ref prefix-sum i))
            i
            (loop (+ i 1)))))))