(define/contract (pow-k-subarrays nums k)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (define n (length nums))
  (define result '())
  (define (power lst)
    (if (null? lst)
        0
        (let loop ((lst lst) (res 1))
          (if (null? lst)
              res
              (loop (cdr lst) (* res (car lst)))))))
  (for ((i (in-range (- n k +1))))
    (set! result (cons (power (take nums (+ i k))) result)))
  (reverse result))