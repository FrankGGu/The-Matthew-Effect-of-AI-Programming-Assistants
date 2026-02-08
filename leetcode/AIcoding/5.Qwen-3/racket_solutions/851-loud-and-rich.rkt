#lang racket

(define/contract (loud-and-rich log)
  (-> (listof (listof any)) (listof (listof any)))
  (let* ([n (length log)]
         [adj (make-vector n '())]
         [richer? (make-vector n #f)]
         [visited (make-vector n #f)]
         [result (make-vector n '())])
    (for ([i (in-range n)])
      (for ([j (in-range (length (list-ref log i)))])
        (vector-set! adj i (cons (list-ref (list-ref log i) j) (vector-ref adj i)))))
    (define (dfs x)
      (when (not (vector-ref visited x))
        (vector-set! visited x #t)
        (for ([y (vector-ref adj x)])
          (dfs y)
          (when (vector-ref richer? y)
            (vector-set! richer? x #t))))
    (for ([i (in-range n)])
      (dfs i))
    (for ([i (in-range n)])
      (vector-set! result i (if (vector-ref richer? i) (list i) '())))
    (vector->list result)))