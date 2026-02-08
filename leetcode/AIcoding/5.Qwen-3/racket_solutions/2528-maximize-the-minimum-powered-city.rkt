#lang racket

(define (maximize-the-minimum-powered-city n power)
  (define (ok m)
    (let loop ([i 0] [cnt 0])
      (cond [(>= i n) #t]
            [(<= (list-ref power i) m) (loop (+ i 1) cnt)]
            [else
             (if (>= cnt 2)
                 #f
                 (loop (+ i 1) (+ cnt 1)))])))
  (let loop ([l 0] [r (apply max power)])
    (if (> l r)
        l
        (let ([m (quotient (+ l r) 2)])
          (if (ok m)
              (loop (+ m 1) r)
              (loop l (- m 1)))))))