(define (replace-substring s k)
  (define (count-cnt c)
    (let loop ([i 0] [cnt 0])
      (if (= i (string-length s))
          cnt
          (loop (+ i 1) (+ cnt (if (char=? (string-ref s i) c) 1 0))))))

  (define (min-replace)
    (let ([cnt (make-hash)])
      (for-each (lambda (c) (hash-set! cnt c 0)) '(#\w #\e #\r #\t))
      (let loop ([left 0] [right 0] [min-len (string-length s)])
        (if (>= right (string-length s))
            min-len
            (begin
              (hash-set! cnt (string-ref s right) (+ 1 (hash-ref cnt (string-ref s right))))
              (let ([current (hash-values cnt)])
                (if (and (<= (car current) (/ (string-length s) 4))
                         (<= (cadr current) (/ (string-length s) 4))
                         (<= (caddr current) (/ (string-length s) 4))
                         (<= (cadddr current) (/ (string-length s) 4)))
                    (let loop2 ([left left])
                      (if (or (>= left right) (not (and (<= (hash-ref cnt (string-ref s left)) (/ (string-length s) 4))
                                                       (<= (hash-ref cnt (string-ref s left)) (/ (string-length s) 4))
                                                       (<= (hash-ref cnt (string-ref s left)) (/ (string-length s) 4))
                                                       (<= (hash-ref cnt (string-ref s left)) (/ (string-length s) 4)))))
                          (begin
                            (hash-set! cnt (string-ref s left) (- (hash-ref cnt (string-ref s left)) 1))
                            (loop (+ left 1) right (min min-len (- right left))))
                          (begin
                            (hash-set! cnt (string-ref s left) (- (hash-ref cnt (string-ref s left)) 1))
                            (loop (+ left 1) right min-len))))
                    (loop left (+ right 1) min-len)))))))

  (if (<= (string-length s) 4)
      0
      (min-replace)))