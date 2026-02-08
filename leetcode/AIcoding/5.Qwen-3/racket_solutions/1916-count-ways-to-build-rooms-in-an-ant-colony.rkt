#lang racket

(define (count-ways n edges)
  (define MOD 1000000007)
  (define graph (make-hash))
  (for-each (lambda (e)
              (hash-set! graph (car e) (cons (cadr e) (hash-ref graph (car e) '())))
              (hash-set! graph (cadr e) (cons (car e) (hash-ref graph (cadr e) '()))))
            edges)

  (define memo (make-hash))

  (define (dfs u parent)
    (define cnt 1)
    (for-each (lambda (v)
                (when (not (= v parent))
                  (set! cnt (* cnt (dfs v u))))) 
              (hash-ref graph u '()))
    (modulo cnt MOD))

  (define (factorial x)
    (if (= x 0)
        1
        (* x (factorial (- x 1)))))

  (define (comb n k)
    (define (fact x) (factorial x))
    (define (inv x) (expt x (- MOD 2)))
    (modulo (* (fact n) (inv (modulo (* (fact k) (fact (- n k))) MOD))) MOD))

  (define (solve u parent)
    (define res 1)
    (define total 0)
    (define children '())
    (for-each (lambda (v)
                (when (not (= v parent))
                  (set! children (cons (solve v u) children))
                  (set! total (+ total 1))))
              (hash-ref graph u '()))

    (define (helper lst)
      (cond ((null? lst) 1)
            (else
             (modulo (* (comb (+ total 1) (car lst)) (helper (cdr lst))) MOD))))

    (helper children))

  (solve 0 -1))