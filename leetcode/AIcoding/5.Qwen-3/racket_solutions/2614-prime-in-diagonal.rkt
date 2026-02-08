#lang racket

(define (is-prime? n)
  (cond [(<= n 1) #f]
        [(= n 2) #t]
        [(even? n) #f]
        [else
         (let loop ([i 3])
           (if (> i (sqrt n))
               #t
               (if (= (modulo n i) 0)
                   #f
                   (loop (+ i 2)))))]))

(define (prime-diagonal matrix)
  (define rows (length matrix))
  (define cols (length (car matrix)))
  (define result '())
  (for ([i (in-range rows)])
    (define val (list-ref (list-ref matrix i) i))
    (when (is-prime? val)
      (set! result (cons val result))))
  (reverse result))