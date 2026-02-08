(define (longest-palindromic-substring s)
  (define (expand-around-center left right)
    (let loop ((l left) (r right))
      (if (and (>= l 0) (< r (string-length s)) (char=? (string-ref s l) (string-ref s r)))
          (loop (- l 1) (+ r 1))
          (substring s (+ l 1) r))))
  (cond
    [(= (string-length s) 0) ""]
    [else
     (let ((n (string-length s)))
       (let loop ((i 0) (max-len 0) (start 0))
         (if (= i n)
             (substring s start (+ start max-len))
             (let* ((len1 (string-length (expand-around-center i i)))
                    (len2 (string-length (expand-around-center i (+ i 1))))
                    (current-max (max len1 len2)))
               (if (> current-max max-len)
                   (loop (+ i 1) current-max (if (= len1 current-max) (- i (/ (- len1 1) 2)) (- i (/ (- len2 1) 2))))
                   (loop (+ i 1) max-len start))))))]))