(define (three-sum nums)
  (define (two-sum start target)
    (define (helper i j res)
      (cond [(>= i j) res]
            [(= (+ (list-ref nums i) (list-ref nums j)) target)
             (helper (add1 i) (sub1 j) (cons (list (list-ref nums i) (list-ref nums j)) res))]
            [(< (+ (list-ref nums i) (list-ref nums j)) target)
             (helper (add1 i) j res)]
            [else (helper i (sub1 j) res)]))
    (helper start (- target) '()))
  (define (loop i res)
    (cond [(>= i (- (length nums) 2)) res]
          [(and (> i 0) (= (list-ref nums i) (list-ref nums (sub1 i)))) (loop (add1 i) res)]
          [else
           (let ([current (list-ref nums i)])
             (loop (add1 i) (append res (map (lambda (x) (cons current x)) (two-sum (add1 i) (- (+ current current))))) ))]))
  (if (< (length nums) 3)
      '()
      (let ([sorted (sort nums <)])
        (loop 0 '()))))