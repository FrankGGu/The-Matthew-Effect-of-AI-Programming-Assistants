#lang racket

(define (last-stone-weight stones)
  (let ([heap (list->heap stones #:type 'max)])
    (let loop ()
      (when (> (heap-length heap) 1)
        (let* ([x (heap-pop! heap)]
               [y (heap-pop! heap)]
               [z (- x y)])
          (if (> z 0)
              (heap-add! heap z)
              #f)
          (loop)))
    (if (heap-empty? heap)
        0
        (heap-top heap)))))