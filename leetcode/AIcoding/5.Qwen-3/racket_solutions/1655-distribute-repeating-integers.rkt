#lang racket

(define (distribute-candies c)
  (define n (length c))
  (define freq (make-hash))
  (for-each (lambda (x) (hash-set! freq x (+ 1 (hash-ref freq x 0)))) c)
  (define (check k)
    (let loop ((h freq) (count 0))
      (cond
        [(hash-empty? h) #t]
        [else
         (define key (hash-first h))
         (define val (hash-ref h key))
         (if (>= val k)
             (loop (hash-remove h key) (+ count 1))
             (loop (hash-remove h key) count))])))
  (let loop ((k (floor (/ n 2))))
    (if (<= k 0) #f
        (if (check k) k (loop (- k 1))))))

(define (main)
  (define input (read-line))
  (define c (map string->number (string-split input)))
  (display (distribute-candies c)))

(main)