(define (digits n)
  (if (= n 0)
      '()
      (cons (remainder n 10) (digits (quotient n 10)))))

(define (k-beauty num k)
  (define nums (digits num))
  (define len (length nums))
  (if (< len k)
      0
      (let loop ((i 0) (count 0))
        (if (>= i (- len k))
            count
            (let* ((sub (take nums (+ i k)))
                   (num-sub (foldl (lambda (d acc) (+ (* acc 10) d)) 0 sub)))
              (if (and (not (= num-sub 0)) (= (remainder num num-sub) 0))
                  (loop (+ i 1) (+ count 1))
                  (loop (+ i 1) count))))))

(define/contract (find-k-beauty num k)
  (-> exact-integer? exact-integer? exact-integer?)
  (k-beauty num k))