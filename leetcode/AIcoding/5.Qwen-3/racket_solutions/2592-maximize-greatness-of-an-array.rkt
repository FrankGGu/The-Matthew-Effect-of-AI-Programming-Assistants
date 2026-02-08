(define (maximize-greatness nums)
  (define (count-occurrences lst)
    (let loop ([lst lst] [counts '()])
      (if (null? lst)
          counts
          (loop (cdr lst) (cons (cons (car lst) (if (assoc (car lst) counts) (+ 1 (cdr (assoc (car lst) counts))) 1)) counts)))))

  (define (maximize-greatness-helper nums counts)
    (if (null? nums)
        0
        (let* ([num (car nums)]
               [count (cdr (assoc num counts))]
               [new-counts (cons (cons num (- count 1)) (filter (lambda (x) (not (= (car x) num))) counts))])
          (if (> count 0)
              (+ 1 (maximize-greatness-helper (cdr nums) new-counts))
              (maximize-greatness-helper (cdr nums) counts)))))

  (maximize-greatness-helper nums (count-occurrences nums)))