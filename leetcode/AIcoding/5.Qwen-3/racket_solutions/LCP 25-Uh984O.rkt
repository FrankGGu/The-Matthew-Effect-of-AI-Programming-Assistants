#lang racket

(define (find-words words)
  (define row1 #(#\q #\w #\e #\r #\t #\y #\u #\i #\o #\p))
  (define row2 #(#\a #\s #\d #\f #\g #\h #\j #\k #\l))
  (define row3 #(#\z #\x #\c #\v #\b #\n #\m))
  (define (in-row? ch row)
    (member ch row))
  (define (valid-word? word)
    (let ((first-ch (string-ref word 0)))
      (cond
        [(in-row? first-ch row1) (andmap (lambda (ch) (in-row? ch row1)) (string->list word))]
        [(in-row? first-ch row2) (andmap (lambda (ch) (in-row? ch row2)) (string->list word))]
        [(in-row? first-ch row3) (andmap (lambda (ch) (in-row? ch row3)) (string->list word))]))
  )
  (filter valid-word? words))