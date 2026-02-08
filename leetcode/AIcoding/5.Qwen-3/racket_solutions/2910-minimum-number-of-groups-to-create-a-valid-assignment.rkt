#lang racket

(define (can-assign? counts group-size)
  (for/and ([c counts])
    (<= (quotient c group-size) (length counts))))

(define (minimum-groups counts)
  (define max-count (apply max counts))
  (define min-count (apply min counts))
  (define total (apply + counts))
  (define n (length counts))
  (define (find-min-group-size)
    (for/fold ([best #f]) ([g (in-range 1 (add1 max-count))])
      (if (can-assign? counts g)
          (if best (min best g) g)
          best)))
  (define group-size (find-min-group-size))
  (if group-size
      (quotient total group-size)
      (error "No valid group size found")))

(define (main)
  (define input (current-command-line-arguments))
  (define counts (map string->number (string-split (vector-ref input 0))))
  (displayln (minimum-groups counts)))

(main)