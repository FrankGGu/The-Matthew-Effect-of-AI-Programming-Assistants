#lang racket

(define (find-path target)
  (define (move from to)
    (let ([x1 (car from)]
          [y1 (cadr from)]
          [x2 (car to)]
          [y2 (cadr to)])
      (append
       (if (> x2 x1) (make-list (- x2 x1) #\D) '())
       (if (< x2 x1) (make-list (- x1 x2) #\U) '())
       (if (> y2 y1) (make-list (- y2 y1) #\R) '())
       (if (< y2 y1) (make-list (- y1 y2) #\L) '()))))

  (define (char->pos c)
    (let ([n (- (char->integer c) (char->integer #\a))])
      (cons (quotient n 5) (remainder n 5))))

  (define (path-helper pos path)
    (if (null? pos)
        (list->string (reverse path))
        (let* ([current (car pos)]
               [next (cadr pos)])
          (path-helper (cdr pos) (append (move current next) (list (car pos))))))
    )

  (define target-pos (char->pos target))
  (define board (map (lambda (i) (list (quotient i 5) (remainder i 5))) (range 26)))
  (define start (cons 0 0))
  (define path (path-helper (cons start target-pos) '()))
  (list->string (reverse path)))

(define (alphabet-board-path target)
  (define (char->pos c)
    (let ([n (- (char->integer c) (char->integer #\a))])
      (cons (quotient n 5) (remainder n 5))))

  (define (move from to)
    (let ([x1 (car from)]
          [y1 (cadr from)]
          [x2 (car to)]
          [y2 (cadr to)])
      (append
       (if (> x2 x1) (make-list (- x2 x1) #\D) '())
       (if (< x2 x1) (make-list (- x1 x2) #\U) '())
       (if (> y2 y1) (make-list (- y2 y1) #\R) '())
       (if (< y2 y1) (make-list (- y1 y2) #\L) '()))))

  (define (path-helper pos path)
    (if (null? pos)
        (list->string (reverse path))
        (let* ([current (car pos)]
               [next (cadr pos)])
          (path-helper (cdr pos) (append (move current next) (list (car pos))))))
    )

  (define target-pos (char->pos target))
  (define board (map (lambda (i) (list (quotient i 5) (remainder i 5))) (range 26)))
  (define start (cons 0 0))
  (define path (path-helper (cons start target-pos) '()))
  (list->string (reverse path)))