(define-struct passenger (start-station start-time))
(define-struct (station . time) (name time))

(define (make-underground-system)
  (let ((check-in-map (make-hash))
        (route-time-map (make-hash)))
    (lambda (cmd . args)
      (cond
        [(equal? cmd "checkIn")
         (hash-set! check-in-map (car args) (make-passenger (cadr args) (caddr args)))]
        [(equal? cmd "checkOut")
         (let* ([id (car args)]
                [end-station (cadr args)]
                [end-time (caddr args)]
                [start-info (hash-ref check-in-map id)]
                [start-station (passenger-start-station start-info)]
                [start-time (passenger-start-time start-info)])
           (hash-remove! check-in-map id)
           (let ([route-key (cons start-station end-station)])
             (let ([current (hash-ref route-time-map route-key (cons 0 0))])
               (let ([total-time (+ (car current) (- end-time start-time))]
                     [count (+ (cdr current) 1)])
                 (hash-set! route-time-map route-key (cons total-time count))))))]
        [(equal? cmd "getAverageTime")
         (let* ([start-station (car args)]
                [end-station (cadr args)]
                [route-key (cons start-station end-station)]
                [data (hash-ref route-time-map route-key (cons 0 0))]
                [total-time (car data)]
                [count (cdr data)])
           (/ total-time count))]))))