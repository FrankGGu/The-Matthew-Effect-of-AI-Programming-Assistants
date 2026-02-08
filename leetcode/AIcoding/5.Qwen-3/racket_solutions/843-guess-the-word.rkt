#lang racket

(define (find-secret wordlist master)
  (define (get-matches a b)
    (for/sum ([x (in-string a)] [y (in-string b)]) (if (= x y) 1 0)))

  (define (guess a)
    (let ([matches (get-matches a (master 'get-secret))])
      (if (= matches 6) #t (begin (master 'guess a matches) #f))))

  (define (solve lst)
    (cond [(null? lst) #f]
          [else
           (let ([g (car lst)])
             (if (guess g) #t
                 (solve (filter (lambda (w) (= (get-matches g w) (master 'guess g 0))) (cdr lst))))]))

  (solve wordlist))