#lang racket

(define (merge-in-between-lls list1 a b list2)
  (define (get-node node idx)
    (if (= idx 0)
        node
        (get-node (cdr node) (- idx 1))))
  (define (count-length node)
    (if (null? node)
        0
        (+ 1 (count-length (cdr node)))))
  (define end-of-list2 (get-node list2 (sub1 (count-length list2))))
  (define start (get-node list1 a))
  (define end (get-node list1 b))
  (define prev (get-node list1 (sub1 a)))
  (if (null? prev)
      (set-cdr! list1 (cdr end))
      (set-cdr! prev (cdr end)))
  (set-cdr! end list2)
  (set-cdr! end-of-list2 (cdr end))
  list1)