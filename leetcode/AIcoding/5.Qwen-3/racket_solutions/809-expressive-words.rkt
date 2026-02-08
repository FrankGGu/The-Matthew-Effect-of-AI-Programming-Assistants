#lang racket

(define (expressive-words s words)
  (define (is-expressive s1 s2)
    (define (helper i j)
      (cond [(and (= i (string-length s1)) (= j (string-length s2))) #t]
            [(or (= i (string-length s1)) (= j (string-length s2))) #f]
            [else
             (if (char=? (string-ref s1 i) (string-ref s2 j))
                 (let loop ([i i] [j j] [count 1])
                   (if (and (< i (string-length s1)) (char=? (string-ref s1 i) (string-ref s1 (sub1 i))))
                       (loop (add1 i) j (add1 count))
                       (let ([count2 1])
                         (if (and (< j (string-length s2)) (char=? (string-ref s2 j) (string-ref s2 (sub1 j))))
                             (let loop2 ([j (add1 j)] [count2 1])
                               (if (and (< j (string-length s2)) (char=? (string-ref s2 j) (string-ref s2 (sub1 j))))
                                   (loop2 (add1 j) (add1 count2))
                                   (if (and (>= count2 3) (>= count2 count))
                                       (helper i j)
                                       #f)))
                             (if (>= count 3)
                                 (helper i j)
                                 #f)))))
                 #f)]))
    (helper 0 0))
  (length (filter (lambda (w) (is-expressive s w)) words)))

(define (main)
  (define s (read-line))
  (define n (string->number (read-line)))
  (define words (for/list ([i (in-range n)]) (read-line)))
  (displayln (expressive-words s words)))

(main)