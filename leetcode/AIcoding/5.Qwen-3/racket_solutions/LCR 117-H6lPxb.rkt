#lang racket

(define (strs->groups strs)
  (define (find root x)
    (if (equal? (vector-ref root x) x)
        x
        (let ([p (find root (vector-ref root x))])
          (vector-set! root x p)
          p)))
  (define (union root x y)
    (let ([xroot (find root x)]
          [yroot (find root y)])
      (when (not (equal? xroot yroot))
        (vector-set! root yroot xroot))))
  (define (get-index s)
    (for/first ([i (in-range (length strs))] #:when (equal? s (list-ref strs i)) i))
  (define root (make-vector (length strs) 0))
  (for ([i (in-range (length strs))])
    (vector-set! root i i))
  (for ([i (in-range (length strs))])
    (for ([j (in-range (length strs))])
      (when (and (not (= i j)) (equal? (string-length (list-ref strs i)) (string-length (list-ref strs j))))
        (define diff 0)
        (for ([a (in-string (list-ref strs i))]
              [b (in-string (list-ref strs j))])
          (when (not (char=? a b))
            (set! diff (+ diff 1))
            (when (> diff 2) (break))))
        (when (<= diff 2)
          (union root i j)))))
  (define groups (make-hash))
  (for ([i (in-range (length strs))])
    (define root-i (find root i))
    (hash-update! groups root-i (λ (lst) (cons (list-ref strs i) lst)) '()))
  (hash-values groups))

(define (num-strings-groups strs)
  (length (strs->groups strs)))

(define (main)
  (define input (read))
  (printf "~a\n" (num-strings-groups input)))

(main)