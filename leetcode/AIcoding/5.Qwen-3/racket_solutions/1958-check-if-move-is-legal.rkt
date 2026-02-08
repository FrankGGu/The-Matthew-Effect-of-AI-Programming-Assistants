#lang racket

(define (is-legal-move? board start end)
  (define (get-piece x y)
    (if (and (<= 0 x 7) (<= 0 y 7))
        (vector-ref (vector-ref board y) x)
        #f))
  (define (is-empty? x y)
    (equal? (get-piece x y) " "))
  (define (is-friendly? x y)
    (and (not (is-empty? x y)) (char-alphabet? (string-ref (get-piece x y) 0))))
  (define (is-enemy? x y)
    (and (not (is-empty? x y)) (not (is-friendly? x y))))
  (define (char-alphabet? c)
    (and (char>=? c #\A) (char<=? c #\Z)))
  (define (move-direction dx dy)
    (cond
      [(and (= dx 2) (= dy 1)) 'knight]
      [(and (= dx 1) (= dy 1)) 'pawn]
      [(or (= dx 1) (= dy 1)) 'rook]
      [(or (= dx 2) (= dy 2)) 'bishop]
      [else #f]))
  (define (check-pawn x1 y1 x2 y2)
    (let ([direction (if (char-lower-case? (string-ref (get-piece x1 y1) 0)) -1 1)])
      (cond
        [(and (= x1 x2) (= y2 (+ y1 direction)) (is-empty? x2 y2))
         #t]
        [(and (= x1 x2) (= y2 (+ y1 (* 2 direction))) (or (and (= y1 1) (char-lower-case? (string-ref (get-piece x1 y1) 0)))
                                                       (and (= y1 6) (char-upper-case? (string-ref (get-piece x1 y1) 0))))
         (and (is-empty? x2 y2) (is-empty? x2 (+ y1 direction)))]
        [(and (= (abs (- x2 x1)) 1) (= (- y2 y1) direction) (is-enemy? x2 y2))
         #t]
        [else #f])))
  (define (check-knight x1 y1 x2 y2)
    (and (or (and (= (abs (- x2 x1)) 2) (= (abs (- y2 y1)) 1))
             (and (= (abs (- x2 x1)) 1) (= (abs (- y2 y1)) 2)))
         (or (is-empty? x2 y2) (is-enemy? x2 y2))))
  (define (check-rook x1 y1 x2 y2)
    (define (check-line x1 y1 x2 y2 dx dy)
      (let loop ([x x1] [y y1])
        (cond
          [(and (= x x2) (= y y2)) #t]
          [(or (is-friendly? x y) (is-enemy? x y)) #f]
          [else (loop (+ x dx) (+ y dy))])))
    (cond
      [(= x1 x2) (check-line x1 y1 x2 y2 0 (if (> y2 y1) 1 -1))]
      [(= y1 y2) (check-line x1 y1 x2 y2 (if (> x2 x1) 1 -1) 0)]
      [else #f]))
  (define (check-bishop x1 y1 x2 y2)
    (define (check-diagonal x1 y1 x2 y2 dx dy)
      (let loop ([x x1] [y y1])
        (cond
          [(and (= x x2) (= y y2)) #t]
          [(or (is-friendly? x y) (is-enemy? x y)) #f]
          [else (loop (+ x dx) (+ y dy))])))
    (and (= (abs (- x2 x1)) (abs (- y2 y1)))
         (check-diagonal x1 y1 x2 y2 (if (> x2 x1) 1 -1) (if (> y2 y1) 1 -1))))
  (define (check-queen x1 y1 x2 y2)
    (or (check-rook x1 y1 x2 y2) (check-bishop x1 y1 x2 y2)))
  (define (check-king x1 y1 x2 y2)
    (and (<= (abs (- x2 x1)) 1)
         (<= (abs (- y2 y1)) 1)
         (or (is-empty? x2 y2) (is-enemy? x2 y2))))
  (define piece (get-piece (car start) (cadr start)))
  (cond
    [(equal? piece " ") #f]
    [(equal? (get-piece (car end) (cadr end)) (get-piece (car start) (cadr start))) #f]
    [else
     (let ([dx (abs (- (car end) (car start)))]
           [dy (abs (- (cadr end) (cadr start)))])
       (case (string-ref piece 0)
         [(#\P) (check-pawn (car start) (cadr start) (car end) (cadr end))]
         [(#\p) (check-pawn (car start) (cadr start) (car end) (cadr end))]
         [(#\R) (check-rook (car start) (cadr start) (car end) (cadr end))]
         [(#\r) (check-rook (car start) (cadr start) (car end) (cadr end))]
         [(#\N) (check-knight (car start) (cadr start) (car end) (cadr end))]
         [(#\n) (check-knight (car start) (cadr start) (car end) (cadr end))]
         [(#\B) (check-bishop (car start) (cadr start) (car end) (cadr end))]
         [(#\b) (check-bishop (car start) (cadr start) (car end) (cadr end))]
         [(#\Q) (check-queen (car start) (cadr start) (car end) (cadr end))]
         [(#\q) (check-queen (car start) (cadr start) (car end) (cadr end))]
         [(#\K) (check-king (car start) (cadr start) (car end) (cadr end))]
         [(#\k) (check-king (car start) (cadr start) (car end) (cadr end))]
         [else #f]))]))