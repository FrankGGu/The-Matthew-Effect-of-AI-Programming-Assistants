#lang racket

(define (most-popular-video-creator creators ids likes)
  (define creator-data
    (for/fold ([acc '()])
              ([c creators] [i ids] [l likes])
      (cons (list c i l) acc)))

  (define total-likes
    (for/fold ([acc '()])
              ([data creator-data])
      (let ([c (first data)]
            [l (third data)])
        (if (assoc c acc)
            (map (lambda (x)
                   (if (equal? (car x) c)
                       (list c (+ (cadr x) l))
                       x))
                 acc)
            (cons (list c l) acc)))))

  (define max-like (apply max (map cadr total-likes)))

  (sort
   (filter (lambda (x) (= (cadr x) max-like))
           total-likes)
   (lambda (a b)
     (string<? (car a) (car b)))))