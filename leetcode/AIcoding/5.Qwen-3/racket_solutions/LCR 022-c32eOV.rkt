#lang racket

(define (detect-cycle head)
  (define (get-intersection)
    (let ((slow head)
          (fast head))
      (let loop ()
        (when (and fast (not (null? (cdr fast))))
          (set! slow (cdr slow))
          (set! fast (cddr fast))
          (if (equal? slow fast)
              slow
              (loop))))))
  (let ((intersect (get-intersection)))
    (if (not intersect)
        #f
        (let ((ptr1 head)
              (ptr2 intersect))
          (let loop ()
            (if (equal? ptr1 ptr2)
                ptr1
                (begin
                  (set! ptr1 (cdr ptr1))
                  (set! ptr2 (cdr ptr2))
                  (loop))))))))