(define (partition-string s k)
  (define (char->num c)
    (- (char->integer c) (char->integer #\0)))
  (define (valid? s)
    (let loop ((i 0) (current 0))
      (cond ((= i (string-length s)) #t)
            ((> current k) #f)
            (else
             (let ((digit (char->num (string-ref s i))))
               (if (> (+ (* current 10) digit) k)
                   #f
                   (loop (+ i 1) (+ (* current 10) digit))))))))
  (define (dfs idx res)
    (if (= idx (string-length s))
        res
        (let loop ((i (+ idx 1)))
          (if (> i (string-length s))
              #f
              (let ((sub (substring s idx i)))
                (if (valid? sub)
                    (let ((new-res (cons sub res)))
                      (if (dfs i new-res)
                          new-res
                          (loop (+ i 1))))
                    (loop (+ i 1))))))))
  (let ((result (dfs 0 '())))
    (if result
        (length result)
        -1)))