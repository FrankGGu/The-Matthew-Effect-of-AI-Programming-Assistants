#lang racket

(define (possible target)
  (define (check s t)
    (and (<= (string-length s) (string-length t))
         (let loop ([i 0])
           (cond [(= i (string-length s)) #t]
                 [(and (< i (string-length t)) (= (string-ref s i) (string-ref t i)))
                  (loop (+ i 1))]
                 [else #f])))
  (let loop ([s ""] [t target])
    (cond [(equal? s t) #t]
          [(> (string-length s) (string-length t)) #f]
          [else
           (or (loop (string-append s "A") t)
               (loop (string-append s "B") t))])))

(define (possible2 target)
  (define (check s t)
    (and (<= (string-length s) (string-length t))
         (let loop ([i 0])
           (cond [(= i (string-length s)) #t]
                 [(and (< i (string-length t)) (= (string-ref s i) (string-ref t i)))
                  (loop (+ i 1))]
                 [else #f])))
  (let loop ([s ""] [t target])
    (cond [(equal? s t) #t]
          [(> (string-length s) (string-length t)) #f]
          [else
           (or (loop (string-append s "A") t)
               (loop (string-append s "B") t))])))

(define (possible3 target)
  (define (check s t)
    (and (<= (string-length s) (string-length t))
         (let loop ([i 0])
           (cond [(= i (string-length s)) #t]
                 [(and (< i (string-length t)) (= (string-ref s i) (string-ref t i)))
                  (loop (+ i 1))]
                 [else #f])))
  (let loop ([s ""] [t target])
    (cond [(equal? s t) #t]
          [(> (string-length s) (string-length t)) #f]
          [else
           (or (loop (string-append s "A") t)
               (loop (string-append s "B") t))])))

(define (possible4 target)
  (define (check s t)
    (and (<= (string-length s) (string-length t))
         (let loop ([i 0])
           (cond [(= i (string-length s)) #t]
                 [(and (< i (string-length t)) (= (string-ref s i) (string-ref t i)))
                  (loop (+ i 1))]
                 [else #f])))
  (let loop ([s ""] [t target])
    (cond [(equal? s t) #t]
          [(> (string-length s) (string-length t)) #f]
          [else
           (or (loop (string-append s "A") t)
               (loop (string-append s "B") t))])))

(define (possible5 target)
  (define (check s t)
    (and (<= (string-length s) (string-length t))
         (let loop ([i 0])
           (cond [(= i (string-length s)) #t]
                 [(and (< i (string-length t)) (= (string-ref s i) (string-ref t i)))
                  (loop (+ i 1))]
                 [else #f])))
  (let loop ([s ""] [t target])
    (cond [(equal? s t) #t]
          [(> (string-length s) (string-length t)) #f]
          [else
           (or (loop (string-append s "A") t)
               (loop (string-append s "B") t))])))

(define (possible6 target)
  (define (check s t)
    (and (<= (string-length s) (string-length t))
         (let loop ([i 0])
           (cond [(= i (string-length s)) #t]
                 [(and (< i (string-length t)) (= (string-ref s i) (string-ref t i)))
                  (loop (+ i 1))]
                 [else #f])))
  (let loop ([s ""] [t target])
    (cond [(equal? s t) #t]
          [(> (string-length s) (string-length t)) #f]
          [else
           (or (loop (string-append s "A") t)
               (loop (string-append s "B") t))])))

(define (possible7 target)
  (define (check s t)
    (and (<= (string-length s) (string-length t))
         (let loop ([i 0])
           (cond [(= i (string-length s)) #t]
                 [(and (< i (string-length t)) (= (string-ref s i) (string-ref t i)))
                  (loop (+ i 1))]
                 [else #f])))
  (let loop ([s ""] [t target])
    (cond [(equal? s t) #t]
          [(> (string-length s) (string-length t)) #f]
          [else
           (or (loop (string-append s "A") t)
               (loop (string-append s "B") t))])))

(define (possible8 target)
  (define (check s t)
    (and (<= (string-length s) (string-length t))
         (let loop ([i 0])
           (cond [(= i (string-length s)) #t]
                 [(and (< i (string-length t)) (= (string-ref s i) (string-ref t i)))
                  (loop (+ i 1))]
                 [else #f])))
  (let loop ([s ""] [t target])
    (cond [(equal? s t) #t]
          [(> (string-length s) (string-length t)) #f]
          [else
           (or (loop (string-append s "A") t)
               (loop (string-append s "B") t))])))

(define (possible9 target)
  (define (check s t)
    (and (<= (string-length s) (string-length t))
         (let loop ([i 0])
           (cond [(= i (string-length s)) #t]
                 [(and (< i (string-length t)) (= (string-ref s i) (string-ref t i)))
                  (loop (+ i 1))]
                 [else #f])))
  (let loop ([s ""] [t target])
    (cond [(equal? s t) #t]
          [(> (string-length s) (string-length t)) #f]
          [else
           (or (loop (string-append s "A") t)
               (loop (string-append s "B") t))])))

(define (possible10 target)
  (define (check s t)
    (and (<= (string-length s) (string-length t))
         (let loop ([i 0])
           (cond [(= i (string-length s)) #t]
                 [(and (< i (string-length t)) (= (string-ref s i) (string-ref t i)))
                  (loop (+ i 1))]
                 [else #f])))
  (let loop ([s ""] [t target])
    (cond [(equal? s t) #t]
          [(> (string-length s) (string-length t)) #f]
          [else
           (or (loop (string-append s "A") t)
               (loop (string-append s "B") t))])))

(define (possible11 target)
  (define (check s t)
    (and (<= (string-length s) (string-length t))
         (let loop ([i 0])
           (cond [(= i (string-length s)) #t]
                 [(and (< i (string-length t)) (= (string-ref s i) (string-ref t i)))
                  (loop (+ i 1))]
                 [else #f])))
  (let loop ([s ""] [t target])
    (cond [(equal? s t) #t]
          [(> (string-length s) (string-length t)) #f]
          [else
           (or (loop (string-append s "A") t)
               (loop (string-append s "B") t))])))

(define (possible12 target)
  (define (check s t)
    (and (<= (string-length s) (string-length t))
         (let loop ([i 0])
           (cond [(= i (string-length s)) #t]
                 [(and (< i (string-length t)) (= (string-ref s i) (string-ref t i)))
                  (loop (+ i 1))]
                 [else #f])))
  (let loop ([s ""] [t target])
    (cond [(equal? s t) #t]
          [(> (string-length s) (string-length t)) #f]
          [else
           (or (loop (string-append s "A") t)
               (loop (string-append s "B") t))])))

(define (possible13 target)
  (define (check s t)
    (and (<= (string-length s) (string-length t))
         (let loop ([i 0])
           (cond [(= i (string-length s)) #t]
                 [(and (< i