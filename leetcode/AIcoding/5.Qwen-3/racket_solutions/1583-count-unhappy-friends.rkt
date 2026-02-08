#lang racket

(define (unhappy? a friends-map)
  (define a-friends (hash-ref friends-map a))
  (for/first ([f (in-list a-friends)]
              #:when (not (member a (hash-ref friends-map f))))
    #t)
  #f)

(define (count-unhappy-friends df)
  (define friends-map (make-hash))
  (for ([pair (in-list df)])
    (define a (car pair))
    (define b (cadr pair))
    (hash-set! friends-map a (cons b (hash-ref friends-map a '())))
    (hash-set! friends-map b (cons a (hash-ref friends-map b '()))))
  (define names (apply append df))
  (define unique-names (remove-duplicates names))
  (for/sum ([name (in-list unique-names)]
            #:when (unhappy? name friends-map))
    1))

(define (main)
  (define input '((0 1) (1 0) (2 3) (3 2)))
  (displayln (count-unhappy-friends input)))

(main)