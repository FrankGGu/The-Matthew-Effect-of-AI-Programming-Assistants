#lang racket

(define/contract (trap-rain-water height-map)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let ([m (length height-map)]
        [n (if (null? height-map) 0 (length (car height-map)))])
    (if (or (= m 0) (= n 0)) 0
        (let ([visited (make-vector m (make-vector n #f))]
              [heap (list->heap (for/list ([i (in-range m)]
                                          [row (in-list height-map)])
                                 (for/list ([j (in-range n)])
                                   (vector-set! visited i j #t)
                                   (cons (list-ref row j) i j))))])
          (heap-set! heap (heapify heap))
          (define directions (list (cons 1 0) (cons -1 0) (cons 0 1) (cons 0 -1)))
          (define result 0)
          (let loop ()
            (when (not (heap-empty? heap))
              (let* ([current (heap-pop heap)]
                     [h (car current)]
                     [i (cadr current)]
                     [j (caddr current)])
                (for-each (lambda (d)
                            (let ([ni (+ i (car d))]
                                  [nj (+ j (cdr d))])
                              (when (and (<= 0 ni (- m 1)) (<= 0 nj (- n 1)) (not (vector-ref (vector-ref visited ni) nj)))
                                (vector-set! (vector-ref visited ni) nj #t)
                                (let ([new-h (list-ref (list-ref height-map ni) nj)])
                                  (if (> new-h h)
                                      (begin
                                        (heap-add! heap (cons new-h ni nj))
                                        (set! result (+ result (- new-h h))))
                                      (heap-add! heap (cons new-h ni nj))))))
                          directions)
                (loop)))
          result))))