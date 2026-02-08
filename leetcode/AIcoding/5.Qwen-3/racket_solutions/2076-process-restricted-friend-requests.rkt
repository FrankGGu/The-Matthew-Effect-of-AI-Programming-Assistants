#lang racket

(define (friend-request n edges)
  (define adj (make-hash))
  (for-each (lambda (e) (hash-set! adj (car e) (cons (cadr e) (hash-ref adj (car e) '())))) edges)
  (define (dfs u v visited)
    (cond [(equal? u v) #t]
          [(member v visited) #f]
          [else
           (let ([new-visited (cons u visited)])
             (for/or ([neighbor (hash-ref adj u '())])
               (dfs neighbor v new-visited)))]))
  (define (check u v)
    (and (dfs u v '())
         (dfs v u '())))
  (for/first ([e edges] #:when (not (check (car e) (cadr e)))) (car e))
  (for/last ([e edges] #:when (not (check (car e) (cadr e)))) (car e)))