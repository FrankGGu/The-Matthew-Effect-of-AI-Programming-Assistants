#lang racket

(define (is-possible word word-set)
  (define dp (make-vector (add1 (string-length word)) #f))
  (vector-set! dp 0 #t)
  (for ([i (in-range (string-length word))])
    (when (vector-ref dp i)
      (for ([j (in-range (add1 (string-length word)))])
        (when (and (<= (+ i j) (string-length word)) (set-member? word-set (substring word i (+ i j))))
          (vector-set! dp (+ i j) #t)))))
  (vector-ref dp (string-length word)))

(define (find-words words)
  (define word-set (apply set words))
  (define sorted-words (sort words (lambda (a b) (< (string-length a) (string-length b)))))
  (define result '())
  (for ([word sorted-words])
    (when (is-possible word word-set)
      (set! result (cons word result))))
  (reverse result))

(define (main)
  (define input (current-input-port))
  (define words (read input))
  (define result (find-words words))
  (displayln result))

(main)