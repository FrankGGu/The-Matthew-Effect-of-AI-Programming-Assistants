#lang racket

(define (sort-three-groups nums)
  (let loop ([i 0] [j 0] [k 0])
    (cond [(= i (length nums)) (reverse nums)]
          [(= j (length nums)) (loop (+ i 1) j k)]
          [(= k (length nums)) (loop i (+ j 1) k)]
          [else
           (if (= (list-ref nums i) 0)
               (loop (+ i 1) j k)
               (if (= (list-ref nums j) 1)
                   (loop i (+ j 1) k)
                   (if (= (list-ref nums k) 2)
                       (loop i j (+ k 1))
                       (begin
                         (let ([temp (list-ref nums i)])
                           (vector-set! nums i (list-ref nums k))
                           (vector-set! nums k temp))
                         (loop i j (+ k 1))))))])))

(define (main)
  (define input (read))
  (define result (sort-three-groups input))
  (displayln result))

(main)