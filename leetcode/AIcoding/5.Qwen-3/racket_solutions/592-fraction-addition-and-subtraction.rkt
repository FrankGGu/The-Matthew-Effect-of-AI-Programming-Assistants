#lang racket

(define (fraction-addition-and-subtraction expression)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

  (define (lcm a b)
    (/ (* a b) (gcd a b)))

  (define (reduce a b)
    (let ((g (gcd (abs a) (abs b))))
      (values (/ a g) (/ b g))))

  (define (add a1 b1 a2 b2)
    (let* ((l (lcm b1 b2))
           (a (+ (* a1 (/ l b1)) (* a2 (/ l b2)))))
      (reduce a l)))

  (define (parse-expression expr)
    (define (parse-number start)
      (let loop ((i start) (digits '()))
        (if (or (>= i (string-length expr)) (not (char-numeric? (string-ref expr i))))
            (values (string->number (list->string (reverse digits))) i)
            (loop (+ i 1) (cons (string-ref expr i) digits)))))

    (define (parse-fraction start)
      (let-values (((num end) (parse-number start)))
        (if (and (< end (string-length expr)) (char=? #\/ (string-ref expr end)))
            (let-values (((den end2) (parse-number (+ end 1))))
              (values num den end2))
            (values num 1 end))))

    (define (parse-expr start)
      (if (>= start (string-length expr))
          '()
          (let-values (((num den end) (parse-fraction start)))
            (cons (cons num den) (parse-expr end)))))

    (parse-expr 0))

  (define (evaluate fractions)
    (if (null? fractions)
        (values 0 1)
        (let* ((first (car fractions))
               (rest (cdr fractions))
               (result (evaluate rest)))
          (add (car first) (cdr first) (car result) (cdr result)))))

  (let-values (((num den) (evaluate (parse-expression expression))))
    (string-append (number->string num) "/" (number->string den))) )