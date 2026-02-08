#lang racket

(define (subdomain-visit-count cpdomains)
  (define counts (make-hash))
  (for-each
   (lambda (s)
     (define parts (string-split s #\ ))
     (define count (string->number (car parts)))
     (define domain (cadr parts))
     (let loop ((d domain))
       (when (not (equal? d ""))
         (hash-update! counts d (λ (x) (+ x count)) 0)
         (define next-d (regexp-replace* #rx"^[^.]*\\." d ""))
         (loop next-d))))
   cpdomains)
  (hash->list counts))