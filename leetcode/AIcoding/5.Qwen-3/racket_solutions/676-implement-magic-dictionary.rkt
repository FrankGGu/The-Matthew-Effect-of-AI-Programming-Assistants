#lang racket

(define (make-magic-dictionary)
  (let ([words '()])
    (lambda (op . args)
      (cond
        [(equal? op 'buildDict)
         (set! words (car args))]
        [(equal? op 'search)
         (let ([word (car args)])
           (for/or ([w words])
             (and (= (string-length word) (string-length w))
                   (let ([diff 0])
                     (for ([i (in-range (string-length word))])
                       (when (not (char=? (string-ref word i) (string-ref w i)))
                         (set! diff (+ diff 1))
                         (when (> diff 1) (break))))
                     (= diff 1))))])])))

(define (main)
  (define magic-dict (make-magic-dictionary))
  (magic-dict 'buildDict '("hello" "leetcode"))
  (displayln (magic-dict 'search "hello")) ; #t
  (displayln (magic-dict 'search "hhllo")) ; #t
  (displayln (magic-dict 'search "hell")) ; #f
  (displayln (magic-dict 'search "leetcod")) ; #f
  (displayln (magic-dict 'search "leetcode")) ; #f))

(main)