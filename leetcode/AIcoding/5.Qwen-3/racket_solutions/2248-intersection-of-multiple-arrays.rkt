#lang racket

(define (intersection nums)
  (if (null? nums)
      '()
      (let ((first (car nums)))
        (for/fold ((result '()))
          ((num (in-list (cdr nums))))
          (set->list (set-intersect (list->set result) (list->set num)))))))