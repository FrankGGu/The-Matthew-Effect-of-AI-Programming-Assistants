#lang racket

(define (minimum-swaps-to-arrange-a-binary-grid grid)
  (define n (length grid))
  (define (count-ones row)
    (for/sum ([c row]) (if (= c 1) 1 0)))

  (define (find-min-row idx)
    (for/first ([i (in-range idx n)]
                #:when (>= (count-ones (list-ref grid i)) (- n idx 1)))
      i))

  (define (swap! i j)
    (define temp (list-ref grid i))
    (set! grid (append (take grid i) (list (list-ref grid j)) (drop grid (+ i 1))))
    (set! grid (append (take grid j) (list temp) (drop grid (+ j 1)))))

  (define res 0)
  (for ([i (in-range n)])
    (define target (- n i 1))
    (define j (find-min-row i))
    (when (not j)
      (return #f))
    (when (not (= i j))
      (swap! i j)
      (set! res (+ res 1))))
  res)