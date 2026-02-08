#lang racket

(define (is-prime? n)
  (cond [(<= n 1) #f]
        [(= n 2) #t]
        [(even? n) #f]
        [else
         (define (check i)
           (if (> i (sqrt n))
               #t
               (if (= (modulo n i) 0)
                   #f
                   (check (+ i 2)))))
         (check 3)]))

(define (sum-of-largest-prime-substrings s)
  (define len (string-length s))
  (define max-prime 0)
  (define (get-number start end)
    (string->number (substring s start end)))
  (define (process-substrings)
    (for ([i (in-range len)])
      (for ([j (in-range (+ i 1) (+ len 1))])
        (define num (get-number i j))
        (when (and (is-prime? num) (> num max-prime))
          (set! max-prime num)))))
  (process-substrings)
  max-prime)