#lang racket

(define (num-subarrays-with-maximum-1 nums)
  (define n (length nums))
  (define left (make-vector n 0))
  (define right (make-vector n 0))
  (let loop ([i 0] [count 0])
    (when (< i n)
      (if (= (vector-ref nums i) 1)
          (begin
            (vector-set! left i count)
            (loop (+ i 1) (+ count 1)))
          (begin
            (vector-set! left i count)
            (loop (+ i 1) 0)))))
  (let loop ([i (- n 1)] [count 0])
    (when (>= i 0)
      (if (= (vector-ref nums i) 1)
          (begin
            (vector-set! right i count)
            (loop (- i 1) (+ count 1)))
          (begin
            (vector-set! right i count)
            (loop (- i 1) 0)))))
  (define res 0)
  (let loop ([i 0])
    (when (< i n)
      (when (= (vector-ref nums i) 1)
        (let ([l (vector-ref left i)]
              [r (vector-ref right i)])
          (set! res (+ res (* (+ l 1) (+ r 1))))))
      (loop (+ i 1))))
  res)

(define (count-incremovable-subarrays nums)
  (define n (length nums))
  (define max-val (apply max nums))
  (define nums-with-index (map cons nums (range n)))
  (define sorted-nums (sort nums-with-index (lambda (a b) (< (car a) (car b)))))
  (define (get-right-boundary idx)
    (let loop ([i idx] [res 0])
      (if (or (>= i n) (not (= (vector-ref nums i) max-val)))
          res
          (loop (+ i 1) (+ res 1)))))
  (define (get-left-boundary idx)
    (let loop ([i idx] [res 0])
      (if (or (< i 0) (not (= (vector-ref nums i) max-val)))
          res
          (loop (- i 1) (+ res 1)))))
  (define res 0)
  (for ([i (in-range n)])
    (when (= (vector-ref nums i) max-val)
      (define l (get-left-boundary (- i 1)))
      (define r (get-right-boundary (+ i 1)))
      (set! res (+ res (* (+ l 1) (+ r 1))))))
  res)

(define (main)
  (define input (read))
  (define nums (vector->list input))
  (display (count-incremovable-subarrays nums)))

(main)