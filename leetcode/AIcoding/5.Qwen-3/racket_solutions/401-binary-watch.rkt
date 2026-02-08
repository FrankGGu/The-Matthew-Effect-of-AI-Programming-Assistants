#lang racket

(define (read-binary-watches num)
  (define (count-bits n)
    (let loop ([n n] [count 0])
      (if (= n 0)
          count
          (loop (arithmetic-shift n -1) (+ count (bitwise-and n 1))))))
  (define (generate-time hours minutes)
    (string-append (number->string hours) ":" (string-pad-left (number->string minutes) 2 #\0)))
  (define result '())
  (for ([h (in-range 0 12)])
    (for ([m (in-range 0 60)])
      (when (= (count-bits h) (count-bits m) num)
        (set! result (cons (generate-time h m) result)))))
  (reverse result))