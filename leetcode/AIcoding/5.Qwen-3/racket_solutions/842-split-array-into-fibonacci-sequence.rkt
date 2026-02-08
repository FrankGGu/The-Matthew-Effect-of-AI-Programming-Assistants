(define (split-into-fib-sequence s)
  (define (is-valid? s a b)
    (let loop ((s s) (prev1 a) (prev2 b))
      (if (string=? s "")
          #t
          (let ((n (string-length s)))
            (if (>= n 3)
                (let ((current (string->number (substring s 0 3))))
                  (if (and (= current (+ prev1 prev2)) (loop (substring s 3) prev2 current))
                      #t
                      #f))
                (let ((current (string->number (substring s 0 (min 2 n)))))
                  (if (and (= current (+ prev1 prev2)) (loop (substring s (min 2 n)) prev2 current))
                      #t
                      #f)))))))

  (let loop ((i 1) (result '()))
    (if (> i (- (string-length s) 1))
        #f
        (let ((a (string->number (substring s 0 i))))
          (let loop2 ((j 1))
            (if (> j (- (string-length s) i 1))
                #f
                (let ((b (string->number (substring s i (+ i j)))))
                  (if (is-valid? (substring s (+ i j)) a b)
                      (append result (list a b) (reverse (take (split-into-fib-sequence (substring s (+ i j)) a b) 100)))
                      (loop2 (+ j 1))))))))))