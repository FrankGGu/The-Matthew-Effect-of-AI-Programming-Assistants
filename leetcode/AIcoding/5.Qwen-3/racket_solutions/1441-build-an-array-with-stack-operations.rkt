(define (build-array target n)
  (define (helper res i)
    (if (> i (length target))
        res
        (let ((num (list-ref target (- i 1))))
          (if (= num i)
              (helper (append res (list "Push")) (+ i 1))
              (helper (append res (list "Push" "Pop")) (+ i 1))))))
  (helper '() 1))