(define (count-odd n)
  (if (odd? n)
      (/ (+ n 1) 2)
      (/ n 2)))

(define (count-odd-numbers low high)
  (- (count-odd high) (count-odd (sub1 low))))