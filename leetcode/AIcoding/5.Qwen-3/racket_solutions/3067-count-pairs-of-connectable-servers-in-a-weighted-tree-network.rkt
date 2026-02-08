#lang racket

(define (count-pairs n edges)
  (define tree (make-hash))
  (for-each
   (lambda (e)
     (let ([u (car e)] [v (cadr e)] [w (caddr e)])
       (hash-set! tree u (cons (cons v w) (hash-ref tree u '())))
       (hash-set! tree v (cons (cons u w) (hash-ref tree v '())))))
   edges)

  (define (dfs node parent)
    (let ([sum 0])
      (for-each
       (lambda (neighbor)
         (let ([child (car neighbor)] [weight (cdr neighbor)])
           (when (not (= child parent))
             (let ([sub (dfs child node)])
               (set! sum (+ sum sub))
               (set! sum (+ sum (* (car sub) (cdr sub)) (car sub) (cdr sub)))
               (set! sum (- sum (* (car sub) (cdr sub)) (car sub) (cdr sub)))))))
       (hash-ref tree node '()))
      (cons 1 sum)))

  (let ([result (dfs 0 -1)])
    (cdr result)))