#lang racket

(define (add-strings num1 num2)
  (define (char->int c)
    (- (char->integer c) (char->integer #\0)))
  (define (int->char i)
    (integer->char (+ i (char->integer #\0))))
  (define (add-digit a b carry)
    (let* ([sum (+ (char->int a) (char->int b) carry)])
      (values (int->char (modulo sum 10)) (quotient sum 10))))
  (define (loop i j carry result)
    (if (and (= i 0) (= j 0))
        (if (= carry 0)
            (list->string (reverse result))
            (cons (int->char carry) (reverse result)))
        (let* ([a (if (> i 0) (string-ref num1 (- i 1)) #\0)]
               [b (if (> j 0) (string-ref num2 (- j 1)) #\0)]
               [result-carry (add-digit a b carry)])
          (loop (- i 1) (- j 1) (cadr result-carry) (cons (car result-carry) result)))))
  (loop (string-length num1) (string-length num2) 0 '()))