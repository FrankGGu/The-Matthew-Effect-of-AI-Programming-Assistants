(define (number-xor nums)
  (define (count-occurrences lst)
    (let loop ([lst lst] [counts '()])
      (if (null? lst)
          counts
          (let* ([num (car lst)]
                 [entry (assoc num counts)])
            (if entry
                (loop (cdr lst) (cons (cons num (+ 1 (cdr entry))) (remove entry counts)))
                (loop (cdr lst) (cons (cons num 1) counts)))))))
  (define (filter-twice counts)
    (filter (lambda (x) (= (cdr x) 2)) counts))
  (define (xor-values lst)
    (foldl (lambda (x acc) (bitwise-xor acc (car x))) 0 lst))
  (xor-values (filter-twice (count-occurrences nums))))