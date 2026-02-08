#lang racket

(define (find-in-mountain-array mountain-array target)
  (define (find-peak)
    (let loop ([left 0] [right (- (vector-length mountain-array) 1)])
      (if (= left right)
          left
          (let* ([mid (quotient (+ left right) 2)]
                 [val (vector-ref mountain-array mid)]
                 [next (vector-ref mountain-array (+ mid 1))])
            (if (< val next)
                (loop (+ mid 1) right)
                (loop left mid))))))

  (define (binary-search-left start end)
    (let loop ([left start] [right end])
      (if (> left right)
          -1
          (let* ([mid (quotient (+ left right) 2)]
                 [val (vector-ref mountain-array mid)])
            (cond [(= val target) mid]
                  [(< val target) (loop (+ mid 1) right)]
                  [else (loop left (- mid 1))])))))

  (define (binary-search-right start end)
    (let loop ([left start] [right end])
      (if (> left right)
          -1
          (let* ([mid (quotient (+ left right) 2)]
                 [val (vector-ref mountain-array mid)])
            (cond [(= val target) mid]
                  [(> val target) (loop (+ mid 1) right)]
                  [else (loop left (- mid 1))])))))

  (let ([peak (find-peak)])
    (let ([res (binary-search-left 0 peak)])
      (if (not (= res -1))
          res
          (binary-search-right (+ peak 1) (- (vector-length mountain-array) 1))))))