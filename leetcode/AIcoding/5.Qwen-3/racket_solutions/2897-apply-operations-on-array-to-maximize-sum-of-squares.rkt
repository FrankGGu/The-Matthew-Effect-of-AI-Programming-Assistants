(define/contract (maximize-sum-of-squares nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([nums nums] [k k])
    (if (or (null? nums) (= k 0))
        (apply + (map (lambda (x) (* x x)) nums))
        (let* ([max-val (apply max nums)]
               [index (index-of nums max-val)]
               [new-nums (append (take nums index) (list (+ max-val 1)) (drop nums (+ index 1)))])
          (loop new-nums (- k 1))))))