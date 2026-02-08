#lang racket

(define (reorder-log-files logs)
  (define (is-digit? s)
    (char-numeric? (string-ref s 0)))

  (define (log-key s)
    (let* ([split (string-split s " " 2)]
           [id (car split)]
           [content (cadr split)])
      (if (is-digit? content)
          (cons #t id)
          (cons #f (string-append content " " id)))))

  (sort logs (lambda (a b)
               (let ([ka (log-key a)]
                     [kb (log-key b)])
                 (if (equal? (car ka) (car kb))
                     (string<? (cdr ka) (cdr kb))
                     (if (car ka) #t #f))))) )