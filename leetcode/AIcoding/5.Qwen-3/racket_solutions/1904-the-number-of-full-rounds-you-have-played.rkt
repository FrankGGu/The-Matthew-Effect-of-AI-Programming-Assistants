#lang racket

(define (number-of-full-rouns-played start end)
  (define (to-minutes time)
    (match-define (list h m) (map string->number (string-split time ":")))
    (+ (* h 60) m))

  (define s (to-minutes start))
  (define e (to-minutes end))

  (if (> s e)
      (- (quotient (- 1440 s) 60) (quotient e 60))
      (- (quotient e 60) (quotient s 60))))

(define (main)
  (let* ((start (read-line))
         (end (read-line)))
    (printf "~a\n" (number-of-full-rouns-played start end))))

(main)