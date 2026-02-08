#lang racket

(define (get-word-abbreviation word)
  (define len (string-length word))
  (if (<= len 2)
      word
      (string-append (substring word 0 1) (number->string (- len 2)) (substring word (- len 1) len))))

(define (count-words-with-abbrv words abbrv)
  (define len (string-length abbrv))
  (define target-len (if (<= len 2) len (string->number (substring abbrv 1 (- len 1)))))
  (define (valid? word)
    (and (= (string-length word) target-len)
         (= (string-ref word 0) (string-ref abbrv 0))
         (= (string-ref word (- (string-length word) 1)) (string-ref abbrv (- len 1)))))
  (length (filter valid? words)))

(define (main)
  (define input (read-line))
  (define words (map (lambda (s) (substring s 1 (- (string-length s) 1))) (string-split input #\,)))
  (define abbrv (read-line))
  (display (count-words-with-abbrv words abbrv)))

(main)