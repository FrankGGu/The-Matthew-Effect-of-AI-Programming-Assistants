(define (dest-city paths)
  (let ([out-degree (make-hash)]
        [in-degree (make-hash)])
    (for-each
     (lambda (path)
       (let ([from (car path)]
             [to (cadr path)])
         (hash-set! out-degree from (+ (hash-ref out-degree from 0) 1))
         (hash-set! in-degree to (+ (hash-ref in-degree to 0) 1))))
     paths)
    (for-each
     (lambda (city)
       (when (= (hash-ref out-degree city 0) 0)
         (display city)
         (newline)))
     (hash-keys out-degree))))