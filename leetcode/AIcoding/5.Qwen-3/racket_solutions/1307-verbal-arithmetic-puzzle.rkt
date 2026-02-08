#lang racket

(define (is-legal? digits mapping)
  (let ([a (car digits)]
        [b (cadr digits)]
        [c (caddr digits)])
    (and (not (= (vector-ref mapping a) 0))
         (not (= (vector-ref mapping b) 0))
         (not (= (vector-ref mapping c) 0)))))

(define (solve-puzzle letters words target)
  (define n (length letters))
  (define used (make-vector 10 #f))
  (define mapping (make-vector 26 #f))
  (define result #f)

  (define (backtrack index)
    (when (and (>= index n) (or (null? words) (null? target)))
      (set! result #t)
      #t)
    (when (>= index n)
      #f)
    (let ([letter (list-ref letters index)])
      (for ([d (in-range 10)])
        (when (not (vector-ref used d))
          (when (or (and (equal? letter (car words)) (not (= d 0)))
                    (and (equal? letter (car target)) (not (= d 0)))
                    (and (not (equal? letter (car words))) (not (equal? letter (car target))))
                    (and (equal? letter (car words)) (= d 0) (not (equal? letter (car target))))
                    (and (equal? letter (car target)) (= d 0) (not (equal? letter (car words)))))
            (vector-set! mapping letter d)
            (vector-set! used d #t)
            (when (backtrack (+ index 1))
              (set! result #t)
              (return #t))
            (vector-set! used d #f)
            (vector-set! mapping letter #f))))
      #f))

  (backtrack 0)
  result)

(define (verbal-arithmetic-puzzle words target)
  (define letters (append (apply append words) target))
  (define unique-letters (remove-duplicates letters))
  (if (> (length unique-letters) 10)
      #f
      (solve-puzzle unique-letters words target)))