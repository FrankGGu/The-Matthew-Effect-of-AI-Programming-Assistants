#lang racket

(define (next-greater-element-iii n)
  (define digits (string->list (number->string n)))
  (define len (length digits))
  (define-values (i j)
    (let loop ([i (- len 2)])
      (cond [(< i 0) (values -1 -1)]
            [(< (list-ref digits i) (list-ref digits (+ i 1))) (values i (+ i 1))]
            [else (loop (- i 1))])))
  (when (= i -1) (void))
  (let loop ([j j])
    (when (< j len)
      (when (<= (list-ref digits i) (list-ref digits j))
        (let ([temp (list-ref digits i)])
          (set! digits (append (take digits i) (list (list-ref digits j)) (drop digits (+ i 1))))
          (set! digits (append (take digits i) (list temp) (drop digits (+ i 1))))
          (set! digits (append (take digits (+ i 1)) (reverse (drop digits (+ i 1)))))))
      (loop (+ j 1))))
  (if (= i -1) -1 (string->number (list->string digits))))

(next-greater-element-iii 123456789)