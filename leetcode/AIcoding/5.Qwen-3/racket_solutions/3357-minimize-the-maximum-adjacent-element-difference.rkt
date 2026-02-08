#lang racket

(define (max-adjacent-diff nums)
  (define (check mid)
    (define (helper i prev)
      (cond [(>= i (length nums)) #t]
            [(<= (abs (- (list-ref nums i) prev)) mid)
             (helper (+ i 1) (list-ref nums i))]
            [else #f]))
    (helper 1 (list-ref nums 0)))

  (define low 0)
  (define high (apply max (map (lambda (x) (abs x)) nums)))
  (define (binary-search l r)
    (if (>= l r)
        l
        (let ([mid (quotient (+ l r) 2)])
          (if (check mid)
              (binary-search l mid)
              (binary-search (+ mid 1) r)))))

  (binary-search low high))

(define/contract (minimize-maximum-adjacent-element-difference nums)
  (-> (listof exact-integer?) exact-integer?)
  (max-adjacent-diff nums))