#lang racket

(define (find-min-steps-internal s c)
  (define memo (make-hash))
  (define (helper s count)
    (cond [(hash-has-key? memo s) (hash-ref memo s)]
          [(equal? s "") (values 0 #t)]
          [else
           (let loop ([i 0] [min-steps #f])
             (if (>= i (string-length s))
                 (begin
                   (hash-set! memo s (values (if min-steps min-steps +inf.0) #f))
                   (values (if min-steps min-steps +inf.0) #f))
                 (let ([j (string-length s)])
                   (let loop2 ([k i])
                     (if (>= k j)
                         (loop (+ i 1) min-steps)
                         (let ([new-s (string-append (substring s 0 i)
                                                     (substring s (+ k 1) j))])
                           (if (and (= (string-ref s i) (string-ref s k))
                                    (or (= (- k i) 0)
                                        (equal? (substring s i (+ k 1)) (substring s i (+ k 1)))))
                               (let-values ([(steps ok?) (helper new-s (+ count 1))])
                                 (if ok?
                                     (loop (+ i 1) (if min-steps (min steps min-steps) steps)))
                                     (loop (+ i 1) min-steps)))
                               (loop2 (+ k 1)))))))])))
  (let-values ([(steps ok?) (helper s 0)])
    (if ok? steps -1)))

(define (find-min-steps s target)
  (define (count-chars s)
    (for/fold ([counts '()]) ([c (in-string s)])
      (let ([ch (string c)])
        (if (assoc ch counts)
            (cons (cons ch (+ 1 (cdr (assoc ch counts)))) counts)
            (cons (cons ch 1) counts)))))
  (define (valid? s target)
    (let ([s-counts (count-chars s)]
          [target-counts (count-chars target)])
      (andmap (lambda (t) (let ([s-c (assoc (car t) s-counts)])
                           (and s-c (>= (cdr s-c) (cdr t))))) target-counts)))
  (if (not (valid? s target)) -1
      (find-min-steps-internal s 0)))