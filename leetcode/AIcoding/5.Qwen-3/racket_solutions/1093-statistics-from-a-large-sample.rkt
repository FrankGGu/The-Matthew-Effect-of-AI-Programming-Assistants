#lang racket

(define (sample-statistics counts)
  (define total (apply + counts))
  (define n (length counts))
  (define avg (/ (for/sum ([i (in-range n)] [c (in-list counts)]) (* i c)) total))
  (define median
    (let loop ([mid (quotient total 2)] [sum 0] [i 0])
      (cond [(>= sum mid) (if (even? total)
                             (let ([prev (for/sum ([j (in-range i)] [c (in-list counts)] (* j c))])
                               (/ (+ prev (for/sum ([j (in-range i)] [c (in-list counts)] (* j c))) 2))
                             i)]
            [else (loop mid (+ sum (list-ref counts i)) (+ i 1))])))
  (define mode (argmax (lambda (x) (list-ref counts x)) (range n)))
  (list avg median mode))