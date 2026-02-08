#lang racket

(define (are-similar-words a b)
  (and (= (string-length a) (string-length b))
       (equal? a b)))

(define (split-string s)
  (string-split s " "))

(define (are-similar a b)
  (let ([a-list (split-string a)]
        [b-list (split-string b)])
    (or (and (= (length a-list) (length b-list))
             (for/and ([i (in-range (length a-list))])
               (are-similar-words (list-ref a-list i) (list-ref b-list i))))
        (and (> (length a-list) (length b-list))
             (let loop ([i 0] [j 0])
               (cond [(= j (length b-list)) #t]
                     [(and (= i (length a-list)) (< j (length b-list))) #f]
                     [(are-similar-words (list-ref a-list i) (list-ref b-list j))
                      (loop (+ i 1) (+ j 1))]
                     [else
                      (loop (+ i 1) j)])))
        (and (< (length a-list) (length b-list))
             (let loop ([i 0] [j 0])
               (cond [(= i (length a-list)) #t]
                     [(and (= j (length b-list)) (< i (length a-list))) #f]
                     [(are-similar-words (list-ref a-list i) (list-ref b-list j))
                      (loop (+ i 1) (+ j 1))]
                     [else
                      (loop i (+ j 1))]))))))

(define (are-similar-strings a b)
  (if (equal? a b)
      #t
      (let ([a-list (split-string a)]
            [b-list (split-string b)])
        (or (and (= (length a-list) (length b-list))
                 (for/and ([i (in-range (length a-list))])
                   (are-similar-words (list-ref a-list i) (list-ref b-list i))))
            (and (> (length a-list) (length b-list))
                 (let loop ([i 0] [j 0])
                   (cond [(= j (length b-list)) #t]
                         [(and (= i (length a-list)) (< j (length b-list))) #f]
                         [(are-similar-words (list-ref a-list i) (list-ref b-list j))
                          (loop (+ i 1) (+ j 1))]
                         [else
                          (loop (+ i 1) j)])))
            (and (< (length a-list) (length b-list))
                 (let loop ([i 0] [j 0])
                   (cond [(= i (length a-list)) #t]
                         [(and (= j (length b-list)) (< i (length a-list))) #f]
                         [(are-similar-words (list-ref a-list i) (list-ref b-list j))
                          (loop (+ i 1) (+ j 1))]
                         [else
                          (loop i (+ j 1))])))))))

(define (are-similar a b)
  (if (equal? a b)
      #t
      (let ([a-list (split-string a)]
            [b-list (split-string b)])
        (or (and (= (length a-list) (length b-list))
                 (for/and ([i (in-range (length a-list))])
                   (are-similar-words (list-ref a-list i) (list-ref b-list i))))
            (and (> (length a-list) (length b-list))
                 (let loop ([i 0] [j 0])
                   (cond [(= j (length b-list)) #t]
                         [(and (= i (length a-list)) (< j (length b-list))) #f]
                         [(are-similar-words (list-ref a-list i) (list-ref b-list j))
                          (loop (+ i 1) (+ j 1))]
                         [else
                          (loop (+ i 1) j)])))
            (and (< (length a-list) (length b-list))
                 (let loop ([i 0] [j 0])
                   (cond [(= i (length a-list)) #t]
                         [(and (= j (length b-list)) (< i (length a-list))) #f]
                         [(are-similar-words (list-ref a-list i) (list-ref b-list j))
                          (loop (+ i 1) (+ j 1))]
                         [else
                          (loop i (+ j 1))])))))))

(define (are-similar-words a b)
  (and (= (string-length a) (string-length b))
       (equal? a b)))

(define (are-similar a b)
  (if (equal? a b)
      #t
      (let ([a-list (split-string a)]
            [b-list (split-string b)])
        (or (and (= (length a-list) (length b-list))
                 (for/and ([i (in-range (length a-list))])
                   (are-similar-words (list-ref a-list i) (list-ref b-list i))))
            (and (> (length a-list) (length b-list))
                 (let loop ([i 0] [j 0])
                   (cond [(= j (length b-list)) #t]
                         [(and (= i (length a-list)) (< j (length b-list))) #f]
                         [(are-similar-words (list-ref a-list i) (list-ref b-list j))
                          (loop (+ i 1) (+ j 1))]
                         [else
                          (loop (+ i 1) j)])))
            (and (< (length a-list) (length b-list))
                 (let loop ([i 0] [j 0])
                   (cond [(= i (length a-list)) #t]
                         [(and (= j (length b-list)) (< i (length a-list))) #f]
                         [(are-similar-words (list-ref a-list i) (list-ref b-list j))
                          (loop (+ i 1) (+ j 1))]
                         [else
                          (loop i (+ j 1))]))))))