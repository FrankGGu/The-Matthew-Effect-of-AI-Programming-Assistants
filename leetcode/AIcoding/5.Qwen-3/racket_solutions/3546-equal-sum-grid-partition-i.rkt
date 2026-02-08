#lang racket

(define (can-divide grid)
  (define rows (length grid))
  (define cols (length (car grid)))
  (define total (apply + (apply append grid)))
  (cond [(odd? total) #f]
        [else
         (define target (/ total 2))
         (define dp (make-vector (+ rows cols) #f))
         (vector-set! dp 0 #t)
         (for-each
          (lambda (row)
            (for-each
             (lambda (j)
               (when (vector-ref dp j)
                 (when (< (+ j (list-ref row 0)) (+ rows cols))
                   (vector-set! dp (+ j (list-ref row 0)) #t)))))
             (range 0 (+ rows cols)))
          (map (lambda (i) (list-ref grid i)) (range 0 rows)))
         (vector-ref dp target)]))