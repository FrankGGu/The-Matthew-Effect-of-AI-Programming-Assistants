#lang racket

(define (robot-collisions robots)
  (define (compare a b)
    (let ([a-id (car a)]
          [a-pos (cadr a)]
          [a-dir (caddr a)]
          [b-id (car b)]
          [b-pos (cadr b)]
          [b-dir (caddr b)])
      (if (= a-dir 1)
          (if (= b-dir 1)
              (< a-pos b-pos)
              #t)
          (if (= b-dir 1)
              #f
              (> a-pos b-pos)))))

  (define (process-robots rs)
    (cond [(null? rs) '()]
          [(null? (cdr rs)) rs]
          [else
           (let* ([first (car rs)]
                  [second (cadr rs)]
                  [first-id (car first)]
                  [first-pos (cadr first)]
                  [first-dir (caddr first)]
                  [second-id (car second)]
                  [second-pos (cadr second)]
                  [second-dir (caddr second)])
             (if (and (= first-dir 1) (= second-dir -1) (> first-pos second-pos))
                 (begin
                   (set! rs (cons (list first-id (abs (- first-pos second-pos)) -1) (cddr rs)))
                   (process-robots rs))
                 (cons (car rs) (process-robots (cdr rs)))))]))

  (let loop ([rs (sort robots compare)])
    (if (= (length rs) 1)
        (length rs)
        (loop (process-robots rs)))))