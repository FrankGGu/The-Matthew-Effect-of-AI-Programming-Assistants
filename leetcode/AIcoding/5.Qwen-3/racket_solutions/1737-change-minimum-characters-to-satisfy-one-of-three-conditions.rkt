#lang racket

(define (min-changes-to-satisfy-conditions s t)
  (define (count-freq str)
    (define freq (make-hash))
    (for ([c str])
      (hash-set! freq c (+ 1 (hash-ref freq c 0))))
    freq)

  (define (condition1)
    (define s-freq (count-freq s))
    (define t-freq (count-freq t))
    (for/sum ([c (in-hash-keys s-freq)])
      (if (< (hash-ref t-freq c 0) (hash-ref s-freq c))
          (- (hash-ref s-freq c) (hash-ref t-freq c 0))
          0)))

  (define (condition2)
    (define s-freq (count-freq s))
    (define t-freq (count-freq t))
    (for/sum ([c (in-hash-keys t-freq)])
      (if (< (hash-ref s-freq c 0) (hash-ref t-freq c))
          (- (hash-ref t-freq c) (hash-ref s-freq c 0))
          0)))

  (define (condition3)
    (define s-freq (count-freq s))
    (define t-freq (count-freq t))
    (for/sum ([c (in-hash-keys s-freq)])
      (if (>= (hash-ref t-freq c 0) (hash-ref s-freq c))
          0
          (- (hash-ref s-freq c) (hash-ref t-freq c 0))))
    (for/sum ([c (in-hash-keys t-freq)])
      (if (>= (hash-ref s-freq c 0) (hash-ref t-freq c))
          0
          (- (hash-ref t-freq c) (hash-ref s-freq c 0)))))

  (min (condition1) (condition2) (condition3)))

(define (main)
  (define s (read-line))
  (define t (read-line))
  (display (min-changes-to-satisfy-conditions s t)))

(main)