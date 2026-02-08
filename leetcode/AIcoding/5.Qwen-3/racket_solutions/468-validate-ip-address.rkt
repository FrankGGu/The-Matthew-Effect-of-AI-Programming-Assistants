#lang racket

(define (valid-ip-address ip)
  (define (is-ipv4? s)
    (define parts (string-split s #\.))
    (and (= (length parts) 4)
         (for/and ([p parts])
           (and (regexp-match-exact? #rx"^[0-9]+$" p)
                (<= (string->number p) 255)
                (or (= (string-length p) 1)
                    (and (not (char=? #\0 (string-ref p 0)))
                         (= (string-length p) 3)))))))

  (define (is-ipv6? s)
    (define parts (string-split s #\:))
    (and (= (length parts) 8)
         (for/and ([p parts])
           (and (regexp-match-exact? #rx"^[0-9a-fA-F]{1,4}$" p)))))

  (cond [(is-ipv4? ip) "IPv4"]
        [(is-ipv6? ip) "IPv6"]
        [else "Neither"]))

(define (main)
  (let ([input (read-line)])
    (displayln (valid-ip-address input))))

(main)