#lang racket

(define (is-even? n) (= (modulo n 2) 0))

(define (add-edges-to-make-degrees-of-all-nodes-even edges)
  (define nodes (apply set (append (map car edges) (map cadr edges))))
  (define degrees (for/fold ([d (hash)]) ([u v] in-list edges))
    (hash-update d u add1 (hash #:default 0))
    (hash-update d v add1 (hash #:default 0)))
  (define odd-nodes (filter (λ (n) (not (is-even? (hash-ref degrees n 0)))) (set->list nodes)))
  (if (is-even? (length odd-nodes))
      (let loop ([odd odd-nodes] [result '()])
        (if (null? odd)
            result
            (loop (cddr odd) (cons (list (car odd) (cadr odd)) result))))
      #f))