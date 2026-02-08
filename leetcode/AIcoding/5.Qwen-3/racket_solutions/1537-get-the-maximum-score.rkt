(define (max-score s1 s2)
  (define (get-indexes str c)
    (for/list ([i (in-range (string-length str))]
               #:when (= (string-ref str i) c))
      i))

  (define (merge a b)
    (let loop ([i 0] [j 0] [res '()])
      (cond [(and (= i (length a)) (= j (length b))) (reverse res)]
            [(= i (length a)) (append (reverse res) (drop b j))]
            [(= j (length b)) (append (reverse res) (drop a i))]
            [else
             (if (< (list-ref a i) (list-ref b j))
                 (loop (+ i 1) j (cons (list-ref a i) res))
                 (loop i (+ j 1) (cons (list-ref b j) res)))])))

  (define (score idxs)
    (let loop ([i 0] [prev -1] [total 0])
      (if (= i (length idxs))
          total
          (let ([current (list-ref idxs i)])
            (if (= prev -1)
                (loop (+ i 1) current total)
                (loop (+ i 1) current (+ total (- current prev)))))))

  (let* ([a (get-indexes s1 #\x)]
         [b (get-indexes s2 #\x)]
         [merged (merge a b)])
    (score merged)))