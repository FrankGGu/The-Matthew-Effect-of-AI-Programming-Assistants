#lang racket

(define (describe-painting paintings)
  (define (merge-intervals intervals)
    (if (null? intervals)
        '()
        (let loop ([intervals intervals] [result '()])
          (if (null? intervals)
              (reverse result)
              (let* ([current (car intervals)]
                     [next (cadr intervals)])
                (if (and (not (null? next)) (<= (cdr current) (car next)))
                    (loop (cons (cons (car current) (max (cdr current) (cdr next))) (cddr intervals)) result)
                    (loop (cdr intervals) (cons current result))))))))

  (define (process-paintings paintings)
    (let loop ([paintings paintings] [intervals '()])
      (if (null? paintings)
          intervals
          (let* ([painting (car paintings)]
                 [start (car painting)]
                 [end (cadr painting)]
                 [color (caddr painting)])
            (loop (cdr paintings) (cons (cons start (cons end color)) intervals)))))

  (define (combine-colors intervals)
    (let loop ([intervals intervals] [result '()])
      (if (null? intervals)
          (reverse result)
          (let* ([interval (car intervals)]
                 [start (car interval)]
                 [end (cadr interval)]
                 [color (caddr interval)])
            (loop (cdr intervals) (cons (list start end color) result)))))

  (define (sort-intervals intervals)
    (sort intervals (lambda (a b) (< (car a) (car b)))))

  (define (get-result intervals)
    (let loop ([intervals intervals] [result '()])
      (if (null? intervals)
          (reverse result)
          (let* ([interval (car intervals)]
                 [start (car interval)]
                 [end (cadr interval)]
                 [color (caddr interval)])
            (loop (cdr intervals) (cons (list start end color) result)))))

  (let* ([intervals (process-paintings paintings)]
         [sorted (sort-intervals intervals)]
         [merged (merge-intervals sorted)]
         [combined (combine-colors merged)])
    combined))