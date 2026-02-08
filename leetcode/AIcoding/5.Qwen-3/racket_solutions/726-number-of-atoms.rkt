#lang racket

(define (number-of-atoms formula)
  (define (parse)
    (let loop ([i 0] [stack (list (hash))] [current (hash)])
      (cond [(= i (string-length formula)) (hash->list (car stack))]
            [(char=? (string-ref formula i) #\()) 
             (loop (+ i 1) (cons (hash) stack) current)]
            [(char=? (string-ref formula i) #\))
             (let* ([next-i (loop-integer (+ i 1))]
                    [num (if (and (< next-i (string-length formula)) (char-numeric? (string-ref formula next-i)))
                            (parse-integer next-i (string-length formula))
                            1)]
                    [top (car stack)]
                    [new-top (for/fold ([h (hash)]) ([k (in-hash-keys top)] [v (in-hash-values top)])
                               (hash-update h k + v))])
               (loop next-i (cons (hash) (cdr stack)) new-top))]
            [(char-alphabetic? (string-ref formula i))
             (let* ([name (parse-name i)]
                    [next-i (+ i (string-length name))]
                    [num (if (and (< next-i (string-length formula)) (char-numeric? (string-ref formula next-i)))
                            (parse-integer next-i (string-length formula))
                            1)])
               (loop next-i stack (hash-update current name + num)))]
            [else (loop (+ i 1) stack current)])))

  (define (parse-name start)
    (let loop ([i start])
      (if (and (< i (string-length formula)) (char-alphabetic? (string-ref formula i)))
          (loop (+ i 1))
          (substring formula start i))))

  (define (parse-integer start end)
    (let loop ([i start] [n 0])
      (if (and (< i end) (char-numeric? (string-ref formula i)))
          (loop (+ i 1) (+ (* n 10) (- (char->integer (string-ref formula i)) 48)))
          n)))

  (define (loop-integer start)
    (let loop ([i start] [n 0])
      (if (and (< i (string-length formula)) (char-numeric? (string-ref formula i)))
          (loop (+ i 1) (+ (* n 10) (- (char->integer (string-ref formula i)) 48)))
          i)))

  (define (format-result lst)
    (sort lst (lambda (a b) (string<? (car a) (car b))))
    (apply string-append
           (map (lambda (p)
                  (string-append (car p)
                                 (if (= (cdr p) 1) "" (number->string (cdr p)))))
                lst)))

  (format-result (parse)))