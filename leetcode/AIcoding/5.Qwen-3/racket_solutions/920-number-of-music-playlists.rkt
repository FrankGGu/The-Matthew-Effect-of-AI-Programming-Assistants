#lang racket

(define (num-music-playlists n k d)
  (define dp (make-hash))
  (define (helper i j)
    (cond [(and (= i 0) (= j 0)) 1]
          [(or (< i 0) (< j 0)) 0]
          [else
           (hash-ref dp (cons i j)
                     (lambda ()
                       (let ([res (+ (* (- n k) (helper (sub1 i) j))
                                     (* j (helper i (sub1 j))))])
                         (hash-set! dp (cons i j) res)
                         res)))]))
  (helper n d))