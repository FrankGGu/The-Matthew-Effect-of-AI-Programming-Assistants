(define (divide-players-into-teams-of-equal-skill skill)
  (let* ((sorted-skill (sort skill <))
         (n (length sorted-skill))
         (total (apply + sorted-skill)))
    (if (odd? n)
        -1
        (let loop ((i 0) (j (- n 1)) (res 0))
          (if (>= i j)
              res
              (let ((sum (+ (list-ref sorted-skill i) (list-ref sorted-skill j))))
                (if (= (* 2 sum) total)
                    (loop (+ i 1) (- j 1) (+ res (* (list-ref sorted-skill i) (list-ref sorted-skill j))))
                    -1)))))))