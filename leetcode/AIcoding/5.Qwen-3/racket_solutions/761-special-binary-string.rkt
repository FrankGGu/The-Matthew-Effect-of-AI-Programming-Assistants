#lang racket

(define (special-binary-string s)
  (define (helper s)
    (cond [(equal? s "") '()]
          [else
           (let loop ([s s] [count 0] [start 0] [res '()])
             (cond [(equal? s "") (reverse res)]
                   [(char=? (string-ref s 0) #\1)
                    (loop (substring s 1) (+ count 1) start res)]
                   [(= count 0)
                    (loop (substring s 1) 0 (add1 (string-length s)) res)]
                   [else
                    (loop (substring s 1) (- count 1) start (cons (substring s 0 (sub1 (string-length s))) res))]))]))
  (let loop ([s s] [res '()])
    (if (equal? s "")
        (string-join (map (lambda (x) (string-append "1" (helper x) "0")) res) "")
        (let* ([sub (substring s 0 (string-length s))]
               [split (helper sub)])
          (loop (substring s (string-length s)) (append res split))))))

(define (main)
  (let ([input (read-line)])
    (displayln (special-binary-string input))))

(main)