#lang racket

(define (num-rabbits h)
  (if (null? h)
      0
      (let loop ([h h] [count 0] [remaining 0])
        (if (null? h)
            count
            (let ([x (car h)])
              (if (>= remaining x)
                  (loop (cdr h) count (- remaining 1))
                  (let ([new-remaining (quotient x 2)])
                    (loop (cdr h) (+ count (add1 x)) new-remaining))))))))

(define (num-rabbits-2 h)
  (define (helper h count remaining)
    (cond [(null? h) count]
          [(>= remaining (car h))
           (helper (cdr h) count (- remaining 1))]
          [else
           (let ([new-remaining (quotient (car h) 2)])
             (helper (cdr h) (+ count (add1 (car h))) new-remaining))]))
  (helper h 0 0))

(define (main)
  (define input (read))
  (displayln (num-rabbits-2 input)))

(main)