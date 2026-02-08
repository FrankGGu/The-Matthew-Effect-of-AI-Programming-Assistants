#lang racket

(define (is-number s)
  (define (is-integer s)
    (and (not (equal? s ""))
         (let loop ([i 0])
           (cond [(= i (string-length s)) #t]
                 [(char=? (string-ref s i) #\+) #t]
                 [(char=? (string-ref s i) #\-) #t]
                 [(char-numeric? (string-ref s i)) (loop (+ i 1))]
                 [else #f]))))

  (define (is-scientific s)
    (let ([parts (string-split s "e")])
      (and (= (length parts) 2)
           (is-integer (car parts))
           (is-integer (cadr parts)))))

  (define (is-decimal s)
    (let ([parts (string-split s ".")])
      (and (= (length parts) 2)
           (or (and (is-integer (car parts)) (is-integer (cadr parts)))
               (and (equal? (car parts) "") (is-integer (cadr parts)))
               (and (is-integer (car parts)) (equal? (cadr parts) ""))))))

  (let ([s (string-trim s)])
    (or (is-integer s)
        (is-decimal s)
        (is-scientific s))))