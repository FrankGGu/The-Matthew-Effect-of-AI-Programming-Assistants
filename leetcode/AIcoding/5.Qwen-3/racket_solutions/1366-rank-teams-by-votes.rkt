#lang racket

(define (rank-teams votes)
  (define cnt (make-hash))
  (define len (string-length (car votes)))
  (for-each
   (lambda (v)
     (for-each
      (lambda (i)
        (hash-update! cnt (string-ref v i) (lambda (x) (if x (+ x 1) 1)) 0))
      (range (string-length v))))
  (define keys (hash-keys cnt))
  (define (cmp a b)
    (let ((ca (hash-ref cnt a))
          (cb (hash-ref cnt b)))
      (if (= ca cb)
          (if (> (char->integer a) (char->integer b)) -1 1)
          (- cb ca))))
  (sort keys cmp))