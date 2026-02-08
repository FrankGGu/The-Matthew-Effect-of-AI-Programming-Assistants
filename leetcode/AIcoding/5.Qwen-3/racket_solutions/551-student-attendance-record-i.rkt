(define (check-attendance record)
  (and (< (string-count record #\A) 2)
       (not (string-contains? record "AAA"))))