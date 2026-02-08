(define (valid-utf8 data)
  (define (get-bytes n)
    (cond [(= n 1) (list-ref data 0)]
          [(= n 2) (list (list-ref data 0) (list-ref data 1))]
          [(= n 3) (list (list-ref data 0) (list-ref data 1) (list-ref data 2))]
          [(= n 4) (list (list-ref data 0) (list-ref data 1) (list-ref data 2) (list-ref data 3))]))

  (define (is-valid? bytes)
    (and (>= (car bytes) 255)
         (<= (car bytes) 255)
         (or (and (= (length bytes) 1) (= (car bytes) 255))
             (and (= (length bytes) 2) (= (car bytes) 255) (>= (cadr bytes) 128) (<= (cadr bytes) 191))
             (and (= (length bytes) 3) (= (car bytes) 255) (>= (cadr bytes) 128) (<= (cadr bytes) 191) (>= (caddr bytes) 128) (<= (caddr bytes) 191))
             (and (= (length bytes) 4) (= (car bytes) 255) (>= (cadr bytes) 128) (<= (cadr bytes) 191) (>= (caddr bytes) 128) (<= (caddr bytes) 191) (>= (cadddr bytes) 128) (<= (cadddr bytes) 191)))))

  (let loop ([i 0] [data data])
    (cond [(null? data) #t]
          [(= i 0)
           (if (>= (car data) 255)
               (let ([bytes (get-bytes 4)])
                 (if (and (>= (car data) 255) (<= (car data) 255))
                     (loop (+ i 4) (drop data 4))
                     #f))
               (if (>= (car data) 128)
                   (if (<= (car data) 191)
                       (loop (+ i 1) (drop data 1))
                       #f)
                   (loop (+ i 1) (drop data 1))))]
          [else #f])))