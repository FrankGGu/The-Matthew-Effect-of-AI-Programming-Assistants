#lang racket

(define (decode-string s)
  (define (helper s i)
    (let loop ([i i] [num 0] [stack '()])
      (cond
        [(= i (string-length s)) (values (reverse stack) i)]
        [(char=? (string-ref s i) #\])
         (let* ([acc (reverse (car stack))]
                [num (cadr stack)]
                [new-acc (apply string-append (for/list ([j (in-range num)]) acc))])
           (loop (+ i 1) 0 (cons new-acc (cdr stack))))]
        [(char=? (string-ref s i) #\[)
         (loop (+ i 1) 0 (cons (list num (list)) stack))]
        [(char>=? (string-ref s i) #\0) (loop (+ i 1) (* num 10) (cons (string-ref s i) (car stack)))]
        [else (loop (+ i 1) 0 (cons (string-ref s i) (car stack)))])))
  (let-values ([(result _) (helper s 0)]) (apply string-append result)))