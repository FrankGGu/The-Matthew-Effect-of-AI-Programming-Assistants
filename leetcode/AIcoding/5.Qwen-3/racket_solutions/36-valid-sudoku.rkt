#lang racket

(define (valid-sudoku board)
  (define (valid? lst)
    (let loop ([lst lst] [seen '()])
      (cond [(null? lst) #t]
            [(and (not (equal? (car lst) ".")) (member (car lst) seen)) #f]
            [else (loop (cdr lst) (cons (car lst) seen))])))

  (define (row-valid? i)
    (valid? (list-ref board i)))

  (define (col-valid? j)
    (valid? (map (lambda (row) (list-ref row j)) board)))

  (define (box-valid? i j)
    (let ([start-i (* 3 (quotient i 3))]
          [start-j (* 3 (quotient j 3))])
      (valid? (flatten (map (lambda (x)
                              (take (drop (list-ref board x) start-j) 3))
                            (range start-i (+ start-i 3)))))))

  (let loop ([i 0])
    (cond [(= i 9) #t]
          [(or (not (row-valid? i))
               (not (col-valid? i))
               (not (box-valid? i 0))) #f]
          [else (loop (+ i 1))])))