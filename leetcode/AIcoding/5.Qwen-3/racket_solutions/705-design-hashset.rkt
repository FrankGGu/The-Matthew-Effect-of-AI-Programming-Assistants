#lang racket

(define-struct hash-set (buckets))

(define (make-hash-set)
  (make-hash-set (build-list 10000 void)))

(define (hash key)
  (modulo key 10000))

(define (add set key)
  (let ([index (hash key)])
    (when (not (member key (vector-ref (hash-set-buckets set) index)))
      (vector-set! (hash-set-buckets set) index (cons key (vector-ref (hash-set-buckets set) index)))))

(define (remove set key)
  (let ([index (hash key)])
    (vector-set! (hash-set-buckets set) index (filter (lambda (x) (not (= x key))) (vector-ref (hash-set-buckets set))))))

(define (contains set key)
  (let ([index (hash key)])
    (member key (vector-ref (hash-set-buckets set) index)))

(define (main)
  (define set (make-hash-set))
  (add set 1)
  (add set 2)
  (display (contains set 1))
  (newline)
  (remove set 1)
  (display (contains set 1))
  (newline)
  (add set 2)
  (display (contains set 2))
  (newline)
  (remove set 2)
  (display (contains set 2))
  (newline))

(main)