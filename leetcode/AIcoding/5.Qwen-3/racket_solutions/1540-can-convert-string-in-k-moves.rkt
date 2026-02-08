#lang racket

(define (can-convert-string-in-k-moves s t k)
  (define freq (make-hash))
  (for ([c (in-string s)])
    (hash-set! freq c (+ 1 (hash-ref freq c 0))))
  (define (get-move c)
    (- (char->integer t) (char->integer c)))
  (define moves (for/list ([c (in-string s)])
                  (let ([d (get-move c)])
                    (if (= d 0) 0 (+ d 26)))))
  (define max-move (apply max moves))
  (and (equal? (sort (string->list s) char<?) (sort (string->list t) char<?))
       (<= max-move k)))