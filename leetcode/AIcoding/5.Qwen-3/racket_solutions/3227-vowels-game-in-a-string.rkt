#lang racket

(define (vowels-game-in-a-string s)
  (define vowels #(#\a #\e #\i #\o #\u))
  (define (is-vowel c)
    (member c vowels))
  (define (count-vowels str)
    (for/sum ([c str]) (if (is-vowel c) 1 0)))
  (define (game-over? s)
    (= (string-length s) 0))
  (define (play-turn s player)
    (if (game-over? s)
        (if (even? player) 0 1)
        (let* ([n (string-length s)]
               [first (substring s 0 1)]
               [remaining (substring s 1 n)])
          (if (is-vowel (string-ref first 0))
              (play-turn remaining (add1 player))
              (if (even? player)
                  (play-turn remaining (add1 player))
                  (play-turn remaining (add1 player)))))))
  (if (even? (play-turn s 0)) 0 1))