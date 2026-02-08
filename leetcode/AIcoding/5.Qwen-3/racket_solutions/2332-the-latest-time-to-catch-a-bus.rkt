#lang racket

(define (latest-time-to-catch-a-bus people time)
  (define (sort-times lst)
    (sort lst <))

  (define sorted-people (sort-times people))
  (define sorted-time (sort-times time))

  (define (find-latest bus-time)
    (cond [(null? sorted-people) bus-time]
          [(> (car sorted-people) bus-time) (car sorted-people)]
          [else (find-latest (cdr sorted-people))]))

  (define (find-maximum)
    (let loop ([i (sub1 (length sorted-time))] [last-person -1])
      (if (< i 0)
          (if (= last-person -1) (car sorted-time) last-person)
          (let ([bus-time (list-ref sorted-time i)])
            (if (and (not (null? sorted-people)) (<= (car sorted-people) bus-time))
                (loop (sub1 i) (car sorted-people))
                (loop (sub1 i) last-person))))))

  (let ([max-time (find-maximum)])
    (if (null? sorted-people)
        (car sorted-time)
        (if (> max-time (car sorted-people))
            max-time
            (if (= max-time (car sorted-people))
                (sub1 (car sorted-people))
                (car sorted-people)))))

  (define (main)
    (let ([sorted-people (sort-times people)]
          [sorted-time (sort-times time)])
      (let loop ([i (sub1 (length sorted-time))] [last-person -1])
        (if (< i 0)
            (if (= last-person -1) (car sorted-time) last-person)
            (let ([bus-time (list-ref sorted-time i)])
              (if (and (not (null? sorted-people)) (<= (car sorted-people) bus-time))
                  (loop (sub1 i) (car sorted-people))
                  (loop (sub1 i) last-person)))))))

  (main))