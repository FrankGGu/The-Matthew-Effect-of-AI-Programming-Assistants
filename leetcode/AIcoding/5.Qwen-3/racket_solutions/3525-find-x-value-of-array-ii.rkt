(define/contract (find-x-value nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [sum 0] [total 0])
    (if (= i (length nums))
        i
        (let ([left-sum sum]
              [right-sum (- total sum (list-ref nums i))])
          (if (= left-sum right-sum)
              i
              (loop (+ i 1) (+ sum (list-ref nums i)) total))))))

(define/contract (main)
  (-> void?)
  (let ([nums (map string->number (string-split (read-line)))]
        [total (apply + (map string->number (string-split (read-line))))])
    (displayln (find-x-value nums))))