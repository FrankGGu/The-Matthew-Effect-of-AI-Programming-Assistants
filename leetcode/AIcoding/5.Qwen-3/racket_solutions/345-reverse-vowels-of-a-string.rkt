#lang racket

(define (reverse-vowels s)
  (define vowels #(#\a #\e #\i #\o #\u #\A #\E #\I #\O #\U))
  (define s-list (string->list s))
  (define vowel-indices
    (for/list ([i (in-range (length s-list))]
               #:when (member (list-ref s-list i) vowels))
      i))
  (define reversed-vowels
    (reverse (map (lambda (i) (list-ref s-list i)) vowel-indices)))
  (for/fold ([result s-list])
            ([i (in-value (reverse vowel-indices))]
             [v (in-list reversed-vowels)])
    (list-set result i v))
  (list->string (reverse (for/list ([c s-list]) c))))