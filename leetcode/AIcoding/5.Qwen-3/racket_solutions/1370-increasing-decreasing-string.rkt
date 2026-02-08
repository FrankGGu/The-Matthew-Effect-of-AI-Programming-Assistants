#lang racket

(define (sort-by-increasing-decreasing-string s)
  (define freq (make-hash))
  (for ([c s])
    (hash-update! freq c add1 0))
  (define res '())
  (let loop ()
    (when (not (hash-empty? freq))
      (for ([c (in-list (sort (hash-keys freq) char<?))])
        (when (> (hash-ref freq c) 0)
          (set! res (cons c res))
          (hash-update! freq c sub1))))
      (for ([c (in-list (reverse (sort (hash-keys freq) char<?)))]
            #:when (> (hash-ref freq c) 0))
        (set! res (cons c res))
        (hash-update! freq c sub1))
      (loop)))
  (list->string (reverse res)))