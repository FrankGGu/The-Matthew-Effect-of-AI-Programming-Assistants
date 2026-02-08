#lang racket

(define (high-access-employees logs)
  (define (parse-log s)
    (let* ([parts (string-split s)]
           [name (car parts)]
           [time (string->number (cadr parts))])
      (cons name time)))

  (define (sort-logs logs)
    (sort logs (lambda (a b)
                 (if (equal? (car a) (car b))
                     (< (cdr a) (cdr b))
                     (string<? (car a) (car b)))))

  (define (check-high-access name logs)
    (define filtered (filter (lambda (x) (equal? (car x) name)) logs))
    (and (>= (length filtered) 3)
         (let loop ([i 0] [count 0])
           (cond [(>= i (- (length filtered) 2)) #t]
                 [(<= (- (cdar (list-ref filtered (+ i 2))) (cdar (list-ref filtered i))) 200)
                  (loop (+ i 1) (+ count 1))]
                 [else #f]))))

  (define sorted (sort-logs logs))
  (define names (map car (remove-duplicates sorted)))
  (filter (lambda (name) (check-high-access name sorted)) names))