#lang racket

(define (num-of-gifts price special needs)
  (define (helper index current-needs)
    (if (>= index (length special))
        (apply + (map * price current-needs))
        (let* ((special-offer (list-ref special index))
               (offer-cost (list-ref special-offer 0))
               (offer-needs (take special-offer (length price))))
          (if (andmap (lambda (n1 n2) (<= n1 n2)) offer-needs current-needs)
              (min
               (helper (+ index 1) current-needs)
               (+ offer-cost
                  (helper 0
                          (map - current-needs offer-needs))))
              (helper (+ index 1) current-needs)))))
  (helper 0 needs))