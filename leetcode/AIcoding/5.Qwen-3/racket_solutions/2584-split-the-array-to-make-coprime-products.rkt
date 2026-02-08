#lang racket

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (coprime? a b)
  (= (gcd a b) 1))

(define (solve nums)
  (define n (length nums))
  (define left (make-vector n 1))
  (define right (make-vector n 1))
  (define i 0)
  (for ([num nums])
    (vector-set! left i (if (= i 0) num (* (vector-ref left (- i 1)) num)))
    (set! i (+ i 1)))
  (set! i (- n 1))
  (for ([num (reverse nums)])
    (vector-set! right i (if (= i (- n 1)) num (* (vector-ref right (+ i 1)) num)))
    (set! i (- i 1)))
  (let loop ([i 0])
    (cond [(= i n) #f]
          [else
           (if (coprime? (vector-ref left i) (vector-ref right i))
               #t
               (loop (+ i 1)))])))

(define (main)
  (define input (read-line))
  (define nums (map string->number (string-split input)))
  (display (if (solve nums) "true" "false")))

(main)