#lang racket

(define/contract (distance-between-bus-stops distance start destination)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (let* ((n (length distance))
         (start (modulo start n))
         (destination (modulo destination n))
         (min-index (min start destination))
         (max-index (max start destination))
         (sum1 (apply + (take distance min-index)))
         (sum2 (apply + (take distance max-index)))
         (sum3 (apply + (drop distance max-index)))
         (sum4 (apply + (drop distance min-index))))
    (if (= start destination)
        0
        (min (- sum2 sum1) (- sum4 sum3)))))