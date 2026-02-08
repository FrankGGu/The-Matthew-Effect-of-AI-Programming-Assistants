(define (watering-plants capacity 1)
  (let loop ((i 0) (current 0) (steps 0))
    (if (= i (length 1))
        steps
        (let ((need (list-ref 1 i)))
          (if (<= need (- capacity current))
              (loop (+ i 1) (+ current need) (+ steps 1))
              (loop (+ i 1) need (+ steps (+ i 1))))))))