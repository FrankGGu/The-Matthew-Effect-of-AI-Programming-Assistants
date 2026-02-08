#lang racket

(define (to-negabinary n)
  (if (= n 0)
      '(0)
      (let loop ([n n] [res '()])
        (if (= n 0)
            res
            (let ([rem (modulo n 2)])
              (loop (- (quotient n -2) rem) (cons rem res)))))))

(define (from-negabinary nums)
  (let loop ([nums nums] [i 0] [sum 0])
    (if (null? nums)
        sum
        (loop (cdr nums) (+ i 1) (+ sum (* (car nums) (expt -2 i)))))))

(define (add-two-negabinary a b)
  (define (add a b)
    (let ([len (max (length a) (length b))])
      (let loop ([a (append (make-list (- len (length a)) 0) a)]
                [b (append (make-list (- len (length b)) 0) b)]
                [carry 0]
                [result '()])
        (if (null? a)
            (if (= carry 0)
                (reverse result)
                (reverse (cons carry result)))
            (let* ([digit-a (car a)]
                   [digit-b (car b)]
                   [sum (+ digit-a digit-b carry)]
                   [digit (modulo sum 2)]
                   [new-carry (- (quotient sum -2))])
              (loop (cdr a) (cdr b) new-carry (cons digit result)))))))
  (let ([sum (add a b)])
    (if (and (null? sum) (= (length sum) 0))
        '(0)
        (if (and (not (null? sum)) (= (last sum) 0))
            (reverse (take-right sum (- (length sum) 1)))
            (reverse sum))))

(define (main)
  (let ([a (map string->number (string-split (read-line)))]
        [b (map string->number (string-split (read-line)))])
    (let ([result (add-two-negabinary a b)])
      (string-join (map number->string result) ""))))

(main)