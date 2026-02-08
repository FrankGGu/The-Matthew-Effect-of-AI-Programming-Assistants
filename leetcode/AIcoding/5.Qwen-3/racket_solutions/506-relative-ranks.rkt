(define (find-athlete-ranks nums)
  (define sorted (sort nums >))
  (define rank-map (for/hash ((i (in-range (length sorted))) (num sorted))
                      (values num (+ i 1))))
  (map (lambda (n) (if (= (hash-ref rank-map n) 1) "Gold Medal"
                       (if (= (hash-ref rank-map n) 2) "Silver Medal"
                           (if (= (hash-ref rank-map n) 3) "Bronze Medal"
                               (number->string (hash-ref rank-map n))))))
       nums))