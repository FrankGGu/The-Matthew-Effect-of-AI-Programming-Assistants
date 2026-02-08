(define (most-Recent-Time pressed-time)
  (let loop ((times pressed-time) (max-time 0) (max-index -1) (index 0))
    (if (null? times)
        max-index
        (let ((current-time (car times)))
          (if (> current-time max-time)
              (loop (cdr times) current-time index (+ index 1))
              (loop (cdr times) max-time max-index (+ index 1)))))))