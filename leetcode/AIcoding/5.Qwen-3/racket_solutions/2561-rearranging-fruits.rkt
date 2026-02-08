#lang racket

(define (min-operations basket)
  (define (count-fruit fruits)
    (for/fold ([counts '()]) ([f fruits])
      (if (member f counts)
          counts
          (cons f counts))))
  (define (get-positions fruits target)
    (for/list ([i (in-range (length fruits))]
               #:when (= (list-ref fruits i) target))
      i))
  (define (swap! a b lst)
    (let ([tmp (list-ref lst a)])
      (vector-set! lst a (list-ref lst b))
      (vector-set! lst b tmp)
      lst))
  (define (solve lst)
    (let ([n (length lst)]
          [fruits (count-fruit lst)])
      (cond [(= (length fruits) 1) 0]
            [(= (length fruits) 2)
             (let ([a (get-positions lst (car fruits))]
                   [b (get-positions lst (cadr fruits))])
               (if (and (not (null? a)) (not (null? b)))
                   (let ([a (car a)]
                         [b (car b)])
                     (if (= (abs (- a b)) 1)
                         1
                         2))
                   0))]
            [else
             (let ([positions (map (lambda (f) (get-positions lst f)) fruits)])
               (let loop ([positions positions]
                          [count 0])
                 (if (null? positions)
                     count
                     (let ([p (car positions)])
                       (if (null? p)
                           (loop (cdr positions) count)
                           (let ([pos (car p)])
                             (if (= pos (length lst))
                                 (loop (cdr positions) count)
                                 (let ([next (if (= (car (reverse positions)) (length lst)) (length lst) (add1 pos))])
                                   (swap! pos next lst)
                                   (loop (map (lambda (x) (if (equal? x p) (list next) x)) positions) (add1 count))))))))))])))
  (solve (vector->list (apply vector basket)))