(define (count-tested-devices battery-percentages)
  (let loop ((bps battery-percentages) (count 0))
    (if (null? bps)
        count
        (loop (cdr bps) (+ count (if (> (car bps) 0) 1 0))))))

(define (main)
  (let ((input (read)))
    (display (count-tested-devices input))))