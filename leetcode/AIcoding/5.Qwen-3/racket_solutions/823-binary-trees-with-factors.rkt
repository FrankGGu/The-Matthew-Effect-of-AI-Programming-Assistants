#lang racket

(define (num-ways arr)
  (define mod 1000000007)
  (define (count-ways x)
    (if (zero? x) 0
        (let loop ([i 0] [res 1])
          (if (= i (vector-length freq))
              res
              (let ([y (vector-ref freq i)])
                (if (= y 0)
                    (loop (+ i 1) res)
                    (loop (+ i 1) (modulo (* res y) mod))))))))
  (define (dfs x)
    (if (>= x (vector-length freq)) 0
        (let ([res (if (zero? (vector-ref freq x)) 0 (count-ways x))])
          (set! freq (vector-set! freq x 0))
          (+ res (dfs (+ x 1))))))
  (define freq (make-vector (add1 (apply max arr)) 0))
  (for-each (lambda (n) (vector-set! freq n (+ 1 (vector-ref freq n)))) arr)
  (dfs 0))