#lang racket

(define (median-sliding-window nums k)
  (define (insertion-sort lst x)
    (cond [(null? lst) (list x)]
          [(<= x (car lst)) (cons x lst)]
          [else (cons (car lst) (insertion-sort (cdr lst) x))]))

  (define (remove-element lst x)
    (cond [(null? lst) '()]
          [(equal? x (car lst)) (cdr lst)]
          [else (cons (car lst) (remove-element (cdr lst) x))]))

  (define (get-median sorted-lst)
    (let ([n (length sorted-lst)])
      (if (even? n)
          (/ (+ (list-ref sorted-lst (- (quotient n 2) 1))
                (list-ref sorted-lst (quotient n 2)))
             2)
          (list-ref sorted-lst (quotient n 2)))))

  (define (sliding-window-impl nums k)
    (cond [(null? nums) '()]
          [else
           (let* ([window (take nums k)]
                  [sorted-window (insertion-sort window (car window))]
                  [medians (list (get-median sorted-window))])
             (let loop ([i k] [sorted-window sorted-window] [medians medians])
               (if (= i (length nums))
                   medians
                   (let* ([out (list-ref nums (- i k))]
                          [in (list-ref nums i)]
                          [new-sorted (remove-element sorted-window out)]
                          [new-sorted (insertion-sort new-sorted in)])
                     (loop (+ i 1) new-sorted (append medians (list (get-median new-sorted)))))))]))

  (sliding-window-impl nums k))