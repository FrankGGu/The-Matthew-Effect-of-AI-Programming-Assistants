#lang racket

(define (minimize-maximum nums)
  (define (check m)
    (let loop ([i 0] [cnt 0])
      (cond [(= i (length nums)) #t]
            [(>= cnt m) #f]
            [else
             (loop (+ i 1) (+ cnt (quotient (list-ref nums i) m)))])))
  (let loop ([l 1] [r (apply max nums)])
    (if (= l r)
        l
        (let ([mid (quotient (+ l r) 2)])
          (if (check mid)
              (loop l mid)
              (loop (+ mid 1) r))))))