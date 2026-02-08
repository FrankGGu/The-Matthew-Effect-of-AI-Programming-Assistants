#lang racket

(define (tweet-counts-per-frequency freq freq-unit tweets)
  (define (parse-time time-str)
    (string->number time-str))

  (define (time-to-units time)
    (cond [(equal? freq "Second") time]
          [(equal? freq "Minute") (quotient time 60)]
          [(equal? freq "Hour") (quotient time 3600)]
          [(equal? freq "Day") (quotient time 86400)]
          [(equal? freq "Week") (quotient time 604800)]
          [(equal? freq "Month") (quotient time 2592000)]
          [(equal? freq "Year") (quotient time 31536000)]
          [else 0]))

  (define (make-key key)
    (if (equal? freq "Second")
        key
        (format "~a" key)))

  (define (process-tweets)
    (define counts (make-hash))
    (for-each
     (lambda (tweet)
       (define time (parse-time (list-ref tweet 1)))
       (define key (time-to-units time))
       (hash-update! counts key (lambda (v) (add1 v)) 0))
     tweets)
    (hash->list counts))

  (define sorted (sort (process-tweets) (lambda (a b) (< (car a) (car b)))))

  (define (format-result)
    (map
     (lambda (pair)
       (list (make-key (car pair)) (cdr pair)))
     sorted))

  (format-result))