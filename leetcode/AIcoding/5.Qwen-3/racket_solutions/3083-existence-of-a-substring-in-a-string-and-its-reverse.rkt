#lang racket

(define (is-substring-present s)
  (define reversed-s (reverse (string->list s)))
  (define len (string-length s))
  (define (check i)
    (and (< i (- len 1))
         (let ((sub (substring s i (+ i 2))))
           (or (member (list->string sub) (map list->string (take-reversed-strings reversed-s)))
               (check (+ i 1)))))
  (check 0))

(define (take-reversed-strings lst)
  (define len (length lst))
  (define (iter i res)
    (if (>= i (- len 1))
        res
        (iter (+ i 1) (cons (take lst (+ i 2)) res))))
  (reverse (iter 0 '())))

(define (main)
  (define s (read-line))
  (if (is-substring-present s)
      (display "true")
      (display "false")))

(main)