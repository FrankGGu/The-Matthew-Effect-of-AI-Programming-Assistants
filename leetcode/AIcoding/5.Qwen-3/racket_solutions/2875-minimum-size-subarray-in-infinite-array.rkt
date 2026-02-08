#lang racket

(define (min-subarray-len nums target)
  (define len (length nums))
  (define (get-index i) (modulo i len))
  (define (sum-from i j)
    (if (> i j)
        (+
         (apply + (take nums i))
         (apply + (drop nums j)))
        (apply + (take nums j))))
  (define (find-min)
    (let loop ((start 0) (end 0) (current-sum 0) (min-len #f))
      (cond
        [(= end (* 2 len)) min-len]
        [else
         (let ((current-end (get-index end)))
           (if (> current-sum target)
               (loop (add1 start) end (- current-sum (list-ref nums (get-index start))) min-len)
               (loop start (add1 end) (+ current-sum (list-ref nums current-end)) (if (<= current-sum target) (min min-len (- end start)) min-len))))])))
  (if (= (apply + nums) 0)
      (if (= target 0) len #f)
      (find-min)))