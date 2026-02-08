#lang racket

(define (maximize-distance points)
  (define (distance p1 p2)
    (sqrt (+ (sqr (- (car p1) (car p2))) (sqr (- (cadr p1) (cadr p2))))))

  (define (square? p1 p2 p3 p4)
    (let* ((d1 (distance p1 p2))
           (d2 (distance p2 p3))
           (d3 (distance p3 p4))
           (d4 (distance p4 p1))
           (d5 (distance p1 p3))
           (d6 (distance p2 p4)))
      (and (= d1 d2) (= d2 d3) (= d3 d4) (= d4 d1) (= d5 d6) (> d1 0))))

  (define (all-permutations lst)
    (if (null? lst)
        '(())
        (apply append
               (for/list ([x lst])
                 (map (lambda (p) (cons x p))
                      (all-permutations (remove x lst)))))))

  (define (check-square ps)
    (for*/or ([p1 (in-list ps)]
              [p2 (in-list ps)]
              [p3 (in-list ps)]
              [p4 (in-list ps)]
              #:when (not (= (length (remove-duplicates (list p1 p2 p3 p4))) 4)))
      (square? p1 p2 p3 p4)))

  (define (max-dist ps)
    (define max-d 0.0)
    (for ([p1 ps])
      (for ([p2 ps])
        (when (not (equal? p1 p2))
          (set! max-d (max max-d (distance p1 p2))))))
    max-d)

  (define all-possible (all-permutations points))
  (define best 0.0)
  (for ([perm all-possible])
    (when (check-square perm)
      (set! best (max best (max-dist perm)))))
  best)