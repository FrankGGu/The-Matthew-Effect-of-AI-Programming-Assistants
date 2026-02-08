#lang racket

(define (min-space-wasted-1 pkg)
  (define (helper i j)
    (if (>= i j)
        0
        (let* ([mid (quotient (+ i j) 2)]
               [left (helper i mid)]
               [right (helper (add1 mid) j)])
          (if (<= (vector-ref pkg mid) (vector-ref pkg (add1 mid)))
              (+ left right)
              (+ left right (- (vector-ref pkg (add1 mid)) (vector-ref pkg mid)))))))
  (helper 0 (sub1 (vector-length pkg))))

(define (min-space-wasted-2 pkg)
  (define n (vector-length pkg))
  (define dp (make-vector n 0))
  (for ([i (in-range n)])
    (when (> i 0)
      (vector-set! dp i (+ (vector-ref dp (sub1 i)) (vector-ref pkg i)))))
  (define (get-sum l r)
    (- (vector-ref dp r) (if (> l 0) (vector-ref dp (sub1 l)) 0)))
  (define res (make-vector n 0))
  (for ([i (in-range n)])
    (define target (vector-ref pkg i))
    (define l 0)
    (define r (sub1 n))
    (define pos -1)
    (let loop ()
      (when (<= l r)
        (define mid (quotient (+ l r) 2))
        (if (<= (vector-ref pkg mid) target)
            (begin
              (set! pos mid)
              (set! l (add1 mid))
              (loop))
            (begin
              (set! r (sub1 mid))
              (loop)))))
    (when (not (= pos -1))
      (define sum (get-sum 0 pos))
      (define total (get-sum 0 (sub1 n)))
      (vector-set! res i (- total sum))))
  (apply min (vector->list res)))

(define (package-waste packages)
  (define n (vector-length packages))
  (define (solve i j)
    (if (>= i j)
        0
        (let* ([mid (quotient (+ i j) 2)]
               [left (solve i mid)]
               [right (solve (add1 mid) j)])
          (if (<= (vector-ref packages mid) (vector-ref packages (add1 mid)))
              (+ left right)
              (+ left right (- (vector-ref packages (add1 mid)) (vector-ref packages mid)))))))
  (solve 0 (sub1 n)))

(define (main)
  (define input (vector '(1 3 5) '(2 4 6) '(3 5 7)))
  (define res (map package-waste input))
  (displayln res))

(main)