#lang racket

(define (find-destination tickets)
  (define (get-destinations)
    (for/fold ([dests '()]) ([ticket tickets])
      (cons (second ticket) dests)))

  (define (get-origins)
    (for/fold ([origs '()]) ([ticket tickets])
      (cons (first ticket) origs)))

  (define all-airports (append (get-origins) (get-destinations)))
  (define (count-airport airport)
    (length (filter (lambda (x) (equal? x airport)) all-airports)))

  (define (find-hub)
    (for/first ([airport all-airports]
                #:when (= (count-airport airport) 1))
      airport))

  (find-hub))

(define (main)
  (define input (read))
  (displayln (find-destination input)))

(main)