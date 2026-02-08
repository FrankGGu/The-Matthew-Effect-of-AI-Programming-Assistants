#lang racket

(define (basic-calculator-iv s target)
  (define (parse s)
    (define (helper s i)
      (cond [(= i (string-length s)) '()]
            [(char=? #\space (string-ref s i)) (helper s (+ i 1))]
            [(char=? #\+ (string-ref s i)) (cons '+ (helper s (+ i 1)))]
            [(char=? #\- (string-ref s i)) (cons '- (helper s (+ i 1)))]
            [(char=? #\* (string-ref s i)) (cons '* (helper s (+ i 1)))]
            [(char=? #\/ (string-ref s i)) (cons '/ (helper s (+ i 1)))]
            [(char=? #\() (let ([res (helper s (+ i 1))])
                            (cons '() (append res (helper s (string-length s)))))]
            [(char=? #\)) (cons '() (helper s (+ i 1)))]
            [else
             (let ([j i])
               (let loop ()
                 (when (< j (string-length s))
                   (when (or (char=? #\+ (string-ref s j))
                             (char=? #\- (string-ref s j))
                             (char=? #\* (string-ref s j))
                             (char=? #\/ (string-ref s j))
                             (char=? #\space (string-ref s j))
                             (char=? #\() (string-ref s j)))
                   (break))
                 (set! j (+ j 1))
                 (loop))
               (cons (substring s i j) (helper s j)))]))
    (helper s 0))

  (define (eval expr vars)
    (cond [(null? expr) 0]
          [(number? (car expr)) (car expr)]
          [(eqv? (car expr) '+) (+ (eval (cadr expr) vars) (eval (caddr expr) vars))]
          [(eqv? (car expr) '-) (- (eval (cadr expr) vars) (eval (caddr expr) vars))]
          [(eqv? (car expr) '*)
           (* (eval (cadr expr) vars) (eval (caddr expr) vars))]
          [(eqv? (car expr) '/)
           (/ (eval (cadr expr) vars) (eval (caddr expr) vars))]
          [(eqv? (car expr) '()) (eval (cadr expr) vars)]
          [else (if (symbol? (car expr)) (lookup (car expr) vars) (error "invalid expression"))]))

  (define (lookup var vars)
    (cond [(null? vars) 0]
          [(eqv? (caar vars) var) (cadar vars)]
          [else (lookup var (cdr vars))]))

  (define (generate-vars expr)
    (let loop ([expr expr] [vars '()])
      (cond [(null? expr) vars]
            [(symbol? (car expr)) (loop (cdr expr) (cons (list (car expr) 0) vars))]
            [(eqv? (car expr) '()) (loop (cadr expr) vars)]
            [else (loop (cdr expr) vars)])))

  (define (simplify expr)
    (cond [(null? expr) '()]
          [(number? (car expr)) (cons (car expr) (simplify (cdr expr)))]
          [(eqv? (car expr) '+)
           (let ([left (simplify (cadr expr))] [right (simplify (caddr expr))])
             (if (and (number? left) (number? right)) (cons (+ left right) (simplify (cdddr expr)))
                 (cons '+ (append left right (simplify (cdddr expr))))))]
          [(eqv? (car expr) '-)
           (let ([left (simplify (cadr expr))] [right (simplify (caddr expr))])
             (if (and (number? left) (number? right)) (cons (- left right) (simplify (cdddr expr)))
                 (cons '- (append left right (simplify (cdddr expr))))))]
          [(eqv? (car expr) '*)
           (let ([left (simplify (cadr expr))] [right (simplify (caddr expr))])
             (if (and (number? left) (number? right)) (cons (* left right) (simplify (cdddr expr)))
                 (cons '* (append left right (simplify (cdddr expr))))))]
          [(eqv? (car expr) '/)
           (let ([left (simplify (cadr expr))] [right (simplify (caddr expr))])
             (if (and (number? left) (number? right)) (cons (/ left right) (simplify (cdddr expr)))
                 (cons '/ (append left right (simplify (cdddr expr))))))]
          [(eqv? (car expr) '()) (simplify (cadr expr))]
          [else (cons (car expr) (simplify (cdr expr)))]))

  (define (collect-vars expr)
    (let loop ([expr expr] [vars '()])
      (cond [(null? expr) vars]
            [(symbol? (car expr)) (loop (cdr expr) (cons (car expr) vars))]
            [(eqv? (car expr) '()) (loop (cadr expr) vars)]
            [else (loop (cdr expr) vars)])))

  (define (combine expr)
    (cond [(null? expr) '()]
          [(number? (car expr)) (cons (car expr) (combine (cdr expr)))]
          [(eqv? (car expr) '+)
           (let ([left (combine (cadr expr))] [right (combine (caddr expr))])
             (if (and (number? left) (number? right)) (cons (+ left right) (combine (cdddr expr)))
                 (cons '+ (append left right (combine (cdddr expr))))))]
          [(eqv? (car expr) '-)
           (let ([left (combine (cadr expr))] [right (combine (caddr expr))])
             (if (and (number? left) (number? right)) (cons (- left right) (combine (cdddr expr)))
                 (cons '- (append left right (combine (cdddr expr))))))]
          [(eqv? (car expr) '*)
           (let ([left (combine (cadr expr))] [right (combine (caddr expr))])
             (if (and (number? left) (number? right)) (cons (* left right) (combine (cdddr expr)))
                 (cons '* (append left right (combine (cdddr expr))))))]
          [(eqv? (car expr) '/)
           (let ([left (combine (cadr expr))] [right (combine (caddr expr))])
             (if (and (number? left) (number? right)) (cons (/ left right) (combine (cdddr expr)))
                 (cons '/ (append left right (combine (cdddr expr))))))]
          [(eqv? (car expr) '()) (combine (cadr expr))]
          [else (cons (car expr) (combine (cdr expr)))]))

  (define (evaluate expr)
    (let ([vars (generate-vars expr)])
      (let loop ([vars vars] [result 0])
        (if (null? vars)
            result
            (let ([var (caar vars)] [val (cadar vars)])
              (loop (cdr vars) (+ result (* val (eval expr (list (list var val))))))))))

  (define (diff expr)
    (cond [(null? expr) '()]
          [(number? (car expr)) '()]
          [(eqv? (car expr) '+) (append (diff (cadr expr)) (diff (caddr expr)))]
          [(eqv? (car expr) '-) (append (diff (cadr expr)) (diff (caddr expr)))]
          [(eqv? (car expr) '*)
           (append (append (diff (cadr expr)) (list (list '* (caddr expr))) (diff (caddr expr)) (list (list '* (cadr expr)))))]
          [(eqv? (car expr) '/)
           (append (append (diff (cadr expr)) (list (list '/ (caddr expr))) (diff (caddr expr)) (list (list '/ (cadr expr)) (list '- (list '1) (list '/ (caddr expr) (list '* (caddr expr) (caddr expr)))))))]
          [(eqv? (car expr) '()) (diff (cadr expr))]
          [else (list expr)]))

  (define (expand expr)
    (cond [(null? expr) '()]
          [(number? (car expr)) (list (car expr))]
          [(eqv? (car expr) '+) (append (expand (cadr expr)) (expand (caddr expr)))]
          [(eqv? (car expr) '-) (append (expand (cadr expr)) (map (lambda (x)