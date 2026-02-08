#lang racket

(define (maximum-distance-arrays arrays)
  (define (min-key x) (car x))
  (define (max-key x) (cadr x))
  (define (min-val x) (caddr x))
  (define (max-val x) (cadddr x))
  (define (make-entry idx arr)
    (list idx (car arr) (last arr)))
  (define entries (map make-entry (range (length arrays)) arrays))
  (define sorted-entries (sort entries (lambda (a b) (< (min-key a) (min-key b)))))
  (define sorted-reverse-entries (sort entries (lambda (a b) (> (max-key b) (max-key a)))))
  (define (find-max-distance)
    (let loop ([i 0] [j 0] [max-dist 0])
      (if (or (= i (length sorted-entries)) (= j (length sorted-reverse-entries)))
          max-dist
          (let* ([entry-i (list-ref sorted-entries i)]
                 [entry-j (list-ref sorted-reverse-entries j)]
                 [idx-i (car entry-i)]
                 [idx-j (car entry-j)]
                 [val-i (min-val entry-i)]
                 [val-j (max-val entry-j)])
            (if (= idx-i idx-j)
                (loop (+ i 1) j max-dist)
                (loop i (+ j 1) (max max-dist (- val-j val-i))))))))
  (find-max-distance))