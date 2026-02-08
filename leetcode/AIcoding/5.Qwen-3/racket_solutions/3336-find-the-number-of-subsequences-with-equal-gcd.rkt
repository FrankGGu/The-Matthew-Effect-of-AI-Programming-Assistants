#lang racket

(define (count-subsequences nums)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))

  (define (solve nums)
    (let loop ([nums nums] [g 0] [count 0])
      (cond [(null? nums) count]
            [else
             (let* ([n (car nums)]
                    [new-g (gcd g n)])
               (loop (cdr nums) new-g (+ count (if (= new-g 0) 0 1))))])))

  (solve nums))