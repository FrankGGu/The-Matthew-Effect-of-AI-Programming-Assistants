#lang racket

(define (remove-occurrences s part)
  (let loop ([s s])
    (let ([pos (string-contains s part)])
      (if pos
          (loop (string-append (substring s 0 pos) (substring s (+ pos (string-length part)))))
          s))))