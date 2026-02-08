(define (find-2d-array nums)
  (define (count-freq lst)
    (let loop ([lst lst] [freq '()])
      (if (null? lst)
          freq
          (let* ([x (car lst)]
                 [entry (assoc x freq)])
            (if entry
                (loop (cdr lst) (cons (cons x (+ 1 (cdr entry))) (remove entry freq)))
                (loop (cdr lst) (cons (cons x 1) freq)))))))

  (define (build-2d-array freq)
    (let loop ([freq freq] [result '()])
      (if (null? freq)
          result
          (let* ([max-count (apply max (map cdr freq))]
                 [current-row (map car (filter (lambda (x) (= (cdr x) max-count)) freq))])
            (loop (map (lambda (x) (if (= (cdr x) max-count) (cons (car x) (- (cdr x) 1)) x)) freq)
                  (cons current-row result))))))

  (reverse (build-2d-array (count-freq nums))))