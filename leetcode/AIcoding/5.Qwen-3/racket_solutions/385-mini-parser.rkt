#lang racket

(define (parse-nested-list s)
  (define (helper s i)
    (cond [(char=? (string-ref s i) #\]) (values '() (+ i 1))]
          [(char=? (string-ref s i) #\[) (helper s (+ i 1))]
          [(char=? (string-ref s i) #\,) (helper s (+ i 1))]
          [(char=? (string-ref s i) #\-) (let-values ([(num j) (parse-number s (+ i 1))])
                                          (values (list num) j))]
          [else (let-values ([(num j) (parse-number s i)])
                  (values (list num) j))]))

  (define (parse-number s i)
    (let loop ([i i] [digits '()])
      (if (and (< i (string-length s)) (char-numeric? (string-ref s i)))
          (loop (+ i 1) (cons (string-ref s i) digits))
          (values (string->number (list->string (reverse digits))) i))))

  (define-values (result _) (helper s 0))
  result)

(define (make-integer n) (list 'Integer n))
(define (make-list l) (list 'List l))

(define (mini-parser s)
  (define (parse s)
    (cond [(string=? s "") null]
          [(char=? (string-ref s 0) #$$) (parse (substring s 1 (- (string-length s) 1)))]
          [(char=? (string-ref s 0) #\-) (make-integer (string->number s))]
          [(char-numeric? (string-ref s 0)) (make-integer (string->number s))]
          [else (let ([lst (parse-nested-list s)])
                  (if (null? lst) null (make-list lst)))]))

  (parse s))