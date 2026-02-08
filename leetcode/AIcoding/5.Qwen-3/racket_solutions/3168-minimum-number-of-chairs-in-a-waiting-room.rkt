(define (min-chairs times)
  (define (parse-time time-str)
    (map string->number (string-split time-str ":")))

  (define (time->int time)
    (+ (* (car time) 60) (cadr time)))

  (define events
    (for/fold ([events '()]) ([time-str (in-list times)])
      (let* ([time (parse-time time-str)]
             [start (time->int (take time 2))]
             [end (time->int (drop time 2))])
        (append events (list (cons start 'start) (cons end 'end))))))

  (define sorted-events
    (sort events (lambda (a b)
                   (< (car a) (car b)))))

  (define (process-events events)
    (let loop ([events events] [current-chairs 0] [max-chairs 0])
      (cond [(null? events) max-chairs]
            [(eq? (cdr (car events)) 'start)
             (loop (cdr events) (+ current-chairs 1) (max max-chairs (+ current-chairs 1)))]
            [else
             (loop (cdr events) (- current-chairs 1) max-chairs)])))

  (process-events sorted-events))