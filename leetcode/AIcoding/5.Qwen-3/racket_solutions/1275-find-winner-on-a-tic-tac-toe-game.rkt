#lang racket

(define (tictactoe m)
  (define (check-line a b c)
    (if (and (equal? a b) (equal? b c) (not (equal? a " ")))
        a
        #f))
  (define (check-win)
    (let ([rows (map (lambda (i) (list-ref m i)) (range 3)))
          [cols (map (lambda (j) (map (lambda (i) (list-ref (list-ref m i) j)) (range 3))) (range 3))]
          [diag1 (map (lambda (i) (list-ref (list-ref m i) i)) (range 3))]
          [diag2 (map (lambda (i) (list-ref (list-ref m (- 2 i)) i)) (range 3))])
      (or (ormap check-line rows)
          (ormap check-line cols)
          (check-line (car diag1) (cadr diag1) (caddr diag1))
          (check-line (car diag2) (cadr diag2) (caddr diag2)))))
  (define winner (check-win))
  (cond [(equal? winner "X") "A"]
        [(equal? winner "O") "B"]
        [else "Draw"]))