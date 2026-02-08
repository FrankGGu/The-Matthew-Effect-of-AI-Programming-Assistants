#lang racket

(define (is-palindrome head)
  (define (reverse-list node)
    (let loop ([prev #f] [current node])
      (if (not current)
          prev
          (loop (cons (car current) prev) (cdr current)))))

  (define (get-middle node)
    (let loop ([slow node] [fast node])
      (if (or (not fast) (not (cdr fast)))
          slow
          (loop (cdr slow) (cddr fast)))))

  (define (compare-list l1 l2)
    (cond [(and (null? l1) (null? l2)) #t]
          [(or (null? l1) (null? l2)) #f]
          [(not (= (car l1) (car l2))) #f]
          [else (compare-list (cdr l1) (cdr l2))]))

  (let* ([mid (get-middle head)]
         [reversed-half (reverse-list mid)])
    (compare-list head reversed-half)))