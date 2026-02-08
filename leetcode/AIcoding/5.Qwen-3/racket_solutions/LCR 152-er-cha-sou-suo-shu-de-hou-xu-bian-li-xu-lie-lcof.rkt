#lang racket

(define (verify-postorder sequence)
  (define (helper i j)
    (if (>= i j) #t
        (let ((root (list-ref sequence j)))
          (let loop ((k i))
            (if (>= k j) #t
                (if (> (list-ref sequence k) root)
                    (let ((m k))
                      (let loop2 ((l m))
                        (if (>= l j) #t
                            (if (<= (list-ref sequence l) root)
                                #f
                                (loop2 (+ l 1))))))
                    (loop (+ k 1)))))))
  (helper 0 (- (length sequence) 1)))