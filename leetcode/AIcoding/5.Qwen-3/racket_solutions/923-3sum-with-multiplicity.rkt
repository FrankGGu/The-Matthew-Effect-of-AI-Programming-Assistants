(define (three-sum-multiplicity A target)
  (define mod 1000000007)
  (define count (make-hash))
  (for ([num A])
    (hash-set! count num (+ 1 (hash-ref count num 0))))
  (define keys (hash-keys count))
  (define result 0)
  (for ([i keys])
    (for ([j keys])
      (when (<= j i)
        (define k (- target i j))
        (cond
          [(and (= i j) (= j k))
           (when (>= (hash-ref count i) 3)
             (set! result (+ result (/ (* (hash-ref count i) (- (hash-ref count i) 1) (- (hash-ref count i) 2)) 6))))]
          [(and (= i j) (= j k))
           (void)]
          [(and (= i j) (not (= j k)))
           (when (>= (hash-ref count i) 2)
             (set! result (+ result (* (hash-ref count i) (- (hash-ref count i) 1) (hash-ref count k)) )))]
          [(and (= i k) (not (= i j)))
           (when (>= (hash-ref count i) 2)
             (set! result (+ result (* (hash-ref count i) (- (hash-ref count i) 1) (hash-ref count j)) )))]
          [(and (= j k) (not (= i j)))
           (when (>= (hash-ref count j) 2)
             (set! result (+ result (* (hash-ref count j) (- (hash-ref count j) 1) (hash-ref count i)) )))]
          [(and (not (= i j)) (not (= i k)) (not (= j k)))
           (when (and (hash-has-key? count i) (hash-has-key? count j) (hash-has-key? count k))
             (set! result (+ result (* (hash-ref count i) (hash-ref count j) (hash-ref count k)) )))]))))
  (modulo result mod))