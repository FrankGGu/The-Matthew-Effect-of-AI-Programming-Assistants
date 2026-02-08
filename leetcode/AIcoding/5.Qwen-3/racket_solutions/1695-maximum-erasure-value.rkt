(define (maximum-erasure-value nums)
  (define (max a b) (if (> a b) a b))
  (define (min a b) (if (< a b) a b))
  (define (sum lst)
    (if (null? lst)
        0
        (+ (car lst) (sum (cdr lst)))))
  (let loop ([left 0] [right 0] [seen (hash)] [current-sum 0] [max-value 0])
    (cond
      [(= right (length nums)) max-value]
      [else
       (let ([num (list-ref nums right)])
         (if (hash-has-key? seen num)
             (let ([prev-left (add1 (hash-ref seen num))])
               (loop prev-left prev-left (hash) 0 max-value))
             (begin
               (hash-set! seen num right)
               (loop left (add1 right) seen (+ current-sum num) (max max-value (+ current-sum num))))))])))