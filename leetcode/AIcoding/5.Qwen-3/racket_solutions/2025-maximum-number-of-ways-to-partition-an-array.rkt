#lang racket

(define (max-number-of-ways-to-partition nums)
  (define n (length nums))
  (define prefix (make-vector (+ n 1) 0))
  (for ([i (in-range n)])
    (vector-set! prefix (+ i 1) (+ (vector-ref prefix i) (vector-ref nums i))))

  (define (get-sum l r)
    (- (vector-ref prefix (+ r 1)) (vector-ref prefix l)))

  (define (count-ways target)
    (define cnt 0)
    (define map (make-hash))
    (hash-set! map 0 1)
    (for ([i (in-range n)])
      (define sum (get-sum 0 i))
      (define need (- target sum))
      (when (hash-has-key? map need)
        (set! cnt (+ cnt (hash-ref map need))))
      (hash-update! map (get-sum 0 i) add1 0))
    cnt)

  (define res 0)
  (for ([i (in-range n)])
    (define left (get-sum 0 i))
    (define right (get-sum (+ i 1) (- n 1)))
    (when (= left right)
      (set! res (+ res 1))))

  res)