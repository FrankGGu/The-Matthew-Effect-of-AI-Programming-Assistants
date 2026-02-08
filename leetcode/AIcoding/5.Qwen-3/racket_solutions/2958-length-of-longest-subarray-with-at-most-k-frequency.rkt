#lang racket

(define/contract (find-length-at-most-k-1 arr k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let ([n (length arr)])
    (let ([freq (make-hash)])
      (let loop ([left 0] [right 0] [max-len 0])
        (cond
          [(= right n) max-len]
          [else
           (hash-set! freq (list-ref arr right) (+ (hash-ref freq (list-ref arr right) 0) 1))
           (if (> (hash-ref freq (list-ref arr right)) k)
               (begin
                 (loop (add1 left) right max-len))
               (loop left (add1 right) (max max-len (- right left 1))))])))))

(define/contract (find-length-at-most-k arr k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (find-length-at-most-k-1 arr k))