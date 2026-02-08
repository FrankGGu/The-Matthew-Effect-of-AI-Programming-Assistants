#lang racket

(define (grid-illumination n queries)
  (define (count-map m)
    (for/fold ([res '()]) ([k (in-hash-keys m)])
      (cons (cons k (hash-ref m k)) res)))

  (define (remove-key m k)
    (for/hash ([k2 (in-hash-keys m)]
               [v2 (in-hash-values m)])
      (when (not (= k2 k))
        (values k2 v2))))

  (define (add-key m k v)
    (hash-set m k v))

  (define (get-key m k)
    (hash-ref m k 0))

  (define (make-illuminated n)
    (let ([rows (make-hash)]
          [cols (make-hash)]
          [diag1 (make-hash)]
          [diag2 (make-hash)]
          [lights (set)])
      (for ([i (in-range n)]
            [j (in-range n)])
        (when (hash-has-key? lights (cons i j))
          (hash-set! rows i (+ (hash-ref rows i 0) 1))
          (hash-set! cols j (+ (hash-ref cols j 0) 1))
          (hash-set! diag1 (+ i j) (+ (hash-ref diag1 (+ i j) 0) 1))
          (hash-set! diag2 (- i j) (+ (hash-ref diag2 (- i j) 0) 1))))
      (values rows cols diag1 diag2 lights)))

  (define (query-illuminated q rows cols diag1 diag2 lights)
    (let ([i (car q)]
          [j (cadr q)])
      (if (or (> (get-key rows i) 0)
              (> (get-key cols j) 0)
              (> (get-key diag1 (+ i j)) 0)
              (> (get-key diag2 (- i j)) 0))
          1
          0)))

  (define (remove-light i j rows cols diag1 diag2 lights)
    (let ([new-lights (set-remove lights (cons i j))])
      (when (hash-has-key? lights (cons i j))
        (hash-set! rows i (- (hash-ref rows i 0) 1))
        (hash-set! cols j (- (hash-ref cols j 0) 1))
        (hash-set! diag1 (+ i j) (- (hash-ref diag1 (+ i j) 0) 1))
        (hash-set! diag2 (- i j) (- (hash-ref diag2 (- i j) 0) 1)))
      new-lights))

  (let ([rows (make-hash)]
        [cols (make-hash)]
        [diag1 (make-hash)]
        [diag2 (make-hash)]
        [lights (set)])
    (for ([q queries])
      (let ([i (car q)]
            [j (cadr q)])
        (when (hash-has-key? lights (cons i j))
          (hash-set! rows i (+ (hash-ref rows i 0) 1))
          (hash-set! cols j (+ (hash-ref cols j 0) 1))
          (hash-set! diag1 (+ i j) (+ (hash-ref diag1 (+ i j) 0) 1))
          (hash-set! diag2 (- i j) (+ (hash-ref diag2 (- i j) 0) 1))))
      (set-add! lights (cons i j)))

    (for/list ([q queries])
      (let ([i (car q)]
            [j (cadr q)])
        (if (or (> (get-key rows i) 0)
                (> (get-key cols j) 0)
                (> (get-key diag1 (+ i j)) 0)
                (> (get-key diag2 (- i j)) 0))
            1
            0)))
    (for-each (lambda (q)
                (let ([i (car q)]
                      [j (cadr q)])
                  (when (hash-has-key? lights (cons i j))
                    (hash-set! rows i (- (hash-ref rows i 0) 1))
                    (hash-set! cols j (- (hash-ref cols j 0) 1))
                    (hash-set! diag1 (+ i j) (- (hash-ref diag1 (+ i j) 0) 1))
                    (hash-set! diag2 (- i j) (- (hash-ref diag2 (- i j) 0) 1))
                    (set-remove! lights (cons i j))))
              queries)
    (for/list ([q queries])
      (let ([i (car q)]
            [j (cadr q)])
        (if (or (> (get-key rows i) 0)
                (> (get-key cols j) 0)
                (> (get-key diag1 (+ i j)) 0)
                (> (get-key diag2 (- i j)) 0))
            1
            0)))))