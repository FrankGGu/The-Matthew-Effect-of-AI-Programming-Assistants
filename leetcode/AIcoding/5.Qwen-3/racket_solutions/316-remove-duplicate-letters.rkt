#lang racket

(define (remove-duplicate-letters s)
  (define (helper s stack seen last-occurrence)
    (cond [(null? s) (list->string (reverse stack))]
          [else
           (let ([c (car s)])
             (if (member c seen)
                 (helper (cdr s) stack seen last-occurrence)
                 (let ([last-index (hash-ref last-occurrence c)])
                   (if (and (not (null? stack))
                            (> last-index (hash-ref last-occurrence (car stack))))
                       (begin
                         (set! seen (remove (car stack) seen))
                         (helper s (cdr stack) seen last-occurrence))
                       (begin
                         (set! seen (cons c seen))
                         (helper (cdr s) (cons c stack) seen last-occurrence))))))]))
  (define last-occurrence (for/hash ([i (in-range (string-length s))] [c (in-string s)]) (values c i)))
  (helper (string->list s) '() '() last-occurrence))