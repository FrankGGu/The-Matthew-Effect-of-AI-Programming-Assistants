#lang racket

(define (min-int) (expt 10 9))

(define (paint-house-iii n k costs target)
  (define dp
    (lambda (i j prev-color)
      (cond [(= i n) (if (= j target) 0 (min-int))]
            [(= j target) (if (= i n) 0 (min-int))]
            [else
             (let loop ([c 0] [res (min-int)])
               (if (= c k)
                   res
                   (if (= c prev-color)
                       (loop (+ c 1) res)
                       (let ([next-res (dp (+ i 1) (+ j (if (= c 0) 1 0)) c)])
                         (if (= next-res (min-int))
                             (loop (+ c 1) res)
                             (loop (+ c 1) (min res (+ (list-ref (list-ref costs i) c) next-res))))))))])))
  (if (or (< n 1) (< k 1) (< target 1)) (min-int)
      (let ([res (dp 0 0 -1)])
        (if (= res (min-int)) -1 res))))