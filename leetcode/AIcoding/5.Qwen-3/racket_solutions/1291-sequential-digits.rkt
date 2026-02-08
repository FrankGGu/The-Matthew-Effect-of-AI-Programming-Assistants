#lang racket

(define (seq-digits n)
  (define (generate-seq start length)
    (if (> start 9)
        '()
        (let ((current (string->number (apply string (map number->string (range start (+ start length))))))
              (rest (generate-seq (+ start 1) length)))
          (cons current rest))))

  (define (get-all-sequences)
    (append*
     (for/list ([length (in-range 2 (+ n 1))])
       (generate-seq 1 length))))

  (sort (get-all-sequences) <))