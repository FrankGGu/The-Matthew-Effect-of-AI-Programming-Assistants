#lang racket

(define (score-expr expr)
  (define (eval-expr s)
    (let loop ([s s] [stack '()] [num 0] [op #f])
      (cond
        [(null? s) (if op (apply-op op stack num) num)]
        [(char=? (car s) #\+) (loop (cdr s) (cons num stack) 0 #\+)]
        [(char=? (car s) #\-) (loop (cdr s) (cons num stack) 0 #\-)]
        [(char=? (car s) #\*) (loop (cdr s) (cons num stack) 0 #\*)]
        [(char=? (car s) #\/) (loop (cdr s) (cons num stack) 0 #\/)]
        [else (loop (cdr s) stack (+ (* num 10) (- (char->integer (car s)) 48)) op)])))

  (define (apply-op op stack num)
    (cond
      [(null? stack) num]
      [else
       (let ([prev (car stack)])
         (cond
           [(char=? op #\+) (cons (+ prev num) (cdr stack))]
           [(char=? op #\-) (cons (- prev num) (cdr stack))]
           [(char=? op #\*) (cons (* prev num) (cdr stack))]
           [(char=? op #\/) (cons (quotient prev num) (cdr stack))]))]))

  (eval-expr (string->list expr)))

(define (scoreOfStudents* target exprs)
  (define (parse expr)
    (let ([s (string->list expr)])
      (let loop ([s s] [stack '()] [num 0] [op #f])
        (cond
          [(null? s) (if op (apply-op op stack num) num)]
          [(char=? (car s) #\+) (loop (cdr s) (cons num stack) 0 #\+)]
          [(char=? (car s) #\-) (loop (cdr s) (cons num stack) 0 #\-)]
          [(char=? (car s) #\*) (loop (cdr s) (cons num stack) 0 #\*)]
          [(char=? (car s) #\/) (loop (cdr s) (cons num stack) 0 #\/)]
          [else (loop (cdr s) stack (+ (* num 10) (- (char->integer (car s)) 48)) op)]))))

  (define (apply-op op stack num)
    (cond
      [(null? stack) num]
      [else
       (let ([prev (car stack)])
         (cond
           [(char=? op #\+) (cons (+ prev num) (cdr stack))]
           [(char=? op #\-) (cons (- prev num) (cdr stack))]
           [(char=? op #\*) (cons (* prev num) (cdr stack))]
           [(char=? op #\/) (cons (quotient prev num) (cdr stack))]))))

  (define (valid? val)
    (and (>= val 1) (<= val 1000)))

  (define (compute expr)
    (let ([res (parse expr)])
      (if (and (number? res) (valid? res)) res #f)))

  (define (process expr)
    (let ([val (compute expr)])
      (and val (= val target))))

  (for/sum ([expr exprs])
    (if (process expr) 1 0)))

(define (scoreOfStudents target exprs)
  (scoreOfStudents* target exprs))