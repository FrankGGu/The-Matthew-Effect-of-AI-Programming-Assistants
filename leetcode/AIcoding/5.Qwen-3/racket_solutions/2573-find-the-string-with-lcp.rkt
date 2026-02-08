#lang racket

(define (lcp a b)
  (define len (min (string-length a) (string-length b)))
  (let loop ([i 0])
    (if (or (= i len) (not (= (string-ref a i) (string-ref b i)))
           (and (= i len) (= (string-length a) (string-length b))))
        i
        (loop (+ i 1)))))

(define (find-string-with-lcp lcp n)
  (define (build s)
    (if (= (string-length s) n)
        s
        (let loop ([c #\a])
          (when (<= (char->integer c) (char->integer #\z))
            (define new-s (string-append s (string c)))
            (define valid? (andmap (lambda (i) (= (lcp new-s (list-ref lcp i)) (list-ref lcp i))) (range (string-length s))))
            (if valid?
                new-s
                (loop (integer->char (+ (char->integer c) 1)))))))
    (if (string=? s "")
        #f
        s)))

  (define (dfs s)
    (if (= (string-length s) n)
        s
        (let loop ([c #\a])
          (when (<= (char->integer c) (char->integer #\z))
            (define new-s (string-append s (string c)))
            (define valid? (andmap (lambda (i) (= (lcp new-s (list-ref lcp i)) (list-ref lcp i))) (range (string-length s))))
            (if valid?
                (let ([res (dfs new-s)])
                  (if res
                      res
                      (loop (integer->char (+ (char->integer c) 1))))
                (loop (integer->char (+ (char->integer c) 1)))))))
    #f))

  (dfs ""))