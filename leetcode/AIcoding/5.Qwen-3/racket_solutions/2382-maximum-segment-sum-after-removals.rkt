#lang racket

(define (max-segment-sum-after-removals nums remove-nums)
  (define (find-parent x parent)
    (if (= x (vector-ref parent x))
        x
        (let ([p (find-parent (vector-ref parent x) parent)])
          (vector-set! parent x p)
          p)))

  (define (union x y parent rank)
    (let ([xroot (find-parent x parent)]
          [yroot (find-parent y parent)])
      (when (not (= xroot yroot))
        (if (< (vector-ref rank xroot) (vector-ref rank yroot))
            (vector-set! parent xroot yroot)
            (begin
              (vector-set! parent yroot xroot)
              (when (= (vector-ref rank xroot) (vector-ref rank yroot))
                (vector-set! rank xroot (+ (vector-ref rank xroot) 1))))))))

  (define n (length nums))
  (define parent (make-vector n 0))
  (define rank (make-vector n 0))
  (for ([i (in-range n)])
    (vector-set! parent i i)
    (vector-set! rank i 1))

  (define sum (make-vector n 0))
  (for ([i (in-range n)])
    (vector-set! sum i (list-ref nums i)))

  (define (get-sum x)
    (let ([root (find-parent x parent)])
      (vector-ref sum root)))

  (define (update-sum x y)
    (let ([xroot (find-parent x parent)]
          [yroot (find-parent y parent)])
      (when (not (= xroot yroot))
        (vector-set! sum xroot (+ (vector-ref sum xroot) (vector-ref sum yroot)))
        (union x y parent rank)))
    (vector-ref sum (find-parent x parent)))

  (for ([i (in-range n)])
    (when (member i remove-nums)
      (vector-set! sum i 0)))

  (for ([i (in-range n)])
    (when (and (< i (- n 1)) (not (member i remove-nums)) (not (member (+ i 1) remove-nums)))
      (union i (+ i 1) parent rank)))

  (define max-sum 0)
  (for ([i (in-range n)])
    (when (and (not (member i remove-nums)) (= (find-parent i parent) i))
      (set! max-sum (max max-sum (vector-ref sum i))))
  max-sum)