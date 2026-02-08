#lang racket

(define-struct heap (data comparator) #:mutable)

(define (make-heap comparator)
  (make-heap '() comparator))

(define (heap-empty? h)
  (null? (heap-data h)))

(define (heap-top h)
  (car (heap-data h)))

(define (heap-push! h x)
  (set-heap-data! h (cons x (heap-data h)))
  (set-heap-data! h (sort (heap-data h) (heap-comparator h))))

(define (heap-pop! h)
  (let ((top (heap-top h)))
    (set-heap-data! h (cdr (heap-data h)))
    top))

(define (median-sliding-window nums)
  (define left-heap (make-heap >))
  (define right-heap (make-heap <))
  (define result '())
  (define (balance)
    (when (> (length (heap-data left-heap)) (+ (length (heap-data right-heap)) 1))
      (heap-push! right-heap (heap-pop! left-heap)))
    (when (> (length (heap-data right-heap)) (length (heap-data left-heap)))
      (heap-push! left-heap (heap-pop! right-heap))))
  (for-each
   (lambda (num)
     (if (<= num (heap-top right-heap))
         (heap-push! left-heap num)
         (heap-push! right-heap num))
     (balance)
     (if (odd? (length (heap-data left-heap)))
         (set! result (cons (heap-top left-heap) result))
         (set! result (cons (/ (+ (heap-top left-heap) (heap-top right-heap)) 2.0) result))))
   nums)
  (reverse result))